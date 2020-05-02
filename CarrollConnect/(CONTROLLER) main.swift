//
//  ViewController.swift
//  CarrollConnect
//
//  Created by 1 on 2020-04-30.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var mapView: MKMapView?
    var room: Room?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let mapView = mv()
        mapView.delegate = self
        view.addSubview(mapView)
        let controls: UISegmentedControl = mapView.setupcontrols(view: view)
        let room = Room(filename:"school")
        mapView.passInRoom(room: room)
       
        self.setupLayout(view: view, map: mapView, controls: controls)
        
    }
    
    
    private func setupLayout(view:UIView,map: MKMapView, controls: UISegmentedControl){
        NSLayoutConstraint.activate([
            controls.widthAnchor.constraint(equalTo: view.widthAnchor),
            controls.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            controls.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            map.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            map.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.95),
            map.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            map.topAnchor.constraint(equalTo: view.topAnchor),
            ])
        
    }
    
    
}

extension ViewController: MKMapViewDelegate{
    
    //Map checks for overlay, return that type of overlay and expects an overlayrenderer
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is mapOverLay{
            return RoomMapOverlayView(overlay: overlay, overlayImage: #imageLiteral(resourceName: "overlay_park") )
        }
    //If not of type mapOverlay, 
        return MKOverlayRenderer()
}
}
