//
//  ShowPassengersViewController.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import UIKit

protocol IShowPassengersViewController: AnyView {
    func showPassengers(_ passengers: ShowPassengerEntity)
    func showError(_ error: Error)
}


class ShowPassengersViewController: UIViewController, IShowPassengersViewController {
 
    var presenter: AnyPresenter?
    var _presenter: IShowPassengersPresenter? {self.presenter as? IShowPassengersPresenter }

    private var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    var data: [ShowPassengerEntity.Passenger]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = .init()
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        refreshControl = .init()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        self.view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadData()

    }
    
    // MARK:- Presenter
    
    @objc func loadData() {
       
        self.refreshControl.beginRefreshing()
        self._presenter?.loadData()
        
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
