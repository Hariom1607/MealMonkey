//
//  MapViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 13/08/25.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var lblChooseaSavedAddress: UILabel!
    @IBOutlet weak var btnShowtheSavedAddress: UIButton!
    @IBOutlet weak var btnSearchAddress: UIButton!
    @IBOutlet weak var txtSearchAddress: UITextField!
    @IBOutlet weak var btnRedirectToCurrentLocation: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var onLocationSelected: ((String) -> Void)?
    var hasCenteredOnUser = false
    var riderAnimationData: RiderAnimationData?
    
    let restaurantLocation = CLLocationCoordinate2D(latitude: 23.0070, longitude: 72.5645) // Manek Chowk, Ahmedabad
    var riderAnnotation: RiderAnnotation?
    
    private let bubbleTag = 999 // Used to identify & remove custom bubble views
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblChooseaSavedAddress.text = Main.map.lblChooseSavedAddress
        txtSearchAddress.placeholder = Main.map.txtSearchPlaceholder

        // Style search box
        styleViews([txtSearchAddress], cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding([txtSearchAddress])
        
        // Custom nav bar title with back button
        setLeftAlignedTitleWithBack(Main.BackBtnTitle.map, target: self, action: #selector(backBtnTapped))
        
        // Configure map and location manager
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request location permission
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Disable default user location pin
        mapView.showsUserLocation = false
        
        // Enable gestures
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = true
        
        // Tap anywhere on map to drop a pin
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check if a saved location exists
        let lat = UserDefaults.standard.double(forKey: Main.map.latitudeKey)
        let lon = UserDefaults.standard.double(forKey: Main.map.longitudeKey)
        
        if lat != 0 && lon != 0 {
            let savedCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let savedLocation = CLLocation(latitude: lat, longitude: lon)
            addCustomPin(at: savedLocation, title: Main.map.selectedLocation)
        } else if let location = currentLocation {
            // Fall back to user’s current location
            addCustomPin(at: location, title: Main.map.currentLocation)
        }
        
        let routeLat = UserDefaults.standard.double(forKey: "LastRouteLat")
        let routeLon = UserDefaults.standard.double(forKey: "LastRouteLon")
        
        if routeLat != 0 && routeLon != 0 {
            let destination = CLLocationCoordinate2D(latitude: routeLat, longitude: routeLon)
            showRouteFromRestaurant(to: destination)
        }
    }
    
    // MARK: - Navigation
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last, !hasCenteredOnUser {
            currentLocation = location
            
            let lat = UserDefaults.standard.double(forKey: Main.map.latitudeKey)
            let lon = UserDefaults.standard.double(forKey: Main.map.longitudeKey)
            
            if lat == 0 && lon == 0 {
                addCustomPin(at: location, title: Main.map.currentLocation)
            }
            
            hasCenteredOnUser = true
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Failed to get location:", error.localizedDescription)
    }
    
    // MARK: - Map Tap Handler
    @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: mapView)
        if let _ = mapView.hitTest(point, with: nil) as? MKAnnotationView { return }
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        let newLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        addCustomPin(at: newLocation, title: Main.map.selectedLocation)
    }
    
    // MARK: - Add Custom Pin + Address
    func addCustomPin(at location: CLLocation, title: String) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            guard let placemark = placemarks?.first else { return }
            
            var fullAddress = ""
            if let postalAddress = placemark.postalAddress {
                let formatter = CNPostalAddressFormatter()
                formatter.style = .mailingAddress
                fullAddress = formatter.string(from: postalAddress).replacingOccurrences(of: "\n", with: ", ")
            } else {
                fullAddress = [
                    placemark.subThoroughfare,
                    placemark.thoroughfare,
                    placemark.subLocality,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.postalCode,
                    placemark.country
                ].compactMap { $0 }.joined(separator: ", ")
            }
            
            UserDefaults.standard.set(fullAddress, forKey: Main.map.currentAddressKey)
            UserDefaults.standard.set(location.coordinate.latitude, forKey: Main.map.latitudeKey)
            UserDefaults.standard.set(location.coordinate.longitude, forKey: Main.map.longitudeKey)
            
            self.onLocationSelected?(fullAddress)
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = title
            annotation.subtitle = fullAddress
            self.mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    // MARK: - Show Route and Animate Rider
    func showRouteFromRestaurant(to destination: CLLocationCoordinate2D) {
        mapView.removeOverlays(mapView.overlays)
        if let rider = riderAnnotation {
            mapView.removeAnnotation(rider)
        }
        
        let restaurantPlacemark = MKPlacemark(coordinate: restaurantLocation)
        let userPlacemark = MKPlacemark(coordinate: destination)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: restaurantPlacemark)
        request.destination = MKMapItem(placemark: userPlacemark)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self, let route = response?.routes.first else { return }
            
            // Draw route
            self.mapView.addOverlay(route.polyline)
            
            // Distance & ETA
            let distanceInKm = route.distance / 1000
            let timeInMin = route.expectedTravelTime / 60
            
            // Show alert
            let alert = UIAlertController(title: "Rider Info",
                                          message: "Distance: \(String(format: "%.2f", distanceInKm)) km\nEstimated time: \(String(format: "%.0f", timeInMin)) min",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            
            // Add rider at restaurant
            let rider = RiderAnnotation(coordinate: self.restaurantLocation)
            self.riderAnnotation = rider
            self.mapView.addAnnotation(rider)
            
            // Animate rider in real-time along route
            self.animateRider(rider: rider, route: route)
        }
    }
    
    func animateRider(rider: RiderAnnotation, route: MKRoute) {
        let coords = route.polyline.coordinates
        guard coords.count > 1 else { return }
        
        let totalTime = route.expectedTravelTime
        let totalDistance = route.distance
        
        let displayLink = CADisplayLink(target: self, selector: #selector(updateRiderPosition))
        displayLink.add(to: .main, forMode: .common)
        
        riderAnimationData = RiderAnimationData(
            rider: rider,
            coordinates: coords,
            totalDistance: totalDistance,
            startTime: CACurrentMediaTime(),
            totalTime: totalTime,
            displayLink: displayLink
        )
    }
    
    @objc func updateRiderPosition() {
        guard let data = riderAnimationData else { return }
        
        let elapsed = CACurrentMediaTime() - data.startTime
        if elapsed >= data.totalTime {
            data.rider.coordinate = data.coordinates.last!
            data.displayLink.invalidate()
            riderAnimationData = nil
            return
        }
        
        // Calculate distance along route
        let targetDistance = (elapsed / data.totalTime) * data.totalDistance
        var coveredDistance: CLLocationDistance = 0
        
        for i in 0..<(data.coordinates.count - 1) {
            let start = CLLocation(latitude: data.coordinates[i].latitude, longitude: data.coordinates[i].longitude)
            let end = CLLocation(latitude: data.coordinates[i + 1].latitude, longitude: data.coordinates[i + 1].longitude)
            let segmentDistance = end.distance(from: start)
            
            if coveredDistance + segmentDistance >= targetDistance {
                let remaining = targetDistance - coveredDistance
                let fraction = remaining / segmentDistance
                let lat = start.coordinate.latitude + (end.coordinate.latitude - start.coordinate.latitude) * fraction
                let lon = start.coordinate.longitude + (end.coordinate.longitude - start.coordinate.longitude) * fraction
                data.rider.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                
                // Rotate scooter smoothly
                if let view = mapView.view(for: data.rider) {
                    let angle = bearing(from: start.coordinate, to: end.coordinate)
                    view.transform = CGAffineTransform(rotationAngle: angle)
                }
                break
            }
            
            coveredDistance += segmentDistance
        }
    }
    
    // MARK: - MapKit Helpers
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(overlay: polyline)
            renderer.strokeColor = UIColor.systemOrange
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is RiderAnnotation {
            let identifier = "Rider"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                let originalImage = UIImage(named: "ic_scooter")!
                let size = CGSize(width: 60, height: 60) // small like real apps
                UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
                originalImage.draw(in: CGRect(origin: .zero, size: size))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                view?.image = resizedImage
                view?.canShowCallout = false
            } else {
                view?.annotation = annotation
            }
            return view
        }
        
        // Skip default user location
        if annotation is MKUserLocation { return nil }
        
        let identifier = "CustomLocationPin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if view == nil {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view?.canShowCallout = false
            view?.image = UIImage(named: Main.map.locationPin)
        } else {
            view?.annotation = annotation
        }
        
        view?.subviews.filter { $0.tag == bubbleTag }.forEach { $0.removeFromSuperview() }
        return view
    }
    
    // MARK: - Helper: Bearing
    func bearing(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) -> CGFloat {
        let lat1 = start.latitude.toRadians()
        let lon1 = start.longitude.toRadians()
        let lat2 = end.latitude.toRadians()
        let lon2 = end.longitude.toRadians()
        
        let y = sin(lon2 - lon1) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1)
        return CGFloat(atan2(y, x))
    }
    
    // MARK: - Actions
    @IBAction func btnSearchAddressAction(_ sender: Any) {
        guard let address = txtSearchAddress.text, !address.isEmpty else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, _ in
            guard let self = self, let placemark = placemarks?.first, let location = placemark.location else { return }
            self.addCustomPin(at: location, title: Main.map.searchedLocation)
        }
    }
    
    @IBAction func btnRedirectToCurrentLocationAction(_ sender: Any) {
        if let location = currentLocation {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            addCustomPin(at: location, title: Main.map.currentLocation)
        }
    }
    
    @IBAction func btnShowSavedAddressAction(_ sender: Any) {
        guard let lat = UserDefaults.standard.value(forKey: Main.map.latitudeKey) as? Double,
              let lon = UserDefaults.standard.value(forKey: Main.map.longitudeKey) as? Double,
              lat != 0, lon != 0 else { return }
        
        let userLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        // Save as last route destination
        UserDefaults.standard.set(lat, forKey: "LastRouteLat")
        UserDefaults.standard.set(lon, forKey: "LastRouteLon")
        
        showRouteFromRestaurant(to: userLocation)
    }
    
}

// MARK: - Extensions
extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: self.pointCount)
        self.getCoordinates(&coords, range: NSRange(location: 0, length: self.pointCount))
        return coords
    }
}

extension Double {
    func toRadians() -> Double { return self * .pi / 180 }
}

// MARK: - Rider Annotation
class RiderAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}

struct RiderAnimationData {
    let rider: RiderAnnotation
    let coordinates: [CLLocationCoordinate2D]
    let totalDistance: CLLocationDistance
    let startTime: CFTimeInterval
    let totalTime: TimeInterval
    let displayLink: CADisplayLink
}
