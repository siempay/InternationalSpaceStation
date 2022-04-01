//
//  ShowLiveLocationViewCoordinator.swift
//  InternationalSpaceStation
//
//  Created by Brahim Elmssilha on 24/3/2022.
//

import Foundation
import UIKit
import CoreLocation

class ShowLiveLocationViewCoordinator: ShowLiveLocationViewControllerDelegate {
	
	private var view: ShowLiveLocationViewController!
	private var userCurrentLocation: ShowLocationEntity?
	private var issCurrentLocation: ShowLiveLocationEntity?

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
		
		try showLiveLocationInteractor.fetchISSLiveLocation()
				
	}
	
}

// MARK: - Interactor

extension ShowLiveLocationViewCoordinator: ShowLiveLocationInteractorDelegate {
	
	func didGetISSCurrentLocaltion(location: ShowLiveLocationEntity?) {
		
		self.issCurrentLocation = location
		
		DispatchQueue.main.async { [weak self] in
			self?.view.showLiveLocation()
		}
	}
	
	func didGetISSCurrentLocaltionFailed(error: Error) {
		self.view.showError(error)
	}
	
	func didGetUserCurrentLocaltionFailed(error: Error) {
		
		self.view.showError(error)
	}
	
	func didGetUserCurrentLocaltion(location: ShowLocationEntity?) {
		
		self.userCurrentLocation = location
	}
	
	func getDistanceToString() -> (distance: String?, color: UIColor)? {

		guard let user_location = ShowLiveLocationFormatter.formatUserLocation(location: self.userCurrentLocation) else { return nil }
		guard let iss_location = ShowLiveLocationFormatter.formatLiveLocation(location: self.issCurrentLocation?.iss_position) else { return nil }

		let info = showLiveLocationInteractor.isISSAboveUserLocation(userLocation: user_location, issLocation: iss_location)
		
		let text = ShowLiveLocationFormatter.formatResult(info: info)
		
		return (text, info.isAboveUser ? .red : .white)
		
	}
	
	func getUserLocaltion() -> (lt: Double, lg: Double)? {
		
		guard let localtion = self.userCurrentLocation else { return nil }
		
		return (localtion.latitude, localtion.longitude)
	}
	
	func getISSLiveLocation() -> (lt: Double, lg: Double)? {

		guard let location = self.issCurrentLocation?.iss_position else { return nil }
		return ShowLiveLocationFormatter.formatLocation(location: location)
	}
}
