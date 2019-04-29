//
//  Card.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 09/11/2018.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import Foundation
import RealmSwift

class Card: Object {
    @objc dynamic var id = ""
    @objc dynamic var number = 0
    @objc dynamic var clan = ""
    @objc dynamic var deckLimit = 0 //Max number of copies allowed in deck.
    @objc dynamic var imageURL: String? = nil //Array <packCard> //Includes image, flavor and originating pack.
    @objc dynamic var imageSavedLocally: Bool = false
    @objc dynamic var flavorText: String? = nil
    @objc dynamic var originPack: String? = ""
    @objc dynamic public var name = ""
    @objc dynamic var cardType = ""
    @objc dynamic var side = ""
    @objc dynamic var textCanonical: String? = nil
    @objc dynamic var roleRestriction: String? = ""
    
    //Conflict & Dynasty Properties
    let cost = RealmOptional<Int>()
    let glory = RealmOptional<Int>()
    let traits = List<String?>()
    @objc dynamic var strengthBonus: String? = nil
    @objc dynamic var unicity = false
    
    //Province Properties
    @objc dynamic var strength: String? = nil
    
    //Stronghold Properties
    let fate = RealmOptional<Int>()
    let honor = RealmOptional<Int>()
    let influence = RealmOptional<Int>()
    
    
}
