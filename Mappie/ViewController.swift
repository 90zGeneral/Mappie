//
//  ViewController.swift
//  Mappie
//
//  Created by Roydon Jeffrey on 6/12/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a specific location for the map
        let lat: CLLocationDegrees = 7.0
        let long: CLLocationDegrees = 11.0
        let latDelta: CLLocationDegrees = 0.01
        let longDelta: CLLocationDegrees = 0.01
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        //Display the region on the map
        mapView.setRegion(region, animated: true)
    }
    
}

