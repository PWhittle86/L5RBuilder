//
//  NewDeckPopUpVCViewController.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 14/03/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

protocol NewDeckPopUpVCViewControllerDelegate{
    func didTapCancel()
}

class NewDeckPopUpVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
//, NewDeckPopUpVCViewControllerDelegate
{
    func didTapCancel() {
        print("Cancel tapped.")
    }

    @IBOutlet weak var strongHoldCollectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
//    var delegate: NewDeckPopUpVCViewControllerDelegate?
    
//    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle? = nil, delegate: NewDeckPopUpVCViewControllerDelegate) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        self.delegate = delegate
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.strongHoldCollectionView.dataSource = self
        self.strongHoldCollectionView.delegate = self
        self.strongHoldCollectionView.register(UINib.init(nibName: "StrongholdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StrongholdCellID")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //This to be replaced with the number of stronghold cards pulled from db.
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = strongHoldCollectionView.dequeueReusableCell(withReuseIdentifier: "StrongholdCellID", for: indexPath) as! StrongholdCollectionViewCell
        
        return cell
    }

    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
