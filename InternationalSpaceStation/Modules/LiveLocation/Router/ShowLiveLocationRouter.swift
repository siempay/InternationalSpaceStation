//
//  ShowLiveLocationRouter.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation


class ShowLiveLocationRouter: AnyRouter {
    
    var entry: AnyView?
    
    static func start() -> AnyRouter {
        
        let router = ShowLiveLocationRouter()
        let presenter = ShowLiveLocationPresenter()
        let view = ShowLiveLocationViewController()
        let interactor = ShowLiveLocationInteractor()
        
        router.entry = view

        presenter.router = router
        presenter.view = view
        presenter.interator = interactor

        interactor.presenter = presenter
        
        view.presenter = presenter

        return router
    }
}
