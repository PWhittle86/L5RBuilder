//
//  DeckBuilderCardTableViewCell.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 17/06/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

class DeckBuilderCardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    class func reUseIdentifier() -> String {
        return String(describing: self)
    }
    
    func setUpCell(indexPath: IndexPath, availableCards: Results<Card>, cardCount: Int?){
        
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Unable to access default documents URL.")
            return
        }
        let imageFolderURL = documentsURL.appendingPathComponent("images", isDirectory: true)
        let imageURL = imageFolderURL.appendingPathComponent(availableCards[indexPath.row].id).appendingPathExtension("jpg")
        let locatedImage = UIImage(contentsOfFile: imageURL.path)
        
        self.cardImageView.image = locatedImage
        self.cardNameLabel.text = availableCards[indexPath.row].name
        self.cardCountLabel.text = "\(cardCount ?? 0)/3"
    }
    
}
