//
//  ShowPassengersViewCoordinator.swift
//  InternationalSpaceStation
//
//  Created by Brahim Elmssilha on 24/3/2022.
//

import Foundation
import UIKit


class ShowPassengersViewCoordinator: ShowPassengersViewControllerDelegate {
	
	private var view: ShowPassengersViewController?
	private let showPassengersInteractor: ShowPassengersInteractor
	
	init() {
		self.showPassengersInteractor = .init()
		self.showPassengersInteractor.delegate = self
	}
	
	
	func makeView() -> UIViewController? {
		
		self.view = .init()
		self.view?.delegate = self
		return self.view
	}
	
	// MARK: - Presenter
	
	func viewIsReady() {
		
		self.loadPassengers()
	}
	
	
	func loadPassengers() {
		
		do{
			
			self.view?.startRefreshing()
			try self.showPassengersInteractor.loadPassengers()
			
		}catch {
			self.view?.showError(error)
		}
	}
	
}

// MARK: - interator
extension ShowPassengersViewCoordinator: ShowPassengersInteractorDelegate {
	
	func didFinishLoadingPassengers(success passengerEntity: ShowPassengerEntity?) {

		DispatchQueue.main.async { [weak self] in
			self?.view?.stopRefreshing()

			if let passengers = passengerEntity {
				self?.view?.showPassengers(passengers)
			}
		}
	}
	
	func didFinishLoadingPassengers(failure error: Error) {
		DispatchQueue.main.async { [weak self] in
			self?.view?.stopRefreshing()
			self?.view?.showError(error)
		}
	}
	
}
