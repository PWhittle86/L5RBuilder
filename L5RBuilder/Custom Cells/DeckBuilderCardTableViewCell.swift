//
//  DeckBuilderCardTableViewCell.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 17/06/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

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
    
    class func reUseIdentifier() -> String{
        return String(describing: self)
    }
    
}
