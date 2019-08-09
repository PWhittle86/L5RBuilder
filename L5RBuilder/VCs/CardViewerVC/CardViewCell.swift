//
//  cardViewCell.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 08/03/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
    
    let database = DBHelper.sharedInstance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardLabel.font = UIFont(name: "brushtipTexeTRIAL", size: 20)
    }
    
    func setUpCardCell(indexpath: IndexPath){
    
        let allCards = database.DB.objects(Card.self)
        
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else
        {
            print("Error: Unable to access default documents URL.")
            return
        }
        let imageFolderURL = documentsURL.appendingPathComponent("images", isDirectory: true)
        let imageURL = imageFolderURL.appendingPathComponent(allCards[indexpath.row].id).appendingPathExtension("jpg")
        let locatedImage = UIImage(contentsOfFile: imageURL.path)
        
        self.cardImageView.image = locatedImage
        self.cardLabel.text = allCards[indexpath.row].name
    }
    
}
