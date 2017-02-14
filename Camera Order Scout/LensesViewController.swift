//
//  LensesViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//
//  find lens kit
//  pass lenskit to lens tableview
//  convert to array and populate tableview
//            that array edited
//                  that array returned to update realm tableview

import UIKit
import RealmSwift

class LensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var lensTableView: UITableView!
    
    var tableViewSwitches = TableViewSwitches()     // instanatiate switches object
    
    let cellIdentifier = "primeLensTableViewCell"
    
    var originalArray = [String]()
    
    var lensKitArrayEdited = tableViewArrays.editedLensArray
    
    var thePrimes = String()
    
    let realm = try! Realm()            // Get the default Realm
    
    let user = UserRealm()              // Use them like regular Swift objects
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "L E N S  O R D E R"
        print("\nWe got the primes from main vc \(thePrimes)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        originalArray = thePrimes.components(separatedBy: ", ")
        print("\noriginalArray: \(originalArray)")
        
        //tableViewArrays.lensTableView() // load table view lense
        //originalArray = tableViewArrays.tableViewArray
        //print("originalArray: \(originalArray)")
        //lensKitArrayEdited = tableViewArrays.editedLensArray
        //print("lensKitArrayEdited: \(lensKitArrayEdited)")
        // VDL  assign the original array
        //tableViewSwitches.populateArrays(array: lensKitArrayEdited)
    }
    
    //MARK: - Update the lens kit and return to main VC
    @IBAction func updateAction(_ sender: Any) {
        
        // return string of edited lens array
        tableViewSwitches.finalizeLensArray()
        
        // return edited lens string back to main tableview array
        tableViewArrays.editedLensKitReturendToMainTableView(sendString: tableViewSwitches.returnedString)
        print("\nupdated Tableview inside lenses vc: \(tableViewArrays.tableViewArray)")
        
        let newLensKit = tableViewSwitches.returnedString
        print("\n OK newLensKit is \(newLensKit)\n")
        
        //  create tableview row realm objects
        let newRow = TableViewRow()
        newRow.icon = "? icon" ;
        newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1]  + " " + pickerEquipment.pickerSelection[2] + " " +  pickerEquipment.pickerSelection[3]
        newRow.detail = newLensKit
        
        // get realm event and append tableview row objects
        let defaultEvent = realm.objects(EventRealm.self)
        for indexTwo in defaultEvent {
            // append new row
            try? realm .write {
                indexTwo.tableViewArray?.rows.append(objectsIn: [newRow])
            }
        }
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Set up tableview  lensesToMain
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return originalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! primeLensTableViewCell
        cell.lensLabel?.text =   originalArray[indexPath.row]
        // Send switch state and indexpath ro to this func?
        cell.lensSwitch.tag = indexPath.row
        cell.lensSwitch.restorationIdentifier = originalArray[indexPath.row] // lensKitArray[indexPath.row]
        cell.lensSwitch.addTarget(self, action: #selector(switchTriggered(sender:)), for: UIControlEvents.valueChanged)
        return cell
    }
    
    /// logic to modify a lens kit from swich positions in the lens kit tableView
    func switchTriggered(sender: UISwitch) {

        let index = sender.tag
        let content = sender.restorationIdentifier!
        
        print("Lens Switch Index: \(index) For: \(content) Is On: \(sender.isOn)")
        
        // change array of lenses with tableview switches
        tableViewSwitches.updateArray(index: index, switchPos: sender.isOn)
    }
}
