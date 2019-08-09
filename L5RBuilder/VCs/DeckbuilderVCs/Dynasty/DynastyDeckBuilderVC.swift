//
//  DynastyDeckBuilderVC.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 25/04/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

class DynastyDeckBuilderVC: UITableViewController, cardViewDelegate, Storyboarded {

    weak var coordinator: MainCoordinator?
    let db = DBHelper.sharedInstance
    var deck: Deck
    var availableCards: Results<Card>
    
    init(deck: Deck) {
        self.deck = deck
        availableCards = db.getClanDynastyCards(clan: deck.clan!)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem = UITabBarItem(title: "Dynasty", image: UIImage(named: "dynastyDeckIcon"), tag: 0)
        
        let deckbuilderNib = UINib(nibName: "DeckBuilderCardTableViewCell", bundle: nil)
        self.tableView.register(deckbuilderNib, forCellReuseIdentifier: "DeckBuilderCardTableViewCell")
    }
}

//MARK: Data source and delegate methods

extension DynastyDeckBuilderVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableCards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DeckBuilderCardTableViewCell", for: indexPath) as? DeckBuilderCardTableViewCell {
            cell.setUpCell(indexPath: indexPath, availableCards: self.availableCards)
            return cell
        }
        
        let cell = UITableViewCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCard = availableCards[indexPath.row]
        coordinator?.showDynastyCard(selectedCard: selectedCard, delegate: self)
    }
    
    func addCards(cardID: String, number: Int) {
        
        print(cardID, number)
        
    }
    
}
