//
//  ShowLiveLocationFormatter.swift
//  InternationalSpaceStation
//
//  Created by Brahim Elmssilha on 31/3/2022.
//

import Foundation
import MapKit


class ShowLiveLocationFormatter {
	
	static func formatLocation(location: ShowLiveLocationEntity.Location?) -> (lt: Double, lg: Double)? {
		
		guard let location = location else { return nil }
		
		guard
			let lt = Double(location.latitude),
			let lg = Double(location.longitude)
				
		else { return nil }
		
		return (lt, lg)
		
	}
	
	static func formatLiveLocation(location: ShowLiveLocationEntity.Location?) -> CLLocation? {
		
		guard let location = location else { return nil }

 		guard
			let lt = Double(location.latitude),
			let lg = Double(location.longitude)
				
		else { return nil }
		
		return .init(latitude: lt, longitude: lg)
		
	}
	
	static func formatUserLocation(location: ShowLocationEntity?) -> CLLocation? {
		
		guard let location = location else { return nil }
		
		return .init(latitude: location.latitude, longitude: location.longitude)
		
	}
	
	static func formatResult(info result: ShowLiveLocationInfo) -> String? {
		 
		let formatter = MKDistanceFormatter()
		
		let string = formatter.string(fromDistance: result.distance)
		
		if result.isAboveUser {
			return "ISS is above you!"
		}
		return "Distance from ISS:\n \(string)"
	}
	 
}
