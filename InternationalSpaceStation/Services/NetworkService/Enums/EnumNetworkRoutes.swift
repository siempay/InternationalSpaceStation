//
//  EnumNetworkRoutes.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation


enum EnumNetworkRoutes: String {
    case liveLocation = "http://api.open-notify.org/iss-now.json"
    case getPassengers = "http://api.open-notify.org/astros.json"

}

extension EnumNetworkRoutes {
    
    var url: URL! {
        
        return URL.init(string: self.rawValue)
    }
}
