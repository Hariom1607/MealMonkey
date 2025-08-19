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
    
    private let bubbleTag = 999 // Used to identify & remove custom bubble views
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style search box
        styleViews([txtSearchAddress], cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding([txtSearchAddress])
        
        // Custom nav bar title with back button
        setLeftAlignedTitleWithBack("Change Address", target: self, action: #selector(backBtnTapped))
        
        // Configure map and location manager
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request location permission
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // We draw our own pin & bubble → disable default user location pin
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
    
    // MARK: - Navigation
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Center on user location only once
        if let location = locations.last, !hasCenteredOnUser {
            currentLocation = location
            addCustomPin(at: location, title: "Your Current Location")
            hasCenteredOnUser = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Failed to get location:", error.localizedDescription)
    }
    
    // MARK: - Map Tap Handler
    @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: mapView)
        
        // If tap was on a pin → ignore (pin handles its own gestures)
        if let _ = mapView.hitTest(point, with: nil) as? MKAnnotationView { return }
        
        // Convert screen tap → coordinates
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        let newLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        addCustomPin(at: newLocation, title: "Selected Location")
    }
    
    // MARK: - Add Custom Pin + Address
    func addCustomPin(at location: CLLocation, title: String) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            guard let placemark = placemarks?.first else { return }
            
            // Format address string
            var fullAddress = ""
            if let postalAddress = placemark.postalAddress {
                // Best formatted address
                let formatter = CNPostalAddressFormatter()
                formatter.style = .mailingAddress
                fullAddress = formatter
                    .string(from: postalAddress)
                    .replacingOccurrences(of: "\n", with: ", ")
            } else {
                // Fallback if no postalAddress
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
            
            // Save address + coords in UserDefaults
            UserDefaults.standard.set(fullAddress, forKey: "currentAddress")
            UserDefaults.standard.set(location.coordinate.latitude, forKey: "currentLatitude")
            UserDefaults.standard.set(location.coordinate.longitude, forKey: "currentLongitude")
            
            // Pass selected address back (if callback provided)
            self.onLocationSelected?(fullAddress)
            
            // Remove old pins, add new one
            self.mapView.removeAnnotations(self.mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = title
            annotation.subtitle = fullAddress
            self.mapView.addAnnotation(annotation)
            
            // Center on new pin
            let region = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        // Remove bubble when pin is deselected
        view.subviews.filter { $0.tag == bubbleTag }.forEach { $0.removeFromSuperview() }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Skip default user location
        if annotation is MKUserLocation { return nil }
        
        let identifier = "CustomLocationPin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if view == nil {
            // Create new annotation view
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view?.canShowCallout = false // disable default bubble
            view?.image = UIImage(named: "Ic_Location_Pin")
            
            // Add double-tap recognizer → show bubble
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleAnnotationDoubleTap(_:)))
            doubleTap.numberOfTapsRequired = 2
            doubleTap.cancelsTouchesInView = true
            view?.addGestureRecognizer(doubleTap)
        } else {
            // Reuse annotation view
            view?.annotation = annotation
            
            // Ensure it has a double-tap recognizer
            if view?.gestureRecognizers?.contains(where: {
                guard let tap = $0 as? UITapGestureRecognizer else { return false }
                return tap.numberOfTapsRequired == 2
            }) == false {
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleAnnotationDoubleTap(_:)))
                doubleTap.numberOfTapsRequired = 2
                doubleTap.cancelsTouchesInView = true
                view?.addGestureRecognizer(doubleTap)
            }
        }
        
        // Remove any existing bubble before reusing
        view?.subviews.filter { $0.tag == bubbleTag }.forEach { $0.removeFromSuperview() }
        return view
    }
    
    // MARK: - Bubble Handling
    @objc private func handleAnnotationDoubleTap(_ gr: UITapGestureRecognizer) {
        guard let view = gr.view as? MKAnnotationView,
              let annotation = view.annotation else { return }
        
        // Remove existing bubble → toggling behavior
        view.subviews.filter { $0.tag == bubbleTag }.forEach { $0.removeFromSuperview() }
        showBubble(for: view, annotation: annotation)
    }
    
    private func showBubble(for annotationView: MKAnnotationView, annotation: MKAnnotation) {
        let titleText = (annotation.title ?? "Location") ?? "Location"
        let addressText = (annotation.subtitle ?? "") ?? ""
        
        // Layout constants
        let bubbleWidth: CGFloat = 220
        let pointerHeight: CGFloat = 10
        let cornerRadius: CGFloat = 10
        let paddingH: CGFloat = 10
        let paddingTop: CGFloat = 8
        let paddingBottom: CGFloat = 10
        let labelSpacing: CGFloat = 4
        
        let titleFont = UIFont.boldSystemFont(ofSize: 14)
        let bodyFont = UIFont.systemFont(ofSize: 12)
        
        // Dynamically calculate text height
        let maxTextWidth = bubbleWidth - (paddingH * 2)
        let addrBounds = (addressText as NSString).boundingRect(
            with: CGSize(width: maxTextWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: bodyFont],
            context: nil
        )
        let titleHeight: CGFloat = ceil(titleFont.lineHeight)
        let addressHeight: CGFloat = ceil(addrBounds.height)
        let bubbleHeight = paddingTop + titleHeight + labelSpacing + addressHeight + paddingBottom
        
        // Container view (bubble + pointer)
        let containerHeight = bubbleHeight + pointerHeight
        let container = UIView(frame: CGRect(
            x: (annotationView.bounds.width - bubbleWidth)/2,
            y: -containerHeight - 4, // position above pin
            width: bubbleWidth,
            height: containerHeight
        ))
        container.backgroundColor = .clear
        container.tag = bubbleTag
        container.alpha = 0
        container.transform = CGAffineTransform(translationX: 0, y: 8) // start animation below
        
        // Bubble rectangle
        let bubbleView = UIView(frame: CGRect(x: 0, y: 0, width: bubbleWidth, height: bubbleHeight))
        bubbleView.backgroundColor = UIColor(red: 252/255, green: 96/255, blue: 17/255, alpha: 1.0) // Orange color #FC6011
        bubbleView.layer.cornerRadius = cornerRadius
        bubbleView.clipsToBounds = true
        
        // Title label
        let titleLabel = UILabel(frame: CGRect(x: paddingH, y: paddingTop, width: maxTextWidth, height: titleHeight))
        titleLabel.textColor = .white
        titleLabel.font = titleFont
        titleLabel.text = titleText
        bubbleView.addSubview(titleLabel)
        
        // Address label (multi-line)
        let addressLabel = UILabel(frame: CGRect(x: paddingH,
                                                 y: paddingTop + titleHeight + labelSpacing,
                                                 width: maxTextWidth,
                                                 height: addressHeight))
        addressLabel.textColor = .white
        addressLabel.font = bodyFont
        addressLabel.numberOfLines = 0
        addressLabel.lineBreakMode = .byWordWrapping
        addressLabel.text = addressText
        bubbleView.addSubview(addressLabel)
        
        // Pointer triangle
        let pointerLayer = CAShapeLayer()
        let path = UIBezierPath()
        let pointerWidth: CGFloat = 16
        let tipX = bubbleWidth / 2
        path.move(to: CGPoint(x: tipX - pointerWidth/2, y: bubbleHeight))
        path.addLine(to: CGPoint(x: tipX, y: bubbleHeight + pointerHeight))
        path.addLine(to: CGPoint(x: tipX + pointerWidth/2, y: bubbleHeight))
        path.close()
        pointerLayer.path = path.cgPath
        pointerLayer.fillColor = bubbleView.backgroundColor?.cgColor
        
        // Assemble bubble + pointer
        container.addSubview(bubbleView)
        container.layer.addSublayer(pointerLayer)
        annotationView.addSubview(container)
        
        // Animate bubble appearance
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut]) {
            container.alpha = 1
            container.transform = .identity
        }
    }
    
    // MARK: - Actions
    @IBAction func btnSearchAddressAction(_ sender: Any) {
        guard let address = txtSearchAddress.text, !address.isEmpty else { return }
        
        // Geocode typed address → drop pin
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, _ in
            guard let self = self,
                  let placemark = placemarks?.first,
                  let location = placemark.location else { return }
            self.addCustomPin(at: location, title: "Searched Location")
        }
    }
    
    @IBAction func btnRedirectToCurrentLocationAction(_ sender: Any) {
        // Zoom to user's last known location
        if let location = currentLocation {
            let region = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            addCustomPin(at: location, title: "Your Current Location")
        }
    }
    
    @IBAction func btnShowSavedAddressAction(_ sender: Any) {
        // Load saved address from UserDefaults
        let lat = UserDefaults.standard.double(forKey: "currentLatitude")
        let lon = UserDefaults.standard.double(forKey: "currentLongitude")
        if lat != 0 && lon != 0 {
            let savedLocation = CLLocation(latitude: lat, longitude: lon)
            addCustomPin(at: savedLocation, title: "Saved Location")
        }
    }
}
