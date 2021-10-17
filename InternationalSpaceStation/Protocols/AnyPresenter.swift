//
//  AnyPresenter.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation

protocol AnyPresenter {
    
    var router: AnyRouter? { get set }
    var view: AnyView? { get set }
    var interator: AnyInteractor? { get set }
}
