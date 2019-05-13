//
//  NewDeckPopUpVC.swift
//  L5RBuilder
//
//  Created by Peter Whittle on 26/03/2019.
//  Copyright © 2019 Peter Whittle. All rights reserved.
//

import UIKit
import RealmSwift

class NewDeckPopUpVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var clanNameTextfield: UITextField!
    @IBOutlet weak var strongholdTextfield: UITextField!
    @IBOutlet weak var roleTextfield: UITextField!
    
    //TODO: Add imageview & animation for stronghold/clan when selected.
    
    let db = DBHelper.sharedInstance
    weak var coordinator: MainCoordinator?
    
    var okButton = UIBarButtonItem()
    
    var selectedClan: Clan?
    var selectedStronghold: Card?
    var selectedRole: Card?

    let clanPickerView = UIPickerView()
    let strongholdPickerView = UIPickerView()
    let rolePickerView = UIPickerView()
    
    let clanPickerDelegate = ClanPickerDelegate()
    let strongholdPickerDelegate = StrongholdPickerDelegate()
    let rolePickerDelegate = RolePickerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPickerViews()
        hideTextFieldCursors()
        setUpOKButton()
        
        //This is the part you need in order for data to be returned to the view controller from the delegate!
        clanPickerDelegate.delegate = self
        strongholdPickerDelegate.delegate = self
        rolePickerDelegate.delegate = self
    }

    func setUpPickerViews(){
        clanPickerView.delegate = clanPickerDelegate
        clanPickerView.dataSource = clanPickerDelegate
        
        strongholdPickerView.delegate = strongholdPickerDelegate
        strongholdPickerView.dataSource = strongholdPickerDelegate
        
        rolePickerView.delegate = rolePickerDelegate
        rolePickerView.dataSource = rolePickerDelegate
        
        self.clanNameTextfield.inputView = self.clanPickerView
        self.strongholdTextfield.inputView = self.strongholdPickerView
        self.roleTextfield.inputView = self.rolePickerView
        addPickerToolbars()
    }
    
    func hideTextFieldCursors(){
        clanNameTextfield.tintColor = UIColor.clear
        roleTextfield.tintColor = UIColor.clear
        strongholdTextfield.tintColor = UIColor.clear
    }
    
    func addPickerToolbars(){
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
        strongholdTextfield.inputAccessoryView = toolBar
        roleTextfield.inputAccessoryView = toolBar
    }
    
    @objc func doneClick(){
        view.endEditing(true)
    }
    
    func allDataSelectedCheck(){
        guard let _ = self.selectedStronghold,
              let _ = self.selectedRole,
              let _ = selectedClan else{
                  return
        }
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func setUpOKButton() {
        
        self.okButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: Selector(("okButtonTapped")))
        self.navigationItem.rightBarButtonItem = okButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func okButtonTapped() {
        
//        Storyboard has been deleted, but this is how to get access to a storyboard, rather than doing it programatically.
//        let storyboard = UIStoryboard.init(name: "Deckbuilder", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "deckbuilderTabViewVC")

         if let selectedClan = self.selectedClan,
            let selectedStronghold = self.selectedStronghold,
            let selectedRole = selectedRole{
            
            let dynastyVC = DynastyDeckBuilderVC(clan: selectedClan, stronghold: selectedStronghold, role: selectedRole)
            let conflictVC = ConflictDeckBuilderVC(clan: selectedClan, stronghold: selectedStronghold, role: selectedRole)
            let tabView = DeckBuilderTabViewVC(with: dynastyVC, conflictVC: conflictVC)
            
            self.present(tabView, animated: true, completion: nil)
        }
    }
}

extension NewDeckPopUpVC: ClanDataDelegate{
    func didPassClan(passedClan: Clan) {
        self.selectedClan = passedClan
        self.clanNameTextfield.text = passedClan.rawValue
        
        //Update available strongholds to match selected clan.
        if let clan = selectedClan{
            self.strongholdPickerDelegate.strongholds = db.getAllClanStrongholds(clan: clan.rawValue.lowercased())
        }
        allDataSelectedCheck()
    }
}

extension NewDeckPopUpVC: StrongholdDataDelegate{
    func didPassSelectedStronghold(passedStronghold: Card) {
        self.selectedStronghold = passedStronghold
        self.strongholdTextfield.text = passedStronghold.name
        
        if let clan = Clan(rawValue: passedStronghold.clan.localizedCapitalized){
            self.selectedClan = clan
            self.clanNameTextfield.text = clan.rawValue
        }
        allDataSelectedCheck()
    }
}

extension NewDeckPopUpVC: RoleDataDelegate{
    func didPassSelectedRole(passedRole: Card) {
        self.selectedRole = passedRole
        self.roleTextfield.text = passedRole.name
        allDataSelectedCheck()
        //TODO: Add functionality which checks if the selected role matches the clan role, and presents an alert if it does not. Might want to set clan roles up with firebase remote config so they can be updated with rules changes.
    }
}
