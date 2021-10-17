//
//  AnyInteractor.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation


protocol AnyInteractor {
    
    var presenter: AnyPresenter? { get set }
}
