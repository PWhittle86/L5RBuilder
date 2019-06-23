//
//  DeckBuilderTabViewVC.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 24/04/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

@objcMembers class DeckBuilderTabViewVC: UITabBarController {
    
    weak var coordinator: MainCoordinator?
    let dynastyBuilderVC: DynastyDeckBuilderVC
    let conflictBuilderVC: ConflictDeckBuilderVC
    var deck: Deck
    
    init(dynastyBuilder: DynastyDeckBuilderVC, conflictBuilder: ConflictDeckBuilderVC, deck: Deck) {
        
        self.dynastyBuilderVC = dynastyBuilder
        self.conflictBuilderVC = conflictBuilder
        self.deck = deck
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Dynasty Deck"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.viewControllers = [dynastyBuilderVC, conflictBuilderVC]
        super.viewDidLoad()
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(self.searchFunction))
        self.navigationItem.rightBarButtonItems?.append(searchButton)
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settingsIcon50px"), style: .plain, target: self, action: #selector(self.settingsFunction))
        self.navigationItem.rightBarButtonItems?.append(settingsButton)
        
        self.navigationItem.setRightBarButtonItems([settingsButton, searchButton], animated: true)
        
//        let button1 = UIBarButtonItem(image: UIImage(named: "imagename"), style: .plain, target: self, action: Selector("action")) // action:#selector(Class.MethodName) for swift 3
//        self.navigationItem.rightBarButtonItem  = button1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //TODO: Find out why image isn't appearing, and find a better bugfix than selecting conflictVC before the view loads.
        self.selectedViewController = conflictBuilderVC
        self.selectedViewController = dynastyBuilderVC
    }
    
    @objc func searchFunction(){
        print("SEARCH FUNCTION WORKING")
    }
    
    @objc func settingsFunction(){
        print("SETTINGS FUNCTION WORKING")
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        //Function to update the title of the tab bar controller based upon the table view controller being shown.
        
        let barItemIndex = tabBar.items?.firstIndex(of: item)
        
        let dynastyIndex = self.viewControllers?.firstIndex(of: dynastyBuilderVC)
        let conflictIndex = self.viewControllers?.firstIndex(of: conflictBuilderVC)
        
        switch barItemIndex {
        case dynastyIndex:
            self.title = "Dynasty Deck"
            break
        case conflictIndex:
            self.title = "Conflict Deck"
            break
        default:
            self.title = "Deck Builder"
            break
        }
    }
    
}
