//
//  ShowPassengerEntity.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation

// {"number": 10, "people": [{"craft": "ISS", "name": "Mark Vande Hei"}

struct ShowPassengerEntity: Codable {
    
    let number: Int
    let people: [Passenger]
    
    struct Passenger: Codable {
        let craft: String
        let name: String
    }
    
}
