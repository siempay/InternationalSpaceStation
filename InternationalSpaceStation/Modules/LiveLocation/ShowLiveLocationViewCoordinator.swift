//
//  ShowLiveLocationViewCoordinator.swift
//  InternationalSpaceStation
//
//  Created by Brahim Elmssilha on 24/3/2022.
//

import Foundation
import UIKit

class ShowLiveLocationViewCoordinator: ShowLiveLocationViewControllerDelegate, ShowLiveLocationInteractorDelegate {
	
	private var view: ShowLiveLocationViewController!
	
	private var refreshPostion: Timer!
	private let showLiveLocationInteractor: ShowLiveLocationInteractor
	
	init() {
		
		self.showLiveLocationInteractor = .init()
		self.showLiveLocationInteractor.delegate = self
	
	}

	func refreshPositionAction() {
	
		do{
			
			try self.fetchISSLiveLocation()
						
		}catch{
			view.showError(error)
		}
	}
	
	func makeView() -> UIViewController {
		
		self.view = .init()
		self.view.delegate = self
		return self.view
	}
	
	// MARK: - View
	
	func viewIsReady() {
	
		self.refreshPostion?.invalidate()
		self.refreshPostion = .scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
			self?.refreshPositionAction()
		})
		
		self.showLiveLocationInteractor.getUserCurrentLocaltion()
		self.refreshPositionAction()
	}
	
	func fetchISSLiveLocation() throws {
		
		try showLiveLocationInteractor.fetchISSLiveLocation({ result in
			
			DispatchQueue.main.async { [weak self] in
				switch result {
						
					case .failure(let error):
						
						self?.view.showError(error)
						break
					case .success(let location):
						
						if let _location = location {
							self?.view.showLiveLocation(_location)
						}
						break
				}
			}
		})
				
	}
	
	// MARK: - Interactor
	
	func didGetUserCurrentLocaltionFailed(error: Error) {
		
		self.view.showError(error)
	}
	
	func didGetUserCurrentLocaltion(location: ShowLocationEntity?) {
		
		self.view.userCurrentLocation = location
	}
}
