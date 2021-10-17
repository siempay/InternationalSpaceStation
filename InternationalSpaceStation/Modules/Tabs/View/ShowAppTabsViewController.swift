//
//  ShowAppTabsViewController.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import UIKit


class ShowAppTabsViewController: UITabBarController, UITabBarControllerDelegate, AnyView {
    
    var presenter: AnyPresenter?
    var _presenter: IShowAppTabsPresenter? { presenter as? IShowAppTabsPresenter }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.viewControllers = _presenter?.getTabViewControllers()
    }
}
