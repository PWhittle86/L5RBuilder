//
//  Deck.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 09/11/2018.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import UIKit

enum Clan: String {
    case Crab = "Crab"
    case Crane = "Crane"
    case Dragon = "Dragon"
    case Lion = "Lion"
    case Phoenix = "Phoenix"
    case Scorpion = "Scorpion"
    case Unicorn = "Unicorn"
    case Unselected = "Unselected"
}

class Deck: NSObject {
  
  var name: String?
  var clan: String
  var role: Card
  var stronghold: Card
  
  var dynastyDeck: Array <Card> = []
  var conflictDeck: Array <Card> = []
  var provinceDeck: Array <Card> = []
  
  init(stronghold: Card, role:Card) {
    self.stronghold = stronghold
    self.clan = stronghold.clan
    self.role = role
  }
  
    
    
}
