//
//  DBCard.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 07/12/2018.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import Foundation
import RealmSwift

class DBHelper {
    
    //Singleton pattern.
    static let sharedInstance = DBHelper(dbPath: "cardDB")
    
    let DB: Realm
    var cardDBConfig = Realm.Configuration()
    var cardsArray: Array<Card> = []
    
    private init(dbPath: String) {
        self.cardDBConfig.fileURL = cardDBConfig.fileURL!.deletingLastPathComponent().appendingPathComponent("\(dbPath).realm")
        do{
            self.DB = try! Realm(configuration: cardDBConfig)
            print(dbPath)
        }
    }
    
    func getCard(cardID: String) -> Card {
        let cards = self.DB.objects(Card.self).filter("id == '\(cardID)'")
        return cards[0]
    }
    
    func getAllCards() -> Array<Card> {
        
        cardsArray = []
        let realmCards = self.DB.objects(Card.self)
        
        for card in realmCards {
            cardsArray.append(card)
        }
        return cardsArray
    }
    
    func getAllUnsavedImages() -> Array<Card> {
        
        cardsArray = []
        let realmCards = self.DB.objects(Card.self).filter("imageSavedLocally == \(false)")
        
        for card in realmCards {
            cardsArray.append(card)
        }
        return cardsArray
    }
    
    func getAllRoles() -> Array<Card> {
        
        cardsArray = []
        let realmCards = self.DB.objects(Card.self).filter("cardType = 'role'")
        
        for card in realmCards {
            cardsArray.append(card)
        }
        return cardsArray
    }
    
    func getAllStrongholds() -> Array<Card> {
        
        cardsArray = []
        let realmCards = self.DB.objects(Card.self).filter("cardType = 'stronghold'")
        
        for card in realmCards {
            cardsArray.append(card)
        }
        return cardsArray
    }
    
    func getAllClanStrongholds(clan: String) -> Array<Card> {
        
        cardsArray = []
        let realmCards = self.DB.objects(Card.self).filter("cardType = 'stronghold' AND clan = '\(clan)'")
        
        for card in realmCards {
            cardsArray.append(card)
        }
        return cardsArray
    }
    
    func getClanDynastyCards(clan: String) -> Array<Card> {
        
        cardsArray = []
        let realmCards = self.DB.objects(Card.self).filter("side = 'dynasty' AND (clan = '\(clan)' OR clan = 'neutral')")
        
        for card in realmCards {
            cardsArray.append(card)
        }
        return cardsArray
    }
    
    func getConflictCards() -> Array<Card> {

        cardsArray = []
        let realmCards = self.DB.objects(Card.self).filter("side = 'conflict'")
        
        for card in realmCards {
            cardsArray.append(card)
        }
        return cardsArray
    }
    
    func addCard(card: Card){
        OperationQueue.main.addOperation {
            try! self.DB.write{
                self.DB.add(card)
            }
        }
    }

    func deleteCard(card:Card){
        let backgroundRealm = try! Realm(configuration: self.cardDBConfig)
        let cards = backgroundRealm.objects(Card.self).filter("id == '\(card.id)'")
        
        if !cards.isEmpty {
            let firstCard = cards[0]
            try! backgroundRealm.write {
                backgroundRealm.delete(firstCard)
            }
        } else {
            return
        }
    }
    
    func updateLocalImageStatus(card: Card, updateTo: Bool){
        
        let backgroundRealm = try! Realm(configuration: self.cardDBConfig)
        try! backgroundRealm.write {
            card.imageSavedLocally = true
        }
    }
    
    func deleteDB(realm: Realm){
        
        let realmURL = realm.configuration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                // handle error
            }
        }
    }
    
    //Return false if card id (name as string) is not in DB. You need to declare a new instance of the realm EVERY TIME you want to use it when another realm is running on the main thread.
    func isCardIdInCardDB(cardId: String) -> Bool{
        
        let backgroundRealm = try! Realm(configuration: self.cardDBConfig)
        let queryResults = backgroundRealm.objects(Card.self).filter("id == '\(cardId)'")
        
        if !queryResults.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    //TODO: Add logic for progress tracker when syncing from the back-end.
    //Download all cards from the fiveringsdb api.
    func downloadCards(){
        
        let session = URLSession.init(configuration: .default)
        let fiveRingsAPI = URL(string: "https://api.fiveringsdb.com/cards")!
        let task = session.dataTask(with: fiveRingsAPI){
            
            (data, response, error) in
            
            guard let httpResponse =
                response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data else {
                    return
            }
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(l5rJSON.self, from: data)
                
                //TODO: Should probably get rid of this.
                var counter = 0
                
                for card in json.records{
                    
                    if self.isCardIdInCardDB(cardId: card.id) == true
                    {
//                        print("Card number \(counter) (\(card.id)), is already saved locally.")
                    }
                    else
                    {
                        let dbCard = Card()
                        dbCard.id = card.id
                        dbCard.number = counter
                        dbCard.clan = card.clan
                        dbCard.deckLimit = card.deck_limit
                        dbCard.name = card.name
                        dbCard.cardType = card.type
                        dbCard.side = card.side
                        dbCard.unicity = card.unicity
                        
                        for trait in card.traits{
                            let prettyTrait = trait.capitalized
                            dbCard.traits.append(prettyTrait)
                        }
                        
                        let lastPackCardIndex = (card.pack_cards.count - 1) //TODO: rThis doesn't quite work atm. Way-of card images are being lost. Will do for the time being.
                        
                        if lastPackCardIndex >= 0{
                            dbCard.imageURL = card.pack_cards[lastPackCardIndex].image_url
                            dbCard.flavorText = card.pack_cards[lastPackCardIndex].flavor
                            dbCard.originPack = card.pack_cards[lastPackCardIndex].pack["id"]
                        }
                        
                        //Optional strings
                        
                        dbCard.textCanonical = card.text_canonical
                        dbCard.strengthBonus = card.strength_bonus
                        dbCard.strength = card.strength
                        dbCard.roleRestriction = card.role_restriction
                        dbCard.cost = card.cost
                        
                        dbCard.honor.value = card.honor
                        dbCard.fate.value = card.fate
                        dbCard.influence.value = card.influence_pool
                        
                        //Optional ints
                        
                        dbCard.glory.value = card.glory
                        
                        self.addCard(card: dbCard)
                    }
                    counter += 1
                }
            }
            catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
}

