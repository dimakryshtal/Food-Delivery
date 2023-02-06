//
//  MapViewController.swift
//  Food Delivery
//
//  Created by Dima Kryshtal on 06.02.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: UpdateMapViewDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()

        addGestures()
    }


}


extension MapViewController {
    func addGestures() {
        
        let longMapGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressMap(_:)))
        mapView.addGestureRecognizer(longMapGesture)
        
    }
    
    @objc func didLongPressMap(_ sender: UITapGestureRecognizer? = nil) {
        if sender?.state == UIGestureRecognizer.State.ended {
            mapView.removeAnnotations(mapView.annotations)
            guard let touchLocation = sender?.location(in: mapView) else { return }
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            let pin = MKPointAnnotation()
            pin.coordinate = locationCoordinate
            let coordinateRegion = MKCoordinateRegion(center: pin.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
            mapView.setRegion(coordinateRegion, animated: true)
            mapView.addAnnotation(pin)
            
            delegate.updateMapView(locationCoordinate: locationCoordinate)
            delegate.updateLocationView(locationCoordinate: locationCoordinate)
            
        }
        
    }
}

