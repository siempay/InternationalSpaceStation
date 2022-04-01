//
//  ShowLiveLocationInteractor.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation
import CoreLocation

protocol ShowLiveLocationInteractorDelegate {
    
	func didGetISSCurrentLocaltion(location: ShowLiveLocationEntity?)
	func didGetISSCurrentLocaltionFailed(error: Error)
	
	
	func didGetUserCurrentLocaltion(location: ShowLocationEntity?)
	func didGetUserCurrentLocaltionFailed(error: Error)
}

struct ShowLiveLocationInfo {
	
	let distance: Double
	let isAboveUser: Bool
}

class ShowLiveLocationInteractor: NSObject, CLLocationManagerDelegate {

    var delegate: ShowLiveLocationInteractorDelegate?

    
    // Create a CLLocationManager and assign a delegate
    let locationManager = CLLocationManager()

    /// Fetch live location and decode result
    func fetchISSLiveLocation() throws {
        
        try NetworkService.shared.makeRequest(.liveLocation) { (result) in
            
            switch result {
            
				case .failure(let error):
					self.delegate?.didGetISSCurrentLocaltionFailed(error: error)
					break
                
            case .success(let data):
                
                if let _data = data {
                    do{
                        let decoded = try ShowLiveLocationEntity.decode(_data)
						self.delegate?.didGetISSCurrentLocaltion(location: decoded)
                    }catch{
						self.delegate?.didGetISSCurrentLocaltionFailed(error: error)
                    }
                }else{
					self.delegate?.didGetISSCurrentLocaltion(location: nil)
                }
            }
        }
        
    }
    
    func getUserCurrentLocaltion() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Request a user’s location once
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()

    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        
        print(#function, Date(), locations)
        guard let coordinate = locations.first?.coordinate else { return }
        
		self.delegate?.didGetUserCurrentLocaltion(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(#function, error.localizedDescription)
		self.delegate?.didGetUserCurrentLocaltionFailed(error: error)
        
    }
	
	func isISSAboveUserLocation(userLocation: CLLocation, issLocation: CLLocation) -> ShowLiveLocationInfo {
		
		let result = userLocation.distance(from: issLocation)

		return .init(distance: result, isAboveUser: result < 1000)
	}
}
