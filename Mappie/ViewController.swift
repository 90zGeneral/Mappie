//
//  ViewController.swift
//  Mappie
//
//  Created by Roydon Jeffrey on 6/12/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //Outlet
    @IBOutlet weak var mapView: MKMapView!
    
    //To represent the new annotations in the order they were created
    var number = 0.0
    
    //Location Manager
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegates
        mapView.delegate = self
        locationManager.delegate = self
        
        //Location configuration
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Create a specific location for the map
        let lat: CLLocationDegrees = 43.095181
        let long: CLLocationDegrees = -79.006424
        let latDelta: CLLocationDegrees = 0.05
        let longDelta: CLLocationDegrees = 0.05
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        //Display the region on the map
        mapView.setRegion(region, animated: false)
        
        //Create an annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Current Location"
        annotation.subtitle = "You are here now"
        mapView.addAnnotation(annotation)
        
        //Gesture Recognizer
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.lpgrAction(_:)))
        longPressGestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    //Delegate method to update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        print(locations)
        
        //Grab the user's exact location
        let userLocation: CLLocation = locations[0]
        let userLat = userLocation.coordinate.latitude
        let userLong = userLocation.coordinate.longitude
        
        //Setup the user's location to display on the map
        let userLatDelta: CLLocationDegrees = 0.05
        let userLongDelta: CLLocationDegrees = 0.05
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: userLat, longitude: userLong)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: userLatDelta, longitudeDelta: userLongDelta)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        //Convert the user's location into an address containing street number and name, city or state, zipcode, and country
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil {
                print(error.debugDescription)
                
            }else {
                let p = placemarks?[0]
                
                if let address = p {
                    
                    //Street number and name
                    var subThoroughfare = ""
                    
                    if (address.subThoroughfare != nil) {
                        subThoroughfare = address.subThoroughfare!
                    }
                    
                    print("\(subThoroughfare) \(String(describing: address.thoroughfare!)) \n \(String(describing: address.administrativeArea!)) \n \(String(describing: address.postalCode!)) \n \(String(describing: address.country!))")
                }
            }
        }
        
        //Display the user's location on the map
        mapView.setRegion(region, animated: false)
    }
    
    //Create a gesture recognizer
    func lpgrAction(_ gestureRecognizer: UIGestureRecognizer) {
        
        print("gesture recognized")
        
        //Grab the user's touch point and convert it into coordinates
        let userTouch = gestureRecognizer.location(in: mapView)
        let newCoordinates: CLLocationCoordinate2D = mapView.convert(userTouch, toCoordinateFrom: mapView)
        
        //Increment the number count
        number += 0.5
        
        //Create a new annotation for the new location
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        annotation.title = "New Location"
        annotation.subtitle = "touch point \(Int(number))"
        mapView.addAnnotation(annotation)
    }
    
}

