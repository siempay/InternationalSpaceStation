//
//  ShowLiveLocationInteractor.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation
import CoreLocation

protocol ShowLiveLocationInteractorDelegate {
    
	func didGetUserCurrentLocaltion(location: ShowLocationEntity?)
	func didGetUserCurrentLocaltionFailed(error: Error)
}

class ShowLiveLocationInteractor: NSObject, CLLocationManagerDelegate {

    var delegate: ShowLiveLocationInteractorDelegate?

    
    // Create a CLLocationManager and assign a delegate
    let locationManager = CLLocationManager()

    /// Fetch live location and decode result
    func fetchISSLiveLocation(_ completion: @escaping (Result<ShowLiveLocationEntity?, Error>) -> ()) throws {
        
        try NetworkService.shared.makeRequest(.liveLocation) { (result) in
            
            switch result {
            
            case .failure(let error):
                completion(.failure(error))
                break
                
            case .success(let data):
                
                if let _data = data {
                    do{
                        let decoded = try ShowLiveLocationEntity.decode(_data)
                        completion(.success(decoded))
                    }catch{
                        completion(.failure(error))
                    }
                }else{
                    completion(.success(nil))
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
}
