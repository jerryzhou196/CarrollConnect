//
//  RoomMapOverlayView.swift
//  CarrollConnect
//
//  Created by 1 on 2020-04-30.
//  Copyright © 2020 1. All rights reserved.
//

import Foundation
import UIKit
import MapKit

// room (main) -> mapOverlay(room) -> RoomMapOverlayView(mapOverlay) run in delegate function if in area of overlay
//Used in the map delegate, which is run when it encounters specified area 

class RoomMapOverlayView: MKOverlayRenderer {
  var overlayImage: UIImage
  
  init(overlay:MKOverlay, overlayImage:UIImage) {
    self.overlayImage = overlayImage
    super.init(overlay: overlay)
  }
  
 //When the mapview realizes it is in an area with an overlay, it will call OverlayRenderer to draw
  override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
    guard let imageReference = overlayImage.cgImage else { return } //If no image stop process
    
    let rect = self.rect(for: overlay.boundingMapRect)
    print("I am a", context, "motherfucker")
    context.scaleBy(x: 1.0, y: -1.0)
    context.translateBy(x: 0.0, y: -rect.size.height)
    context.draw(imageReference, in: rect)
  }
}
