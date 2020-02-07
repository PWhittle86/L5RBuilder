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
    
    //searchController Properties
    let searchController: UISearchController
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
       }
    
    init(dynastyBuilder: DynastyDeckBuilderVC, conflictBuilder: ConflictDeckBuilderVC, deck: Deck) {
        
        self.dynastyBuilderVC = dynastyBuilder
        self.conflictBuilderVC = conflictBuilder
        self.deck = deck
        
        self.searchController = UISearchController(searchResultsController: nil)
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Dynasty Deck"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.viewControllers = [dynastyBuilderVC, conflictBuilderVC]
        super.viewDidLoad()
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "searchIcon30px"), style: .plain, target: self, action: #selector(self.searchFunction))
        self.navigationItem.rightBarButtonItems?.append(searchButton)
        
        //searchController setup:

        searchController.searchResultsUpdater = self.dynastyBuilderVC
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a Card"

        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settingsIcon30px"), style: .plain, target: self, action: #selector(self.settingsFunction))
        self.navigationItem.rightBarButtonItems?.append(settingsButton)
        
        self.navigationItem.setRightBarButtonItems([settingsButton, searchButton], animated: true)
        

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
            self.searchController.searchResultsUpdater = dynastyBuilderVC
            if !isSearchBarEmpty {
                dynastyBuilderVC.updateSearchResults(for: searchController)
            }
            dynastyBuilderVC.tableView.reloadData()
            break
        case conflictIndex:
            self.title = "Conflict Deck"
            self.searchController.searchResultsUpdater = conflictBuilderVC
            if !isSearchBarEmpty {
                dynastyBuilderVC.updateSearchResults(for: searchController)
            }
            conflictBuilderVC.tableView.reloadData()
            break
        default:
            self.title = "Deck Builder"
            break
        }
    }
    
}
