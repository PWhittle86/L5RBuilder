//
//  DeckListVCCell.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 08/03/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

class DeckListVCAddCell: UITableViewCell {
    
    @IBOutlet weak var addButton: UIImageView!
    @IBOutlet weak var newDeckLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
