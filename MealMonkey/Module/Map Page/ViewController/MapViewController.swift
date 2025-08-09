//
//  MapViewController.swift
//  MealMonkey
//
//  Created by Hariom Sharma on 08/08/25.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Change Address", target: self, action: #selector(backBtnTapped))
    }
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
