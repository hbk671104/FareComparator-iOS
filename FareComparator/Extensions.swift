//
//  Extensions.swift
//  FareComparator
//
//  Created by BK on 15/10/2016.
//  Copyright © 2016 Bokang Huang. All rights reserved.
//

import Foundation

extension MAMapView {
    
    func resetUserLocation(userLocation: CLLocation) {
        let status = MAMapStatus.init(center: userLocation.coordinate,
                                      zoomLevel: 15,
                                      rotationDegree: 0,
                                      cameraDegree: 0,
                                      screenAnchor: CGPoint(x: 0.5, y: 0.5))
        self.setMapStatus(status, animated: true)
    }
    
}
