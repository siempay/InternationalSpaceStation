//
//  ShowPassengersInteractor.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation

protocol ShowPassengersInteractorDelegate {
 
	func didFinishLoadingPassengers(failure error: Error)
	func didFinishLoadingPassengers(success passengerEntity: ShowPassengerEntity?)
}

class ShowPassengersInteractor {
   
	var delegate: ShowPassengersInteractorDelegate?

    func loadPassengers() throws {
        
        try NetworkService.shared.makeRequest(.getPassengers) { [weak self] (result) in
            
            switch result {
            
				case .failure(let error):
					self?.delegate?.didFinishLoadingPassengers(failure: error)
					break
                
				case .success(let data):
                
					if let _data = data {
						do{
							let decoded = try ShowPassengerEntity.decode(_data)
							self?.delegate?.didFinishLoadingPassengers(success: decoded)
						}catch{
							self?.delegate?.didFinishLoadingPassengers(failure: error)
						}
					}else{
						self?.delegate?.didFinishLoadingPassengers(success: nil)
					}
            }
        }
    }
    
}
