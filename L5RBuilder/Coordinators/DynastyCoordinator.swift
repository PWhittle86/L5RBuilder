//
//  DynastyDeckBuildCoordinator.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 14/05/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import Foundation

class DynastyCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var deck: Deck
    
    init(navigationController: UINavigationController, deck: Deck) {
        self.navigationController = navigationController
        self.deck = deck
    }
    
    func start() {
        
        let dynastyVC = DynastyDeckBuilderVC(deck: self.deck)
        
    }
    
}
