//
//  DeckListViewController.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 08/03/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

class DeckListVC: UITableViewController {

    let cardDB = DBHelper.sharedInstance
    var userDecks: Array<Deck> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        cardDB.downloadCards()
        downloadImages()
        updateImageDownloadStatus()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return userDecks.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath[1] == userDecks.count){
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeckListVCCellIdentifier", for: indexPath) as! DeckListVCAddCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeckListVCCellIdentifier", for: indexPath) as! DeckListVCCell
            return cell
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath[1] == userDecks.count){
            presentNewDeckPopup()
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
    func presentNewDeckPopup(){
        let newDeckVC = NewDeckPopUpVC(nibName: "NewDeckPopUpVC", bundle: nil)
//        newDeckVC.modalPresentationStyle = .overCurrentContext
//        newDeckVC.modalTransitionStyle = .crossDissolve
//        self.navigationController?.pushViewController(newDeckVC, animated: true)
        self.navigationController?.present(newDeckVC, animated: true, completion: nil)
//        self.p
    }
    
}
