//
//  Location.swift
//  ToDo
//
//  Created by CoderDream on 2019/9/16.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    init(name: String,
         coordinate: CLLocationCoordinate2D? = nil) {
        self.name = ""
        self.coordinate = coordinate
    }
}
