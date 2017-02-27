//
//  LensesViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import RealmSwift

class LensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var lensTableView: UITableView!
    
    @IBOutlet weak var titleDescription: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    var switchOn = true
    
    var tableViewSwitches = TableViewSwitches()
    
    var pickerEquipment = Equipment()
    
    let cellIdentifier = "primeLensTableViewCell"
    
    var originalArray = [String]()
    
    var thePrimes = [String]()
    
    var displayLensArray = [String]()
    
    var switchPos = [Bool]()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        originalArray = thePrimes
        setUpUI()
        tableViewSwitches.populateArrays(array: originalArray, reversed: switchOn)
    }
    
    //MARK: - add items not in list
    @IBAction func addItemsAction(_ sender: Any) {
        
        //  append new item to its realm object with switch pos 
        //  recall this fucker to update the local tableview array
        //  reload tableview

    }
    

    
    //MARK: - Update the lens kit and return to main VC
    @IBAction func updateAction(_ sender: Any) {
        
        tableViewSwitches.finalizeLensArray()         // return string of edited lens array
        
        let newLensKit = tableViewSwitches.returnedString
        
        //  create tableview row realm objects and differentiate lenses from aks
        let newRow = TableViewRow()
        newRow.icon = pickerEquipment.pickerSelection[1]
        if pickerEquipment.pickerState[1] < 5 {        //  populate lenses
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1]  + " " + pickerEquipment.pickerSelection[2] + " " +  pickerEquipment.pickerSelection[3]
            newRow.detail = newLensKit
            newRow.catagory = pickerEquipment.pickerState[1] // added for sort
        } else {                                        //     populate AKS ect
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1] 
            newRow.detail = newLensKit
            newRow.catagory = pickerEquipment.pickerState[1] // added for sort
        }
        
        // get realm event and append tableview row objects
        let id = getLastIdUsed()
        
        let currentEvent = realm.objects(EventUserRealm.self).filter("taskID == %@", id).first!
        
        try! realm.write {
            currentEvent.tableViewArray.append(newRow)
        }

        sortRealmEvent()
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Set up tableview  lensesToMain
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayLensArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! primeLensTableViewCell
        
        cell.lensLabel?.text =   displayLensArray[indexPath.row]
        
        // Send switch state and indexpath ro to this func?
        cell.lensSwitch.tag = indexPath.row
        cell.lensSwitch.restorationIdentifier = displayLensArray[indexPath.row] // lensKitArray[indexPath.row]
        cell.lensSwitch.addTarget(self, action: #selector(switchTriggered(sender:)), for: UIControlEvents.valueChanged)
        cell.lensLabel.adjustsFontSizeToFitWidth = true
        //cell.lensSwitch.isOn = switchPos[indexPath.row] //   remember swich position durring scroll
        return cell
    }
    
    /// logic to modify a lens kit from swich positions in the lens kit tableView
    func switchTriggered(sender: UISwitch) {

        let index = sender.tag
        let content = sender.restorationIdentifier!
        print("Lens Switch Index: \(index) For: \(content) Is On: \(sender.isOn)")
        // change array of lenses with tableview switches
        tableViewSwitches.updateArray(index: index, switchPos: sender.isOn)
        switchPos[sender.tag] = sender.isOn
        
        print("switch position: \(switchPos)")
    }
    
    func saveLastID(ID: String) {
        // save last used event id
        let id = EventTracking()
        try! realm.write {
            id.lastID = ID
            realm.add(id)
        }
    }
    
    func getLastIdUsed() -> String {
        //get lst id used
        let id = realm.objects(EventTracking.self)
        var lastIDvalue = String()
        if id.count > 0 {
            let thelastID = id.last
            lastIDvalue = (thelastID?.lastID)!
        } else {
            lastIDvalue = "\(id)"
        }
        return lastIDvalue
    }
    
    func setUpUI() {
        
        
        // modify page info by picker state
        if pickerEquipment.pickerState[1] == 1 {
            print("sent form primes")
            title = "Select Primes"
            // chage description , hide button
            titleDescription.text = "Switch off lenses not needed"
            addButton.isHidden = true
        }
        // 5 aks
        if pickerEquipment.pickerState[1] == 5 {
            print("sent form AKS")
            title = "Select AKS"
            titleDescription.text = "Switch On items needed"
            switchOn = false
            
            // load ream array to thos tableview... or skip this step and just use realm
            let realm = try! Realm()
            
            var todoList: Results<AksItem> {
                get {
                    return realm.objects(AksItem.self)
                }
            }
        }
        
        // 7 filters
        if pickerEquipment.pickerState[1] == 7 {
            print("sent form Filters")
            title = "Select Filters"
            titleDescription.text = "Switch On filters needed"
            switchOn = false
            
            // load ream array to thos tableview... or skip this step and just use realm
            let realm = try! Realm()
            
            var todoList: Results<FilterItem> {
                get {
                    return realm.objects(FilterItem.self)
                }
            }
            
            print("\nDid I get Filters from Realm? \(todoList)\n")
        }
        // 8 support
        if pickerEquipment.pickerState[1] == 8 {
            print("sent form Support")
            title = "Select Support"
            titleDescription.text = "Switch On items needed"
            switchOn = false
            
            // load ream array to thos tableview... or skip this step and just use realm
            let realm = try! Realm()
            
            var todoList: Results<SupportItem> {
                get {
                    return realm.objects(SupportItem.self)
                }
            }
            
            print("\nDid I get Support from Realm? \(todoList)\n")
        }
        
        // array to persiste switch positions durring deque of cells
        let i = displayLensArray.count
        var c = 0
        while c < i {
            switchPos.append(switchOn) // set switch pos from prior vc - off for aks
            c += 1
        }
    }
    
    /// the purpose of this func is to get the last event used
    func getLastEvent() -> EventUserRealm {
        
        let allIds = realm.objects(EventTracking.self)
        let allIdCount = allIds.count
        var index = allIdCount - 1
        if index < 0 { index = 0 }  // catch edited events causing index -1
        let id = realm.objects(EventTracking.self)[index].lastID
        let currentEvent = realm.objects(EventUserRealm.self).filter("taskID == %@", id).first!
        return currentEvent
    }
    
    /// sort latest realm event by catagory
    func sortRealmEvent() {
        
        let thisEvent = getLastEvent()
        
        let storageArea = thisEvent.tableViewArray
        
        let sorted = Array(storageArea.sorted(byKeyPath: "catagory"))
        
        try? realm.write {
            let sortedEvent = getLastEvent()
            sortedEvent.tableViewArray.removeAll()
            
            for items in sorted {
                sortedEvent.tableViewArray.append(items)
            }
            print("\n------------------------------------------------------\n")
            print("\nthis is the whole tableview replaced-----------\n\(sortedEvent)\n")
            print("\n------------------------------------------------------\n")
        }
    }
}
