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
  
  class func downloadImages(cardDB: Realm){
    
    //Below should create an images folder when called.
    
    let fileManager = FileManager.default

    if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first{
      let filePath = documentDirectory.appendingPathComponent("images")
      if !fileManager.fileExists(atPath: filePath.path) {
        do {
          try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
        } catch {
          NSLog("Couldn't create document directory")
        }
      }
      NSLog("Document directory is \(filePath)")
    }
    
  }
  
}
