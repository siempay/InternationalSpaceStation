//
//  ShowPassengersPresenter.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation

protocol IShowPassengersPresenter: AnyPresenter {
    
    func loadData()
    func didLoadPassengers(_ data: ShowPassengerEntity?)
    
    func didFinishLoadingPassengers(with error: Error)
}

class ShowPassengersPresenter: IShowPassengersPresenter {
    
    var router: AnyRouter?
    
    var view: AnyView?
    var _view: IShowPassengersViewController? { view as? IShowPassengersViewController }

    var interator: AnyInteractor?
    var _interator: IShowPassengersInteractor? { interator as? IShowPassengersInteractor }

    
    func loadData() {
        
        do{
            
            try _interator?.loadPassengers()
            
        }catch {
            self._view?.showError(error)
        }
    }
    
    
    func didLoadPassengers(_ data: ShowPassengerEntity?) {
        
        guard let passengers = data else { return }
        
        DispatchQueue.main.async { [weak self] in
            
            self?._view?.showPassengers(passengers)
        }
    }
    
    func didFinishLoadingPassengers(with error: Error) {
        
        DispatchQueue.main.async { [weak self] in
            
            self?._view?.showError(error)
        }
        
    }
}
