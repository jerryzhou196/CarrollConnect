//
//  SchoolModel.swift
//  CarrollConnect
//
//  Created by 1 on 2020-04-30.
//  Copyright © 2020 1. All rights reserved.
//

import Foundation
import UIKit
import MapKit

//Used to instaniate the actual MKOverlayObject itself
//Calls the overlayBoundingMapRect
//Sets the bounds of the overlay view

class mapOverLay: NSObject, MKOverlay{
   var coordinate: CLLocationCoordinate2D
    
   //Overrides the boundingMapRect which is used by the map to determine if it is in the overlay area 
   var boundingMapRect: MKMapRect

   init(room: Room) {
    boundingMapRect = room.overlayBoundingMapRect
    coordinate = room.midCoordinate
   }
    
    
}
