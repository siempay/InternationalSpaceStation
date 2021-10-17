//
//  ShowLiveLocationViewController.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import UIKit
import MapKit

protocol IShowLiveLocationViewController: AnyView {
    func showLiveLocation(_ location: ShowLiveLocationEntity)
    func showError(_ error: Error)
    
    var userCurrentLocation: ShowLocationEntity? { get set }
}

class ShowLiveLocationViewController: UIViewController, IShowLiveLocationViewController {

    var presenter: AnyPresenter?
    
    var _presenter: IShowLiveLocationPresenter? {
        presenter as? IShowLiveLocationPresenter
    }

    private var mapView: MKMapView!
    private var showDistance: UILabel!
    
    private var refreshPostion: Timer?
    
    var iss_pointAnnotation: MKPointAnnotation?
    var user_pointAnnotation: MKPointAnnotation?

    var userCurrentLocation: ShowLocationEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add Map
        
        mapView = .init()
        mapView.frame = view.bounds
        view.addSubview(mapView)
        
        // add actions
        addCenterAction()
        addDistanceLabel()
        
        // refreshing postion
        
        refreshPostion = .scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { [weak self] _ in
            self?._presenter?.onMapDidLoad()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _presenter?.onMapDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        refreshPostion?.invalidate()
    }
    
    
    /// This shows ISS live location updated every 1.5 sec by a timer
    func showLiveLocation(_ location: ShowLiveLocationEntity) {
        
        //print(Date(), "location", location)
        self.appendISSLocationMarker(location: location)
        
        
        // Show user marker
        self.appendUserLocationMarker()
        
        self.showISSDistanceFromUser()

    }

    func appendISSLocationMarker(location: ShowLiveLocationEntity) {
        
        guard let iss_position = convertLocation(location: location) else { return }
        
        let addAnotation = MKPointAnnotation()
        addAnotation.title = "ISS"
        addAnotation.coordinate = iss_position
        
        if let ano = self.iss_pointAnnotation {
            self.mapView.removeAnnotation(ano)
        }
        
        self.mapView.addAnnotation(addAnotation)
        
        if iss_pointAnnotation == nil {
            // center to the ISS if this is first time to show
            mapView.setCenter(iss_position, animated: true)
        }
        
        self.iss_pointAnnotation = addAnotation

    }
    
    func appendUserLocationMarker() {
        
        if let ano = user_pointAnnotation {
            mapView.removeAnnotation(ano)
        }
        
        if let location = userCurrentLocation {
            user_pointAnnotation = MKPointAnnotation()
            user_pointAnnotation?.title = "You"
            user_pointAnnotation?.coordinate = .init(latitude: location.latitude, longitude: location.longitude)
            self.mapView.addAnnotation(user_pointAnnotation!)
        }
        
    }
    // MARK:- Map location
    
    /// Convert entity to map coordinate
    func convertLocation(location: ShowLiveLocationEntity) -> CLLocationCoordinate2D? {
        
        let iss_position = location.iss_position
        guard
            let lt = Double(iss_position.latitude),
            let lg = Double(iss_position.longitude)
        
        else { return nil }
        
        return .init(
            latitude: lt, longitude: lg
        )
    }
    
    func showISSDistanceFromUser() {
        
        guard let user = self.userCurrentLocation else { return }
        guard let iss = self.iss_pointAnnotation?.coordinate else { return }

        let userLocation = CLLocation(latitude: user.latitude, longitude: user.latitude)
        let iss_location = CLLocation(latitude: iss.latitude, longitude: iss.latitude)
        
        let result = userLocation.distance(from: iss_location)
        
        let formatter = MKDistanceFormatter()
         
        let string = formatter.string(fromDistance: result)
        self.showDistance.text = "Distance from ISS: \(string)"
        
        print("distance", result)
     
        // distance in meters
        if result <= 10000 {
            self.showDistance.text = "ISS is above you now"
            self.showDistance.backgroundColor = .systemGreen
        }else{
            self.showDistance.backgroundColor = .white
        }
    }
    
    // MARK: - Actions
    
    @objc func centerPosition() {
        
        if let iss_position = iss_pointAnnotation?.coordinate {
            mapView.setCenter(iss_position, animated: true)
        }
    }
    
    // MARK:- Setup actions constraintes
    
    func addCenterAction() {
        
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: [])
        button.backgroundColor = .white
        button.setTitle("Center ISS", for: [])
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(centerPosition), for: .touchUpInside)
        button.layer.cornerRadius = 5
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        button.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -10).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    func addDistanceLabel() {
        
        let label = UILabel()
        label.text = "Distance..."
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -10).isActive = true
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true

        self.showDistance = label
    }
    
}
