//
//  ConflictDeckBuilderVC.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 25/04/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

class ConflictDeckBuilderVC: UITableViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    let db = DBHelper.sharedInstance
    var deck: Deck
    var availableCards: Results<Card>
    
    init(deck: Deck) {
        self.deck = deck
        availableCards = db.getConflictCards()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        self.tabBarItem = UITabBarItem(title: "Conflict", image: UIImage(named: "conflictDeckIcon"), tag: 1)
        super.viewDidLoad()
        
        let deckbuilderNib = UINib(nibName: "DeckBuilderCardTableViewCell", bundle: nil)
        self.tableView.register(deckbuilderNib, forCellReuseIdentifier: "DeckBuilderCardTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableCards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DeckBuilderCardTableViewCell", for: indexPath) as? DeckBuilderCardTableViewCell {
            cell.setUpCell(indexPath: indexPath, availableCards: self.availableCards, cardCount: 0)
            return cell
        }
        
        let cell = UITableViewCell()
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

}
