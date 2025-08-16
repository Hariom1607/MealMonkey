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
    
    @IBOutlet weak var btnShowtheSavedAddress: UIButton!
    @IBOutlet weak var btnSearchAddress: UIButton!
    @IBOutlet weak var txtSearchAddress: UITextField!
    @IBOutlet weak var btnRedirectToCurrentLocation: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var onLocationSelected: ((String) -> Void)?
    var hasCenteredOnUser = false
    
    private let bubbleTag = 999
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleViews([txtSearchAddress], cornerRadius: 28, borderWidth: 0, borderColor: UIColor.black.cgColor)
        setTextFieldPadding([txtSearchAddress])
        
        setLeftAlignedTitleWithBack("Change Address", target: self, action: #selector(backBtnTapped))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request permission & start updating
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // We draw our own pin & bubble
        mapView.showsUserLocation = false
        
        // Gestures
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = true
        
        // Tap anywhere to drop a pin
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last, !hasCenteredOnUser {
            currentLocation = location
            addCustomPin(at: location, title: "Your Current Location")
            hasCenteredOnUser = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location:", error.localizedDescription)
    }
    
    @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: mapView)
        // If tap lands on an annotation view, ignore (pin double-tap is handled on the pin)
        if let hitView = mapView.hitTest(point, with: nil) as? MKAnnotationView {
            // Do nothing; the pin handles its own gestures
            return
        }
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        let newLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        addCustomPin(at: newLocation, title: "Selected Location")
    }
    
    func addCustomPin(at location: CLLocation, title: String) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            guard let placemark = placemarks?.first else { return }
            
            var fullAddress = ""
            if let postalAddress = placemark.postalAddress {
                let formatter = CNPostalAddressFormatter()
                formatter.style = .mailingAddress
                fullAddress = formatter
                    .string(from: postalAddress)
                    .replacingOccurrences(of: "\n", with: ", ")
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
            
            // Save address & coords
            UserDefaults.standard.set(fullAddress, forKey: "currentAddress")
            UserDefaults.standard.set(location.coordinate.latitude, forKey: "currentLatitude")
            UserDefaults.standard.set(location.coordinate.longitude, forKey: "currentLongitude")
            self.onLocationSelected?(fullAddress)
            
            // Replace any existing annotations
            self.mapView.removeAnnotations(self.mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = title
            annotation.subtitle = fullAddress
            self.mapView.addAnnotation(annotation)
            
            // Center map
            let region = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.subviews.filter { $0.tag == bubbleTag }.forEach { $0.removeFromSuperview() }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        let identifier = "CustomLocationPin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if view == nil {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view?.canShowCallout = false // no default callout
            view?.image = UIImage(named: "Ic_Location_Pin")
            
            // Double-tap recognizer on the PIN (not the map)
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleAnnotationDoubleTap(_:)))
            doubleTap.numberOfTapsRequired = 2
            doubleTap.cancelsTouchesInView = true
            view?.addGestureRecognizer(doubleTap)
        } else {
            view?.annotation = annotation
            // Ensure only one double-tap recognizer is attached
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
        
        view?.subviews.filter { $0.tag == bubbleTag }.forEach { $0.removeFromSuperview() }
        return view
    }
    
    @objc private func handleAnnotationDoubleTap(_ gr: UITapGestureRecognizer) {
        guard let view = gr.view as? MKAnnotationView,
              let annotation = view.annotation else { return }
        
        // Remove any existing bubble (toggle behavior)
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
        
        // Measure address height so nothing is truncated
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
        
        // Container that also holds the pointer triangle
        let containerHeight = bubbleHeight + pointerHeight
        let container = UIView(frame: CGRect(
            x: (annotationView.bounds.width - bubbleWidth)/2,
            y: -containerHeight - 4, // above the pin, anchored to bottom tip
            width: bubbleWidth,
            height: containerHeight
        ))
        container.backgroundColor = .clear
        container.tag = bubbleTag
        container.alpha = 0
        container.transform = CGAffineTransform(translationX: 0, y: 8) // start near pin tip
        
        // Bubble (rounded rectangle)
        let bubbleView = UIView(frame: CGRect(x: 0, y: 0, width: bubbleWidth, height: bubbleHeight))
        bubbleView.backgroundColor = UIColor(red: 252/255, green: 96/255, blue: 17/255, alpha: 1.0) // #FC6011
        bubbleView.layer.cornerRadius = cornerRadius
        bubbleView.clipsToBounds = true
        
        // Title
        let titleLabel = UILabel(frame: CGRect(x: paddingH, y: paddingTop, width: maxTextWidth, height: titleHeight))
        titleLabel.textColor = .white
        titleLabel.font = titleFont
        titleLabel.text = titleText
        bubbleView.addSubview(titleLabel)
        
        // Address (multi-line)
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
        
        // Pointer triangle (downward)
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
        
        // Assemble
        container.addSubview(bubbleView)
        container.layer.addSublayer(pointerLayer)
        annotationView.addSubview(container)
        
        // Animate in
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut]) {
            container.alpha = 1
            container.transform = .identity
        }
    }
    
    @IBAction func btnSearchAddressAction(_ sender: Any) {
        guard let address = txtSearchAddress.text, !address.isEmpty else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, _ in
            guard let self = self,
                  let placemark = placemarks?.first,
                  let location = placemark.location else { return }
            self.addCustomPin(at: location, title: "Searched Location")
        }
    }
    
    @IBAction func btnRedirectToCurrentLocationAction(_ sender: Any) {
        if let location = currentLocation {
            let region = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            addCustomPin(at: location, title: "Your Current Location")
        }
    }
    
    @IBAction func btnShowSavedAddressAction(_ sender: Any) {
        let lat = UserDefaults.standard.double(forKey: "currentLatitude")
        let lon = UserDefaults.standard.double(forKey: "currentLongitude")
        if lat != 0 && lon != 0 {
            let savedLocation = CLLocation(latitude: lat, longitude: lon)
            addCustomPin(at: savedLocation, title: "Saved Location")
        }
    }
}
