//
//  Coordinator.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 13/05/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
