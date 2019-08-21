//
//  DeckBuilderCardTableViewCell.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 17/06/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

protocol CardCellDelegate: class {
    func removeCardTapped(card: Card)
    func addCardTapped(card: Card)
}

class DeckBuilderCardTableViewCell: UITableViewCell {
    
    var card: Card?
    weak var delegate: CardCellDelegate?
    
    @IBOutlet weak var removeCardButton: UIButton!
    @IBOutlet weak var addCardButton: UIButton!
    
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
        
        self.card = availableCards[indexPath.row]
        
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Unable to access default documents URL.")
            return
        }
        
        let imageFolderURL = documentsURL.appendingPathComponent("images", isDirectory: true)
        let imageURL = imageFolderURL.appendingPathComponent(availableCards[indexPath.row].id).appendingPathExtension("jpg")
        let locatedImage = UIImage(contentsOfFile: imageURL.path)
        
        let numberOfCards = cardCount ?? 0
        
        //TODO: Refactor this so that it's using the card property, rather than the instance within the array.
        self.cardImageView.image = locatedImage
        self.cardNameLabel.text = availableCards[indexPath.row].name
        self.cardCountLabel.text = "\(numberOfCards)/3"
        
        canAddCardsCheck(cardsInDeck: numberOfCards)
        canRemoveCardsCheck(cardsInDeck: numberOfCards)
    }
    
    @IBAction func removeCardTapped(_ sender: Any) {
        if let selectedCard = card,
            let delegate = delegate {
            self.delegate?.removeCardTapped(card: selectedCard)
        }
    }
    
    @IBAction func addCardTapped(_ sender: Any) {
        if let selectedCard = card,
            let _ = delegate {
            self.delegate?.addCardTapped(card: selectedCard)
        }
    }
    
    func canRemoveCardsCheck(cardsInDeck: Int){
        if cardsInDeck == 0 {
            self.removeCardButton.isEnabled = false
        } else {
            self.removeCardButton.isEnabled = true
        }
    }
    
    func canAddCardsCheck(cardsInDeck: Int){
        if cardsInDeck == 3{
            self.addCardButton.isEnabled = false
        } else {
            self.addCardButton.isEnabled = true
        }
    }
}
