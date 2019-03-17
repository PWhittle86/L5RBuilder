//
//  NewDeckPopUpVCViewController.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 14/03/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

class NewDeckPopUpVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var strongholdCollectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let db = DBHelper.sharedInstance
    var strongholds: Results<Card>!
    
    override func viewDidLoad() {
        self.strongholdCollectionView.register(UINib.init(nibName: "strongholdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "strongholdCellID")
        self.strongholdCollectionView.dataSource = self
        self.strongholdCollectionView.delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.strongholds = self.db.getAllStrongholds()
       // self.delegate = delegate
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //This to be replaced with the number of stronghold cards pulled from db.
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.strongholdCollectionView.dequeueReusableCell(withReuseIdentifier: "strongholdCellID", for: indexPath)
        return cell
    }
 
    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
