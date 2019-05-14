//
//  MainCoordinator.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 13/05/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import Foundation

class MainCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startVC = DeckListVC.instantiate()
        startVC.coordinator = self
        navigationController.delegate = self
        navigationController.pushViewController(startVC, animated: false)
    }
    
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func newDeck() {
        let newDeckVC = NewDeckPopUpVC.instantiate()
        newDeckVC.coordinator = self
        navigationController.pushViewController(newDeckVC, animated: true)
    }
    
    func buildDeck(startingDeck: Deck) {
        
        let dynastyChild = DynastyCoordinator(navigationController: navigationController, deck: startingDeck)
        let conflictChild = ConflictCoordinator(navigationController: navigationController, deck: startingDeck)
        childCoordinators.append(dynastyChild)
        childCoordinators.append(conflictChild)
        
        let deckBuilderTabView = DeckBuilderTabViewVC(with: dynastyChild, conflictCoordinator: conflictChild)
        navigationController.pushViewController(deckBuilderTabView, animated: true)
        
        
        //Check if user is editing an existing deck
        //If yes, feed data into deckbuilders.
        //If no, open empty deckbuilders configured to their role/stronghold selections.
        //Direct user to deckbuilder tab view
        
    }
    
    
    
}

extension MainCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        // Read the view controller we're moving from, and check that it exists.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        //Check whether the navController's vc array already contains that view controller. If it does, it means we're pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) { return }
        
        //If we've not exited by this point, that means we're popping the vc, so we can check which controller is being popped. Will need additional logic here 
        
    }
    
}
