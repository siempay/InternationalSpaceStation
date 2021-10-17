//
//  ShowPassengersInteractor.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation

protocol IShowPassengersInteractor: AnyInteractor {
    func loadPassengers() throws

}


class ShowPassengersInteractor: IShowPassengersInteractor {
   
    var presenter: AnyPresenter?
    var _presenter: IShowPassengersPresenter? { presenter as? IShowPassengersPresenter }

    func loadPassengers() throws {
        
        try NetworkService.shared.makeRequest(.getPassengers) { [weak self] (result) in
            
            switch result {
            
            case .failure(let error):
                self?._presenter?.didFinishLoadingPassengers(with: error)
                break
                
            case .success(let data):
                
                if let _data = data {
                    do{
                        let decoded = try ShowPassengerEntity.decode(_data)
                        self?._presenter?.didLoadPassengers(decoded)
                    }catch{
                        self?._presenter?.didFinishLoadingPassengers(with: error)
                    }
                }else{
                    self?._presenter?.didLoadPassengers(nil)
                }
            }
        }
    }
    
}
