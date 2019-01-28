//
//  FirstViewController.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 08/11/2018.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

class DeckListVC: UIViewController {
  
  let cardDB = DBHelper.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cardDB.downloadCards()
//    print(cardDB.isCardIdInCardDB(cardId: "a-fate-worse-than-death"))
  }
  
  func optionalStringConverter(string: String?) -> String{
    if let optionalString = string{
      if optionalString == ""{
        return "N/A"
      } else {
        return optionalString
      }
    } else {
      return "N/A"
    }
  }

//  func optionalIntConverter(int: Int?) -> Int{
//    if let optionalInt = int{
//      return optionalInt
//    } else {
//      return 0
//    }
//  }
  
}
