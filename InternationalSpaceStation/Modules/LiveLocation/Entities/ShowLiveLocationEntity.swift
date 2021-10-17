//
//  ShowLiveLocationEntity.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation
import MapKit
//{"iss_position": {"latitude": "-3.9879", "longitude": "-51.7569"}, "timestamp": 1634501902, "message": "success"}


struct ShowLiveLocationEntity: Codable {
 
    let iss_position: Location
    
    struct Location: Codable {
        
        let latitude: String
        let longitude: String
    }
    
}
