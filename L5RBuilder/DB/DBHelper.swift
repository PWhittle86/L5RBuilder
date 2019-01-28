//
//  DBCard.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 07/12/2018.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import Foundation
import RealmSwift

class DBHelper{
  
  static let sharedInstance = DBHelper(dbPath: "cardDB")
  
  let cardDB: Realm
  var cardDBConfig = Realm.Configuration()
  
  private init(dbPath: String){
    
    self.cardDBConfig.fileURL = cardDBConfig.fileURL!.deletingLastPathComponent().appendingPathComponent("\(dbPath).realm")
    
    do{
      self.cardDB = try! Realm(configuration: cardDBConfig)
      print(dbPath)
    }
  }
  
  //Provide string to specify where DB should be saved.
  //  class func setDBPath(dbName: String) -> Realm.Configuration {
  //    var config = Realm.Configuration()
  //    config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(dbName).realm")
  //    return config
  //  }
  
  //Save card to DB.
  func addCardToCardDB(card: Card){
    OperationQueue.main.addOperation {
      try! self.cardDB.write{
        self.cardDB.add(card)
      }
    }
  }
  
  //Delete specified DB.
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
  
  //Return false if card id (name as string) is not in DB.
  func isCardIdInCardDB(cardId: String) -> Bool{
    
    //You need to declare a new instance of the realm EVERY TIME you want to use it when another realm is running on the main thread.
    let myBackgroundRealm = try! Realm(configuration: self.cardDBConfig)
    let queryResults = myBackgroundRealm.objects(Card.self).filter("id == '\(cardId)'")
    
    if queryResults.count > 0{
      return true
    } else {
      return false
    }
    
  }
  
  
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
        var counter = 0
        
        for card in json.records{
  
          if self.isCardIdInCardDB(cardId: card.id) == true
          {
            print("Card number \(counter) (\(card.id)), is already saved locally.")
          }
          else
          {
            let dbCard = Card()
            dbCard.id = card.id
            dbCard.number = counter
            dbCard.clan = card.clan
            dbCard.deckLimit = card.deck_limit
            dbCard.name = card.name
            dbCard.type = card.type
            dbCard.side = card.side
            dbCard.unicity = card.unicity
            
            for trait in card.traits{
              let prettyTrait = trait.capitalized
              dbCard.traits.append(prettyTrait)
            }
            
            let lastPackCardIndex = (card.pack_cards.count - 1) //This doesn't quite work atm. Way-of card images are being lost. Will do for the time being.
            
            //Optional strings
            
            dbCard.image = card.pack_cards[lastPackCardIndex].image_url
            dbCard.textCanonical = card.text_canonical
            dbCard.flavorText = card.pack_cards[lastPackCardIndex].flavor
            dbCard.originPack = card.pack_cards[lastPackCardIndex].pack["id"]
            dbCard.strengthBonus = card.strength_bonus
            dbCard.strength = card.strength
            
            //Optional ints
            
            dbCard.cost.value = card.cost
            dbCard.glory.value = card.glory
            
            self.addCardToCardDB(card: dbCard)
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

