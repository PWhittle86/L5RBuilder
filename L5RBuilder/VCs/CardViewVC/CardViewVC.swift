//
//  CardViewVC.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 26/07/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

protocol cardViewDelegate: class {
    func addCards(card: Card, numberOfCards: Int)
}

class CardViewVC: UIViewController  {
    
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardTraitsLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var cardCountSegmentControl: UISegmentedControl!
    
    weak var delegate: cardViewDelegate?
    
    let card: Card
    var cardsCount: Int
    
    init(card: Card, cardCount: Int) {
        self.card = card
        self.cardsCount = cardCount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setUpImage()
        setUpLabels()
        cardCountSegmentControl.addTarget(self, action: Selector(("updateCardCount")), for: .valueChanged)
        cardCountSegmentControl.selectedSegmentIndex = cardsCount
        super.viewDidLoad()
    }
    
    func setUpImage() {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Unable to access default documents URL.")
            return
        }
        let imageFolderURL = documentsURL.appendingPathComponent("images", isDirectory: true)
        let imageURL = imageFolderURL.appendingPathComponent(card.id).appendingPathExtension("jpg")
        let locatedImage = UIImage(contentsOfFile: imageURL.path)
        
        self.cardImageView.image = locatedImage
    }
    
    func setUpLabels() {
        
        var traitString = ""
        
        if card.traits.isEmpty {
            cardTraitsLabel.isHidden = true
        } else {
            if card.traits.count == 1 {
                if let cardTraitText = card.traits[0]{
                    traitString = cardTraitText
                }
            } else {
                for trait in card.traits {
                    if let cardTraitText = trait {
                        traitString.append(cardTraitText)
                        traitString.append(", ")
                    }
                }
                traitString.removeLast(2)
            }
        }
        cardTitleLabel.text = card.name
        cardTraitsLabel.text = traitString
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.delegate?.addCards(card: self.card, numberOfCards: cardsCount)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func updateCardCount() {
        self.cardsCount = cardCountSegmentControl.selectedSegmentIndex
        print("\(cardsCount) \(card.id) cards selected.")
    }
    
}
