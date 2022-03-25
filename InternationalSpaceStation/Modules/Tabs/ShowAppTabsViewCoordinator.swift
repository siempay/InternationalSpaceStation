//
//  ShowAppTabsViewCoordinator.swift
//  InternationalSpaceStation
//
//  Created by Brahim Elmssilha on 24/3/2022.
//

import Foundation
import UIKit


class ShowAppTabsViewCoordinator {
	
	private var view: ShowAppTabsViewController!
	
	let showPassengersViewCoordinator: ShowPassengersViewCoordinator
	let showLiveLocationViewCoordinator: ShowLiveLocationViewCoordinator

	init() {
		showPassengersViewCoordinator = .init()
		showLiveLocationViewCoordinator = .init()
	}
	
	func makeView() -> UIViewController {
	
		self.view = .init()
		self.view.viewControllers = [
			showLiveLocationViewCoordinator.makeView(),
			UINavigationController(rootViewController: showPassengersViewCoordinator.makeView()),
		]
		return self.view
	}
}
