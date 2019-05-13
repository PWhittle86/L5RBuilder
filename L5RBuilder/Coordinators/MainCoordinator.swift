//
//  MainCoordinator.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 13/05/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startVC = DeckListVC.instantiate()
        startVC.coordinator = self
        navigationController.pushViewController(startVC, animated: false)
    }
    
    func newDeck() {
        let newDeckVC = NewDeckPopUpVC.instantiate()
        newDeckVC.coordinator = self
        navigationController.pushViewController(newDeckVC, animated: true)
    }
    
    
    
}
