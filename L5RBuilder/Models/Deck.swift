//
//  Deck.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 09/11/2018.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import UIKit

enum Clan {
  case Crab, Crane, Dragon, Lion, Phoenix, Scorpion, Unicorn
}

class Deck: NSObject {
  
  var name: String?
  var clan: Clan
  var role: Card
  var stronghold: Card
  
  var dynastyDeck: Array <Card> = []
  var conflictDeck: Array <Card> = []
  var provinceDeck: Array <Card> = []
  
  init(withClan clan: Clan, stronghold: Card, role:Card) {
    self.clan = clan
    self.stronghold = stronghold
    self.role = role
  }
  
}
