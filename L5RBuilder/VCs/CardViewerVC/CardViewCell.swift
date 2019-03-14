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
        cardLabel.font = UIFont(name: "brushtipTexeTRIAL", size: 20)
    }
    
}
