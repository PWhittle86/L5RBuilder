//
//  cardImage.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 12/19/18.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import Foundation
import RealmSwift

class cardImage: NSObject{
  
  let url: NSURL
  let cardDB = DBHelper.sharedInstance
  
  init(url: NSURL) {
    self.url = url
  }
    
}
