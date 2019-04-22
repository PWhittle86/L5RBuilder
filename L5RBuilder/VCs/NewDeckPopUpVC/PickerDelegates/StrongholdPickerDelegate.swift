//
//  StrongholdPickerDelegate.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 19/04/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

protocol StrongholdDataDelegate: class {
    func didPassSelectedStronghold(passedStronghold: Card)
}

class StrongholdPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: StrongholdDataDelegate?
    let db = DBHelper.sharedInstance
    var strongholds: Results<Card>
    var selectedStronghold: Card?
    
    override init() {
        self.strongholds = db.getAllStrongholds()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return strongholds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return strongholds[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedStronghold = strongholds[row]
        if let stronghold = self.selectedStronghold{
            delegate?.didPassSelectedStronghold(passedStronghold: stronghold)
        }
    }
    
    //TODO: Add function which will automatically add the first picker row entry to the textfield, and send the value to the newDeckVC.
    
}
