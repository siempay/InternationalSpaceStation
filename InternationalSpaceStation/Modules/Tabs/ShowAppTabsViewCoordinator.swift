//
//  ShowAppTabsViewCoordinator.swift
//  InternationalSpaceStation
//
//  Created by Brahim Elmssilha on 24/3/2022.
//

import Foundation
import UIKit

protocol ShowAppTabsViewCoordinatorDelegate {
	
}

class ShowAppTabsViewCoordinator {
	
	private var view: ShowAppTabsViewController?
	var delegate: ShowAppTabsViewCoordinatorDelegate?
	
	let showPassengersViewCoordinator: ShowPassengersViewCoordinator
	let showLiveLocationViewCoordinator: ShowLiveLocationViewCoordinator

	init() {
		showPassengersViewCoordinator = .init()
		showLiveLocationViewCoordinator = .init()
	}
	
	func makeView() -> UIViewController? {
	
		self.view = .init()
		let viewControllers = [
			showLiveLocationViewCoordinator.makeView(),
			showPassengersViewCoordinator.makeView(),
		]
		
		self.view?.viewControllers = viewControllers.compactMap({ $0 }).map({ UINavigationController(rootViewController: $0) })
		
		return self.view
	}
}
