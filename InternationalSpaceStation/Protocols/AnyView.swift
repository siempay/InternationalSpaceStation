//
//  AnyView.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import UIKit

protocol AnyView where Self: UIViewController {
    
    var presenter: AnyPresenter? { get set }
}
