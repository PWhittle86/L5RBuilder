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
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    let database = DBHelper.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension CardViewerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let allCards = database.DB.objects(Card.self)
        return allCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: indexPath) as! CardViewCell
        let allCards = database.DB.objects(Card.self)
        
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else
        {
            print("Error: Unable to access default documents URL.")
            return cell
        }
        let imageFolderURL = documentsURL.appendingPathComponent("images", isDirectory: true)
        let imageURL = imageFolderURL.appendingPathComponent(allCards[indexPath[1]].id).appendingPathExtension("jpg")
        let locatedImage = UIImage(contentsOfFile: imageURL.path)
        
        cell.cardImageView.image = locatedImage
        cell.cardLabel.text = allCards[indexPath[1]].name
        
    return cell
}
    
}

