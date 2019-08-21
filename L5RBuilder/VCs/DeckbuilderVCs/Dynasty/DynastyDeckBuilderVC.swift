//
//  DynastyDeckBuilderVC.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 25/04/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

class DynastyDeckBuilderVC: UITableViewController, CardViewDelegate, CardCellDelegate, Storyboarded {

    weak var coordinator: MainCoordinator?
    let db = DBHelper.sharedInstance
    var deck: Deck
    var availableCards: Results<Card>
    var dynastyDeckCardCount: Int
    
    init(deck: Deck) {
        self.deck = deck
        availableCards = db.getClanDynastyCards(clan: deck.clan!)
        self.dynastyDeckCardCount = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.tableView.reloadData()
        super.viewDidLoad()
        self.tabBarItem = UITabBarItem(title: "Dynasty(\(dynastyDeckCardCount))", image: UIImage(named: "dynastyDeckIcon"), tag: 0)
        
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
            let card = availableCards[indexPath.row]
            let cardCount = deck.dynastyDeck.filter({$0.id == card.id}).count
            cell.setUpCell(indexPath: indexPath, availableCards: availableCards, cardCount: cardCount)
            cell.delegate = self
            return cell
        }
        
        let cell = UITableViewCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCard = availableCards[indexPath.row]
        let selectedCardsInDeckCount = deck.dynastyDeck.filter({$0.id == selectedCard.id}).count
        print("I clicked a card to edit. There are currently \(selectedCardsInDeckCount) copies of \(selectedCard.id) in the dynasty deck.")
        coordinator?.showDynastyCard(selectedCard: selectedCard, delegate: self, cardsInDeckCount: selectedCardsInDeckCount)
    }
    
    func addCards(card: Card, numberOfCards: Int) {
        
        let selectedCardsInDeckCount = deck.dynastyDeck.filter({$0.id == card.id}).count
        
        if selectedCardsInDeckCount != numberOfCards {
            deck.dynastyDeck.removeAll(where: {$0.id == card.id})
            
            if numberOfCards > 0 {
                var i = 0
                while i < numberOfCards {
                    deck.dynastyDeck.append(card)
                    i = i+1
                }
            }
        }
        print("There are now \(deck.dynastyDeck.filter({$0.id == card.id}).count) copies of \(card.id) in the dynasty deck.")
        self.tableView.reloadData()
    }
    
    func removeCardTapped(card: Card) {
        print("Remove card button tapped(Tableview)")
        let cardToRemove: Card = deck.dynastyDeck.filter({$0.id == card.id})[0]
        let firstIndex = deck.dynastyDeck.index(of: cardToRemove)
        if let foundCardIndex = firstIndex {
            deck.dynastyDeck.remove(at: foundCardIndex)
            let cardCount = deck.dynastyDeck.filter({$0.id == card.id}).count
            print("There are now \(cardCount) copies of \(card.id) in the dynasty deck.")
            
            //Update total card count
            dynastyDeckCardCount = self.deck.dynastyDeck.count
            tabBarItem.title = "Dynasty(\(self.dynastyDeckCardCount))"
            tableView.reloadData()
        }
        
    }
    
    func addCardTapped(card: Card) {
        print("Add card button tapped(Tableview)")
        deck.dynastyDeck.append(card)
        let cardCount = deck.dynastyDeck.filter({$0.id == card.id}).count
        print("There are now \(cardCount) copies of \(card.id) in the dynasty deck.")
        
        //Update total card count
        dynastyDeckCardCount = self.deck.dynastyDeck.count
        tabBarItem.title = "Dynasty(\(self.dynastyDeckCardCount))"
        tableView.reloadData()
    }
    
}
