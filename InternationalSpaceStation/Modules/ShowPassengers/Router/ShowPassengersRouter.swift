//
//  ShowPassengersRouter.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation


class ShowPassengersRouter: AnyRouter {
    
    var entry: AnyView?
    
    static func start() -> AnyRouter {
        
        let router = ShowPassengersRouter()
        let presenter = ShowPassengersPresenter()
        let view = ShowPassengersViewController()
        let interactor = ShowPassengersInteractor()
        
        router.entry = view
        
        presenter.router = router
        presenter.view = view
        presenter.interator = interactor
        
        interactor.presenter = presenter
        
        view.presenter = presenter
        
        return router
    }
    
    
}
