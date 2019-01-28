//
//  SecondViewController.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 08/11/2018.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

class CardViewerVC: UIViewController {
  
  let database = DBHelper.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

extension CardViewerVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let allCards = database.cardDB.objects(Card.self)
    return allCards.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: indexPath)
    if let label = cell.viewWithTag(100) as? UILabel {
      let allCards = database.cardDB.objects(Card.self)
      label.text = allCards[indexPath[1]].name
    }
    return cell
  }
  
}

