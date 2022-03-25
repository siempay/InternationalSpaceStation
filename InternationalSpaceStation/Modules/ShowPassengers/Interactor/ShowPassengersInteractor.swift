//
//  ShowPassengersInteractor.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation

protocol ShowPassengersInteractorDelegate {

	typealias Result = Swift.Result<ShowPassengerEntity?, Error>
	
	func didFinishLoadingPassengers(result: Result)
}

class ShowPassengersInteractor {
   
	var delegate: ShowPassengersInteractorDelegate?

    func loadPassengers() throws {
        
        try NetworkService.shared.makeRequest(.getPassengers) { [weak self] (result) in
            
            switch result {
            
            case .failure(let error):
					self?.delegate?.didFinishLoadingPassengers(result: .failure(error))
					break
                
            case .success(let data):
                
                if let _data = data {
                    do{
                        let decoded = try ShowPassengerEntity.decode(_data)
						self?.delegate?.didFinishLoadingPassengers(result: .success(decoded))
                    }catch{
						self?.delegate?.didFinishLoadingPassengers(result: .failure(error))
					}
                }else{
					self?.delegate?.didFinishLoadingPassengers(result: .success(nil))
                }
            }
        }
    }
    
}
