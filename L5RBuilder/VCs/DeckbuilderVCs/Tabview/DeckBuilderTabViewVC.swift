//
//  DeckBuilderTabViewVC.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 24/04/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

class DeckBuilderTabViewVC: UITabBarController {
    
    weak var coordinator: MainCoordinator?
    
    let dynasty: DynastyCoordinator
    let conflict: ConflictCoordinator
    
    init(with dynastyCoordinator: DynastyCoordinator, conflictCoordinator: ConflictCoordinator) {
        
        self.dynasty = dynastyCoordinator
        self.conflict = conflictCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.viewControllers = [dynasty.navigationController, conflict.navigationController]
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //TODO: Find out why image isn't appearing, and find a better bugfix than selecting conflictVC before the view loads.
//        self.selectedViewController = conflictVC
//        self.selectedViewController = dynastyVC
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
