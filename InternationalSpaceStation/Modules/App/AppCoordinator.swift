//
//  AppCoordinator.swift
//  InternationalSpaceStation
//
//  Created by Brahim Elmssilha on 24/3/2022.
//

import Foundation
import UIKit


class AppCoordinator {
	
	private let tab: ShowAppTabsViewCoordinator
	
	init() {
		self.tab = ShowAppTabsViewCoordinatorFactory.createTab()
	}
	
	func makeView() -> UIViewController? {
		
		self.tab.makeView()
	}
}
