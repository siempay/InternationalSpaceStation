//
//  ShowPassengersViewController.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import UIKit


protocol ShowPassengersViewControllerDelegate {
	
	func viewIsReady()
}


class ShowPassengersViewController: UIViewController {
 
	private lazy var tableView: UITableView = {
		let tableView = UITableView.init()
		tableView.frame = self.view.bounds
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		return tableView
	}()
	
	private lazy var refreshControl: UIRefreshControl = {
		
		let refreshControl = UIRefreshControl.init()
		refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
		return refreshControl
	}()
    
    var data: [ShowPassengerEntity.Passenger]?
	var delegate: ShowPassengersViewControllerDelegate?
    
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
		
		self.tabBarItem = UITabBarItem.init(
			title: "Passengers", image: "🧑🏻‍✈️".emojiToImage(), tag: 1
		)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
		self.title = "ISS Passengers"
		self.view.addSubview(tableView)
		
		self.tableView.addSubview(refreshControl)
        
		
		self.delegate?.viewIsReady()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadData()

    }
    
    // MARK:- Presenter
    
    @objc func loadData() {
       
        self.refreshControl.beginRefreshing()
        
    }

    
    func showPassengers(_ passengers: ShowPassengerEntity) {
        
        self.data = passengers.people
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func showError(_ error: Error) {
        super.showError(error)
        
        self.refreshControl.endRefreshing()
    }
    
	// MARK: - Refersh control
	
	func startRefreshing() {
		self.refreshControl.beginRefreshing()
	}
	
	func stopRefreshing() {
		self.refreshControl.endRefreshing()
	}
}

extension ShowPassengersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = data?[indexPath.row]
        
        cell.textLabel?.text = item?.name
        
        return cell
    }
}
