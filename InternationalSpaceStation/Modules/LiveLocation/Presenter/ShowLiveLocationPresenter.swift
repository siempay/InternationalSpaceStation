//
//  ShowLiveLocationPresentor.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation

protocol IShowLiveLocationPresenter: AnyPresenter {
    
    func onMapDidLoad()
    func updateUserLocation(coordinate: ShowLocationEntity?)
}

/// THis hanlds events comming from the view
/// and calls the interactor for help with fetching data
class ShowLiveLocationPresenter: IShowLiveLocationPresenter {
  
   
    var router: AnyRouter?
    var view: AnyView?
    var interator: AnyInteractor?
    
    var _view: IShowLiveLocationViewController? { self.view as? IShowLiveLocationViewController}
    var _interator: IShowLiveLocationInteractor? { self.interator as? IShowLiveLocationInteractor }
    
    
    func onMapDidLoad() {
        
        do{
            try _interator?.fetchISSLiveLocation({ result in
                
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    
                    case .failure(let error):
                        
                        self?._view?.showError(error)
                        break
                    case .success(let location):
                        
                        if let _location = location {
                            self?._view?.showLiveLocation(_location)
                        }
                        break
                    }
                }
            })
            
            self._interator?.getUserCurrentLocaltion()
        }catch{
            _view?.showError(error)
        }
    }
    
    func updateUserLocation(coordinate: ShowLocationEntity?) {
        self._view?.userCurrentLocation = coordinate
    }
}
