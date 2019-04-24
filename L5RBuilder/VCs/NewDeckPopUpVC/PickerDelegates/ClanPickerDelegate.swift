//
//  ClanPickerDelegate.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 19/04/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

protocol ClanDataDelegate: class {
    func didPassClan(passedClan: Clan)
}

class ClanPickerDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate{
    
    weak var delegate: ClanDataDelegate?
    let clanArray = Clan.allCases
    var selectedClan: Clan?

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (clanArray.count)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clanArray[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedClan = clanArray[row]
        
        if let clan = selectedClan{
            delegate?.didPassClan(passedClan: clan)
        }
    }
    
}
