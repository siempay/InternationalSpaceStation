//
//  ShowAppTabsPresenter.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import UIKit

protocol IShowAppTabsPresenter: AnyPresenter {
    
    func getTabViewControllers() -> [AnyView]
}

class ShowAppTabsPresenter: IShowAppTabsPresenter {
  
    
    var router: AnyRouter?
    
    var view: AnyView?
    
    var interator: AnyInteractor?
    
    
    func getTabViewControllers() -> [AnyView] {
                
        
        let livePosistion = ShowLiveLocationRouter.start().entry
        livePosistion?.tabBarItem = UITabBarItem.init(
            title: "ISS", image: "🛸".emojiToImage(), tag: 0
        )
        
               
        let passengers = ShowPassengersRouter.start().entry
        passengers?.tabBarItem = UITabBarItem.init(
            title: "Passengers", image: "🧑🏻‍✈️".emojiToImage(), tag: 1
        )
        
        return [
        
            livePosistion, passengers
        
        ].compactMap { $0 }
    }
    
}
