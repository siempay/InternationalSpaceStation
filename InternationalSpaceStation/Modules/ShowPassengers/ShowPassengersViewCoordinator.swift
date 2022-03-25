//
//  ShowPassengersViewCoordinator.swift
//  InternationalSpaceStation
//
//  Created by Brahim Elmssilha on 24/3/2022.
//

import Foundation
import UIKit


class ShowPassengersViewCoordinator: ShowPassengersViewControllerDelegate, ShowPassengersInteractorDelegate {
	
	private var view: ShowPassengersViewController!
	private let showPassengersInteractor: ShowPassengersInteractor
	
	init() {
		self.showPassengersInteractor = .init()
		self.showPassengersInteractor.delegate = self
	}
	
	
	func makeView() -> UIViewController {
		
		self.view = .init()
		self.view.delegate = self
		return self.view
	}
	
	// MARK: - Presenter
	
	func viewIsReady() {
		
		self.loadPassengers()
	}
	
	
	func loadPassengers() {
		
		do{
			
			self.view.refreshControl.beginRefreshing()
			try self.showPassengersInteractor.loadPassengers()
			
		}catch {
			self.view.showError(error)
		}
	}
	

	// MARK: - interator
	
	func didFinishLoadingPassengers(result: ShowPassengersInteractorDelegate.Result) {
		
		DispatchQueue.main.async { [weak self] in
			self?.view.refreshControl.endRefreshing()
		}
		
		switch result {
			case .success(let success):
				
				DispatchQueue.main.async { [weak self] in
					
					if let passengers = success {
						self?.view.showPassengers(passengers)
					}
				}
				break
			case .failure(let failure):
				
				DispatchQueue.main.async { [weak self] in
					self?.view.showError(failure)
				}
				break
		}
	}
}
