//
//  NewDeckPopUpVC.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 26/03/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit

class NewDeckPopUpVC: UIViewController {
    
    @IBOutlet weak var clanNameTextfield: UITextField!
    @IBOutlet weak var strongholdTextfield: UITextField!
    @IBOutlet weak var roleTextfield: UITextField!
    
    var clans: Array<Clan> = Clan.allCases
    var strongholds: Array<Card> = []
    var roles: Array<Card> = []
    
    var selectedClan = Clan.unselected
    var selectedStronghold : Card?
    var selectedRole : Card?
    
    private var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpClanPickerView()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpClanPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.pickerView = pickerView
        self.clanNameTextfield.inputView = self.pickerView
        addPickerToolbar()
    }
    
}

extension NewDeckPopUpVC: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //-1 so that unselected does not appear as a user option.
        return (clans.count - 1)
    }
}

extension NewDeckPopUpVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clans[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.clanNameTextfield.text = clans[row].rawValue
    }
    
    func addPickerToolbar(){
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolBar.backgroundColor = UIColor(red: 72/256, green: 24/256, blue: 173/256, alpha: 0.5)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "OK", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneClick))
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        clanNameTextfield.inputAccessoryView = toolBar
    }
    
   @objc func doneClick(){
        view.endEditing(true)
    }
    
}

extension NewDeckPopUpVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.clanNameTextfield{
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
        }
    }
    
}
