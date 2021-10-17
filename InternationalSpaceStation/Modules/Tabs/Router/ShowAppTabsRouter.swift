//
//  ShowAppTabsRouter.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation


class ShowAppTabsRouter: AnyRouter {
    
    var entry: AnyView?
    
    static func start() -> AnyRouter {
        
        let router = ShowAppTabsRouter()
        let presenter = ShowAppTabsPresenter()
        let view = ShowAppTabsViewController()
        
        router.entry = view
        
        presenter.router = router
        presenter.view = view
        
        view.presenter = presenter
        
        return router
    }
    
    
    
}
