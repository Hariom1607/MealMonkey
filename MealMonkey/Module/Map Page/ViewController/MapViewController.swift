//
//  MapViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var btnSavedAddress: UIButton!
    @IBOutlet weak var txtSearchAddress: UITextField!
    @IBOutlet weak var btnChangeLocation: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var hasCenteredOnUser = false  // prevent re-centering multiple times
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        setupLocationManager()
        
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Center only the first time automatically
        if !hasCenteredOnUser {
            let region = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            hasCenteredOnUser = true
        }
    }
    
    
    
    
    @IBAction func btnCurrentLocationTapped(_ sender: Any) {
        locationManager.startUpdatingLocation()
        
    }
    
    @IBAction func btnChooseSavedAddress(_ sender: Any) {
    }
    
}
