//
//  FirstViewController.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 08/11/2018.
//  Copyright © 2018 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

class DeckListVC: UIViewController {
  
  let cardDB = DBHelper.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cardDB.downloadCards()
    downloadImages()
    
  }
  
  func optionalStringConverter(string: String?) -> String{
    if let optionalString = string{
      if optionalString == ""{
        return "N/A"
      } else {
        return optionalString
      }
    } else {
      return "N/A"
    }
  }
  
  func downloadImages(){
    
    let allCards = cardDB.getAllCards()
    let card = allCards[0]
//    for card in allCards{
    
      if !card.imageSavedLocally{
        
        //Check to see if card has an image URL. If not, move on to the next iteration.
//        guard
          let cardImageString = "http://lcg-cdn.fantasyflightgames.com/l5r/L5C06_98.jpg"
//          card.imageURL else {
//          print("\(card.id) does not have an image URL and cannot be downloaded.")
////          continue
//          return
//        }
        
        //Get the default documents directory, then create the /images/cardID saving path. Breaks if cannot access default URL.
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
          print("Error: Unable to access default documents URL.")
          return}
        
        let imageDestinationURL = documentsURL.appendingPathComponent("images").appendingPathComponent("\(card.id).jpg")
        
        //Convert cardImageString to the required URL.
        guard let cardImageURL = URL(string: cardImageString) else {return}
        
        //Create URLSession to initiate download.
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: cardImageURL)
        
        let task = session.downloadTask(with: request) {
          
          (data, response, error) in
          guard let httpResponse =
            response as? HTTPURLResponse,
            httpResponse.statusCode == 200,
            let data = data
            else {
              print("Error: Unable to download \(card.id) image from remote host.")
              return
          }
          
          do
          {
            try FileManager.default.copyItem(at: data, to: imageDestinationURL)
//            self.cardDB.updateLocalImageStatus(card: card, updateTo: true)
          } catch {
            print("Error")//"Error: Unable to copy \(card.id) image from temporary URL to images folder.")
          }
        }
        task.resume()
      }
    }
//  }
  
  
  
  
}
