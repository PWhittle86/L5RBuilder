//
//  DeckBuilderVC.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 14/03/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

class DeckBuilderVC: UIViewController {
    
    var deck: Deck?
    
    
//    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle? = nil, clan: Clan, stronghold: Card, role: Card) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//        self.deck = Deck(withClan: clan, stronghold: stronghold, role: role)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func configureDeck(stronghold: Card, role: Card){
        
        self.deck = Deck(stronghold: stronghold, role: role)
    }
    
}
