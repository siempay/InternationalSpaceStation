//
//  AnyRouter.swift
//  InternationalSpaceStation
//
//  Created by Brahim ELMSSILHA on 10/17/21.
//

import Foundation

protocol AnyRouter {
    
    var entry: AnyView? { get }
    
    static func start() -> AnyRouter
}



