//
//  ConflictDeckBuilderVC.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 25/04/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

class ConflictDeckBuilderVC: UITableViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    let db = DBHelper.sharedInstance
    var deck: Deck
    var availableCards: [Card] = []
    var conflictDeckCardCount = 0
    
    var filteredCards: [Card] = []
    var isFiltering = false
    
    init(deck: Deck) {
        self.deck = deck
        availableCards = db.getConflictCards()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        self.tabBarItem = UITabBarItem(title: "Conflict", image: UIImage(named: "conflictDeckIcon"), tag: 1)
        super.viewDidLoad()
        
        let deckbuilderNib = UINib(nibName: "DeckBuilderCardTableViewCell", bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Conflict(\(conflictDeckCardCount))", image: UIImage(named: "conflictDeckIcon"), tag: 0)
        self.tableView.register(deckbuilderNib, forCellReuseIdentifier: "DeckBuilderCardTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering{
            return filteredCards.count
        }
        return availableCards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DeckBuilderCardTableViewCell", for: indexPath) as? DeckBuilderCardTableViewCell {
            
            var card: Card
            
            if isFiltering {
                card = filteredCards[indexPath.row]
            } else {
                card = availableCards[indexPath.row]
            }
            
            let cardCount = deck.conflictDeck.filter({$0.id == card.id}).count
            
            cell.setUpCell(indexPath: indexPath, card: card, cardCount: cardCount)
            cell.delegate = self
            return cell
        }
        
        let cell = UITableViewCell()
        return cell
    }

    func filterContentForSearchText(_ searchText: String) {
        filteredCards = availableCards.filter {(card: Card) -> Bool in
            return card.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
}

extension ConflictDeckBuilderVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
            
        print("CONFLICT SEARCH FUNCTION WORKING")
        
            let searchBar = searchController.searchBar
            if let searchedText = searchBar.text {
                if searchedText.isEmpty{
                    self.isFiltering = false
                } else {
                    self.isFiltering = true
                    filterContentForSearchText(searchedText)
                }
            }
        }
}

extension ConflictDeckBuilderVC: CardCellDelegate {
    
    func removeCardTapped(card: Card) {
        print("Remove card button tapped(Tableview)")
        let cardToRemove: Card = deck.conflictDeck.filter({$0.id == card.id})[0]
        let firstIndex = deck.conflictDeck.index(of: cardToRemove)
        if let foundCardIndex = firstIndex {
            deck.conflictDeck.remove(at: foundCardIndex)
            let cardCount = deck.conflictDeck.filter({$0.id == card.id}).count
            print("There are now \(cardCount) copies of \(card.id) in the dynasty deck.")
            
            //Update total card count
            conflictDeckCardCount = self.deck.conflictDeck.count
            tabBarItem.title = "Conflict(\(self.conflictDeckCardCount))"
            tableView.reloadData()
        }
    }
    
    func addCardTapped(card: Card) {
        print("Add card button tapped(Tableview)")
        self.deck.conflictDeck.append(card)
        let cardCount = self.deck.conflictDeck.filter({$0.id == card.id}).count
        print("There are now \(cardCount) copies of \(card.id) in the conflict deck.")
        
        //Update total card count
        self.conflictDeckCardCount = self.deck.conflictDeck.count
        tabBarItem.title = "Conflict(\(self.conflictDeckCardCount))"
        tableView.reloadData()
    }
    
}

extension ConflictDeckBuilderVC: CardViewDelegate {
    
    func addCards(card: Card, numberOfCards: Int) {
        
        let selectedCardsInDeckCount = deck.conflictDeck.filter({$0.id == card.id}).count
        
        if selectedCardsInDeckCount != numberOfCards {
            deck.conflictDeck.removeAll(where: {$0.id == card.id})
            
            if numberOfCards > 0 {
                var i = 0
                while i < numberOfCards {
                    deck.conflictDeck.append(card)
                    i = i+1
                }
            }
        }
        print("There are now \(deck.conflictDeck.filter({$0.id == card.id}).count) copies of \(card.id) in the conflict deck.")
        self.tableView.reloadData()
    }
    
}
