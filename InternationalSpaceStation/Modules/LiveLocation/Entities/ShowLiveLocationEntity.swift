//
//  ShowLiveLocationEntity.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation

struct ShowLiveLocationEntity: Codable {
 
    let iss_position: Location
    
    struct Location: Codable {
        
        let latitude: String
        let longitude: String
    }
    
}
