//
//  RolePickerDelegate.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 19/04/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

protocol RoleDataDelegate: class{
    func didPassSelectedRole(passedRole: Card)
}

import UIKit
import RealmSwift

class RolePickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let db = DBHelper.sharedInstance
    let allRoles: Array<Card>
    var selectedRole: Card?
    weak var delegate: RoleDataDelegate?
    
    override init() {
        self.allRoles = db.getAllRoles()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allRoles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allRoles[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.didPassSelectedRole(passedRole: allRoles[row])
        print("Selected role row")
    }
    
}
