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
        updateImageDownloadStatus()
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
        
        //Get the default documents directory, then create the /images/cardID saving path.
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error: Unable to access default documents URL.")
            return
        }
        let imageFolderURL = documentsURL.appendingPathComponent("images", isDirectory: true)
        do {try FileManager.default.createDirectory(at: imageFolderURL, withIntermediateDirectories: true, attributes: nil)}
        catch let error as NSError {NSLog("Unable to create directory \(error.debugDescription)")}
        
        for card in allCards{
            
            if !card.imageSavedLocally{
                //    Check to see if card has an image URL, and that it is not an empty string.
                if let selectedCard = card.imageURL,
                    selectedCard != ""{
                    
                    let imageDestinationURL = imageFolderURL.appendingPathComponent("\(card.id).jpg")
                    let pictureExists = FileManager().fileExists(atPath: imageDestinationURL.path)
                    
                    if !pictureExists{
                        //Convert selectedCard to the required URL.
                        guard let cardImageURL = URL(string: selectedCard) else {return}
                        
                        //Create URLSession to initiate download.
                        let session = URLSession(configuration: .default)
                        let request = URLRequest(url: cardImageURL)
                        let task = session.downloadTask(with: request) {
                            
                            (data, response, error) in
                            if let httpResponse =
                                response as? HTTPURLResponse,
                                httpResponse.statusCode == 200,
                                let data = data{
                                do
                                {try FileManager.default.copyItem(at: data, to: imageDestinationURL)}
                                catch
                                {print("Error: Unable to copy image from temporary URL to images folder.")}
                            }
                        }
                        task.resume()
                    }
                }
                else
                {
                    print("\(card.id) does not have an image URL and cannot be downloaded.")
                    continue
                }
            }
        }
    }
    
    func updateImageDownloadStatus(){
        
        let unsavedCardImages = cardDB.getAllUnsavedImages()
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let imageFolderURL = documentsURL.appendingPathComponent("images", isDirectory: true)
        
        //For each entry, check image directory for saved card, and if an image exists, update the DB.
        for card in unsavedCardImages{
            let imageDestinationURL = imageFolderURL.appendingPathComponent("\(card.id).jpg")
            let pictureExists = FileManager().fileExists(atPath: imageDestinationURL.path)
            if pictureExists{
                try! DBHelper.sharedInstance.DB.write {
                    card.imageSavedLocally = true
                }
            }
        }
    }
    
    
    
}
