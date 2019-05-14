//
//  Deck.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 09/11/2018.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import UIKit

enum Clan: String, CaseIterable, RawRepresentable {
    case crab = "Crab"
    case crane = "Crane"
    case dragon = "Dragon"
    case lion = "Lion"
    case phoenix = "Phoenix"
    case scorpion = "Scorpion"
    case unicorn = "Unicorn"
}

class Deck: NSObject {
  
  var name: String?
  var clan: String?
  var role: Card?
  var stronghold: Card?
  
  var dynastyDeck: Array <Card> = []
  var conflictDeck: Array <Card> = []
  var provinceDeck: Array <Card> = []
  
    init(clan: Clan, stronghold: Card, role:Card) {
    self.stronghold = stronghold
    self.clan = stronghold.clan
    self.role = role
  }
    
}
