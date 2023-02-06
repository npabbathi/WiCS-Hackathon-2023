//
//  ViewController.swift
//  mag.net
//
//  Created by Ananya Chintalapudi on 2/4/23.
//
import CoreLocation
import MapKit
import UIKit

class ViewControllerMap: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    //let map = MKMapView()
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
//        let pin = MKPointAnnotation()
//        pin.coordinate = coordinate
//        mapView.addAnnotation(pin)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "Nidhi"
        pin.subtitle = "Mentor"
        mapView.addAnnotation(pin)
        
        let pin2 = MKPointAnnotation()
        pin2.coordinate = CLLocationCoordinate2D(latitude: 30.2869, longitude: -97.7395)
        pin2.title = "Ananya"
        pin2.subtitle = "Mentor"
        mapView.addAnnotation(pin2)
        
        let pin3 = MKPointAnnotation()
        pin3.coordinate = CLLocationCoordinate2D(latitude: 30.2841, longitude: -97.7377)
        pin3.title = "Karnika"
        pin3.subtitle = "Mentee"
        mapView.addAnnotation(pin3)
        
        let pin4 = MKPointAnnotation()
        pin4.coordinate = CLLocationCoordinate2D(latitude: 30.2862, longitude: -97.7394)
        pin4.title = "Allison"
        pin4.subtitle = "Mentee"
        mapView.addAnnotation(pin4)
    }
    

}

