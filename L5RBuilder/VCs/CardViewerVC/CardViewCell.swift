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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardLabel.font = UIFont(name: cardLabel.font.fontName, size: 15)
    }
    
    func showCardLabelIfNoImage(card: Card){
        if card.imageSavedLocally == false{
            cardLabel.isHidden = false
        }
        else{
            cardLabel.isHidden = true
        }
    }
    
}
