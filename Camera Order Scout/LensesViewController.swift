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
    
    var tableViewSwitches = TableViewSwitches()     // instanatiate switches object
    
    let cellIdentifier = "primeLensTableViewCell"
    
    var originalArray = [String]()
    
    var thePrimes = String()
    
    let realm = try! Realm()            // Get the default Realm
    
    let user = UserRealm()              // Use them like regular Swift objects
    
    var eventToWorkOn = EventRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "L E N S  O R D E R"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // convert string to array
        originalArray = thePrimes.components(separatedBy: ", ")
        //  print("\noriginalArray: \(originalArray)")
        // populate the array to edit with switches
        tableViewSwitches.populateArrays(array: originalArray)
    }
    
    //MARK: - Update the lens kit and return to main VC
    @IBAction func updateAction(_ sender: Any) {
        
        // return string of edited lens array
        tableViewSwitches.finalizeLensArray()
        
        let newLensKit = tableViewSwitches.returnedString
        //  print("\n OK newLensKit is \(newLensKit)\n")
        
        //  create tableview row realm objects and differentiate lenses from aks
        let newRow = TableViewRow()
        newRow.icon = pickerEquipment.pickerSelection[1]
        if pickerEquipment.pickerState[1] < 5 {        //  populate lenses
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1]  + " " + pickerEquipment.pickerSelection[2] + " " +  pickerEquipment.pickerSelection[3]
            newRow.detail = newLensKit
        } else {                                        //     populate AKS ect
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1] 
            newRow.detail = newLensKit
        }
        
        // get realm event and append tableview row objects
        let defaultEvent = realm.objects(EventRealm.self)
        for indexTwo in defaultEvent {
            
            print("\nloaded savedEvent : \(indexTwo.eventName)")
            
            if globalCurrentEvent == indexTwo.eventName {
                print("\nWHOA!! We have a match bettween \(globalCurrentEvent) and \(indexTwo.eventName)")
                eventToWorkOn = indexTwo
                print("\nthis is the eventToWorkOn: \(eventToWorkOn)")
                
                // append new row
                try? realm .write {
                    eventToWorkOn.tableViewArray?.rows.append(objectsIn: [newRow])
                }
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
