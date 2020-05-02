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

class mapOverLay: NSObject, MKOverlay{
   var coordinate: CLLocationCoordinate2D
   var boundingMapRect: MKMapRect

   init(room: Room) {
    boundingMapRect = room.overlayBoundingMapRect
    coordinate = room.midCoordinate
   }
    
    
}
