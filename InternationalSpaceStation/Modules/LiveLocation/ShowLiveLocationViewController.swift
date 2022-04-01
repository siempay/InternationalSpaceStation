//
//  ShowLiveLocationViewController.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import UIKit
import MapKit


protocol ShowLiveLocationViewControllerDelegate {
	func viewIsReady()
	func getUserLocaltion() -> (lt: Double, lg: Double)?
	func getISSLiveLocation() -> (lt: Double, lg: Double)?
	func getDistanceToString() -> (distance: String?, color: UIColor)?
}

class ShowLiveLocationViewController: UIViewController {


	private lazy var mapView: MKMapView = { .init(frame: view.bounds) }()
	private lazy var showDistance: UILabel = addDistanceLabel()

	var delegate: ShowLiveLocationViewControllerDelegate?
	private var iss_pointAnnotation: MKPointAnnotation?
	private var user_pointAnnotation: MKPointAnnotation?
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
		
		self.tabBarItem = UITabBarItem.init(
			title: "ISS", image: "🛸".emojiToImage(), tag: 0
		)
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "ISS live location"
        
        // add Map
        view.addSubview(mapView)
		self.addCenterAction()
		
		self.delegate?.viewIsReady()
    }
    
    /// This shows ISS live location updated every 1.5 sec by a timer
    func showLiveLocation() {
        
		let issLocation = self.delegate?.getISSLiveLocation()
        self.appendISSLocationMarker(location: issLocation)
        
        let userLocation = self.delegate?.getUserLocaltion()
        // Show user marker
        self.appendUserLocationMarker(location: userLocation)
		
		let info = self.delegate?.getDistanceToString()
		self.showDistance.text = info?.distance
		self.showDistance.backgroundColor = info?.color ?? .white
    }

    func appendISSLocationMarker(location: (lt: Double, lg: Double)?) {
        
		guard let iss_position = location else { return }
        
        let addAnotation = MKPointAnnotation()
        addAnotation.title = "ISS"
		addAnotation.coordinate = .init(latitude: iss_position.lt, longitude: iss_position.lg)
        
        if let ano = self.iss_pointAnnotation {
            self.mapView.removeAnnotation(ano)
        }
        
        self.mapView.addAnnotation(addAnotation)
        
        if iss_pointAnnotation == nil {
            // center to the ISS if this is first time to show
            mapView.setCenter(addAnotation.coordinate, animated: true)
        }
        
        self.iss_pointAnnotation = addAnotation

    }
    
    func appendUserLocationMarker(location: (lt: Double, lg: Double)?) {
        
        if let ano = user_pointAnnotation {
            mapView.removeAnnotation(ano)
        }
        
		if let location = location {
            user_pointAnnotation = createPointe(location: location)
            self.mapView.addAnnotation(user_pointAnnotation!)
        }
    }
	
	func createPointe(location: (lt: Double, lg: Double)) -> MKPointAnnotation {
		
		let user_pointAnnotation = MKPointAnnotation()
		user_pointAnnotation.title = "You"
		user_pointAnnotation.coordinate = .init(
			latitude: location.lt, longitude: location.lg
		)
		return user_pointAnnotation
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
                
		self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
		button.anchorTo(self.view.safeAreaLayoutGuide, anchors: .top, constant: 5)
		button.anchorTo(self.view.safeAreaLayoutGuide, anchors: .leading, constant: 5)
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -10).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    func addDistanceLabel() -> UILabel {
        
        let label = UILabel()
        label.text = "Distance..."
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        label.backgroundColor = .white
        label.layer.cornerRadius = 5

		self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
		label.anchorTo(self.view.safeAreaLayoutGuide, anchors: .top, constant: 5)
		label.anchorTo(self.view.safeAreaLayoutGuide, anchors: .trailing, constant: 5)
        label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -10).isActive = true
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true

        return label
    }
    
}
