//
//  (MODEL) Room.swift
//  CarrollConnect
//
//  Created by 1 on 2020-04-30.
//  Copyright © 2020 1. All rights reserved.
//

import Foundation

import UIKit
import MapKit



//The Room model init extracts data from the PList file
//Deseralizes plist into string dictionary
//Converts string dictionary to CGPoint()
//Uses CGPoint() for CLLocation point

//The overlayBoundingMapRect converts the CLLocation into MKMapPointsc

//Room model includes the getter, overlayBoundingMapRect which returns a MKMapRect with C

class Room {
      var name: String?
      
//    var boundary: [CLLocationCoordinate2D] = []
      
      var midCoordinate = CLLocationCoordinate2D()
      var overlayTopLeftCoordinate = CLLocationCoordinate2D()
      var overlayTopRightCoordinate = CLLocationCoordinate2D()
      var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
      var overlayBottomRightCoordinate: CLLocationCoordinate2D {
      get {
        return CLLocationCoordinate2DMake(overlayBottomLeftCoordinate.latitude,
                                          overlayTopRightCoordinate.longitude)
      }
    }
      
      var overlayBoundingMapRect: MKMapRect {
        get {
            let topLeft = MKMapPoint(overlayTopLeftCoordinate)
            let topRight = MKMapPoint(overlayTopRightCoordinate)
            let bottomLeft = MKMapPoint(overlayBottomLeftCoordinate)
    
            return MKMapRect(
                x: topLeft.x,
                y: topLeft.y,
                width: fabs(topLeft.x - topRight.x),
                height: fabs(topLeft.y - bottomLeft.y))
        }
    }
    
    init(filename: String) {
      guard let properties = Room.plist(filename) as? [String : Any] else { return }
     //Convert PList properties into a dictionary
     //[key: value] is the type definition for Dictionary
     
      midCoordinate = Room.parseCoord(dict: properties, fieldName: "midCoord")
      overlayTopLeftCoordinate = Room.parseCoord(dict: properties, fieldName: "overlayTopLeftCoord")
      overlayTopRightCoordinate = Room.parseCoord(dict: properties, fieldName: "overlayTopRightCoord")
      overlayBottomLeftCoordinate = Room.parseCoord(dict: properties, fieldName: "overlayBottomLeftCoord")
//    let boundaryPoints = properties["boundary"] as? [String] else { return }
//    let cgPoints = boundaryPoints.map { NSCoder.cgPoint(for: $0) }
//    boundary = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
    }
    class func plist(_ plist: String) -> Any?{
        let filePath = Bundle.main.path(forResource: plist, ofType: "plist")!
        
        //Gets serialized data
        let data = FileManager.default.contents(atPath: filePath)!
        
        //Deserializes data into a dictionary of string: string
        return try! PropertyListSerialization.propertyList(from: data, options: [[]], format: nil)
    }
    
    static func parseCoord(dict: [String: Any], fieldName: String) -> CLLocationCoordinate2D {
        guard let coord = dict[fieldName] as? String else {
            return CLLocationCoordinate2D()
        }
        //Converts x,y froms string to CGPoint
        let point = NSCoder.cgPoint(for: coord)
        
        //Creates a CLLocationCoordinate (can also directly use MKPoint with location and latitude) with CGPoint Object
        //CLLocationCoordinate makes it easier with directly-accessible properties
        return CLLocationCoordinate2DMake(CLLocationDegrees(point.x),CLLocationDegrees(point.y))
        
    }
}
