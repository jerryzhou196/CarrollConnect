//
//  self.swift
//  CarrollConnect
//
//  Created by 1 on 2020-04-30.
//  Copyright © 2020 1. All rights reserved.
//

import Foundation
import UIKit
import MapKit

let items = ["Standard", "Satellite", "Hybrid", "SatelliteFlyover", "MutedStandard"]
class mv: MKMapView{
    
    var room: Room?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //LOCATION SETUPT
        let intialLocation = CLLocation(latitude: 51.012915,longitude: -114.120575)
        self.centerToLocation(intialLocation)
        let region = MKCoordinateRegion(
          center: intialLocation.coordinate,
          latitudinalMeters: 200,
          longitudinalMeters: 200)
        self.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 450)
        self.setCameraZoomRange(zoomRange, animated: true)
    }
    
    func passInRoom(room: Room) {
        self.room = room
       }
    
    func addOverlay(){
        let overlay = mapOverLay(room: room!) //Creates the MKOverlayObject with the room model
        self.addOverlay(overlay)
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
      let coordinateRegion = MKCoordinateRegion(
        center: location.coordinate,
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
        self.setRegion(coordinateRegion, animated: true)
    }
    func setupcontrols(view: UIView) -> UISegmentedControl{
        let controls = UISegmentedControl(items: items)
        controls.addTarget(self, action: #selector(changeFloor(_:)), for: .valueChanged)
        view.addSubview(controls)
        controls.translatesAutoresizingMaskIntoConstraints = false
        return controls
    }
    
    @objc func changeFloor(_ controls: UISegmentedControl){
        switch controls.selectedSegmentIndex {
        case 0:
            self.mapType = MKMapType.init(rawValue: UInt(0)) ?? .standard
        case 1:
            self.mapType = MKMapType.init(rawValue: UInt(1)) ?? .standard
        case 2:
            self.mapType = MKMapType.init(rawValue: UInt(2)) ?? .standard
        case 3:
            self.mapType = MKMapType.init(rawValue: UInt(3)) ?? .standard
        case 4:
             self.addOverlay()

        default:
            self.mapType = MKMapType.init(rawValue: UInt(0)) ?? .standard
        }
    }
}
