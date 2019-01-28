//
//  APICardCodes.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 07/12/2018.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import Foundation

struct CardData : Codable{
  
  //Generic properties
  let id: String
  let clan: String
  let deck_limit: Int //Max number of copies allowed in deck.
  let pack_cards: Array <packCard> //Includes image, flavor and originating pack.
  let name: String
  let type: String
  let side: String //Conflict, Dynasty or province.
  let text_canonical: String?
  
  //Conflict & Dynasty Properties
  let cost: Int?
  let glory: Int?
  var traits: Array <String>
  let unicity: Bool
  let strength_bonus: String?
  
  //Province Properties
  let strength: String?
  
  //  let restricted: Bool //Commenting this out for now, as I will need to create my own restricted list.
}

struct l5rJSON: Codable {
  let records: Array <CardData>
  let size: Int
}

struct packCard : Codable {
  let illustrator : String
  let flavor: String?
  let image_url: String?
  let pack: Dictionary <String, String>
  let position: String
  let quantity: Int
}
