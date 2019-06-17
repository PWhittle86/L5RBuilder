//
//  DeckBuilderCardTableViewCell.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 17/06/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

class DeckBuilderCardTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardCountLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
