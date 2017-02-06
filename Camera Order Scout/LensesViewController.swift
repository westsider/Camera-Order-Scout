//
//  LensesViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

/*
 // instanatiate the object
 var tableViewSwitches = TableViewSwitches()
 // VDL array from lenses VC
 var theArray = ["12mm", "18mm", "25mm","32mm", "50mm", "75mm"]
 // VDL  assign the original array
 tableViewSwitches.populateArrays(array: theArray)
 
 // upadate switch off 0 _ 3
 tableViewSwitches.updateArray(index: 0, switchPos: false)
 tableViewSwitches.updateArray(index: 2, switchPos: false)
 // update button
 tableViewSwitches.finalizeLensArray()
 */

class LensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var lensTableView: UITableView!
    
    // instanatiate switches object
    var tableViewSwitches = TableViewSwitches()
    
    let cellIdentifier = "primeLensTableViewCell"
    
    var originalArray = tableViewArrays.tableViewArray
    
    var lensKitArrayEdited = tableViewArrays.editedLensArray
    
    //var trackingIndex = [Bool]()
    
    // VDL array from lenses VC is lensKitArrayEdited
    // var theArray = ["12mm", "18mm", "21mm","35mm", "40mm", "Zeiss ZMP"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "L E N S  O R D E R"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableViewArrays.lensTableView() // load table view lenses
        
        originalArray = tableViewArrays.tableViewArray
        print("originalArray: \(originalArray)")
        
        lensKitArrayEdited = tableViewArrays.editedLensArray
        
        print("lensKitArrayEdited: \(lensKitArrayEdited)")
        
        //trackingIndex = [Bool](repeating: true, count: lensKitArrayEdited.count)
        
       // youShoudSeeThis(say: "****** viewWillAppear for Lenses - originalArray :", see: originalArray as AnyObject)
        
       //  youShoudSeeThis(say: "****** viewWillAppear for Lenses - lensKitArrayEdited :", see: lensKitArrayEdited as AnyObject)

        // VDL  assign the original array
        tableViewSwitches.populateArrays(array: lensKitArrayEdited)
    }
    
    //MARK: - Update the lens kit and return to main VC
    @IBAction func updateAction(_ sender: Any) {
        
        //print("edited main TableViewArray\(tableViewArrays.tableViewArray)")
        // update button
        tableViewSwitches.finalizeLensArray()
        // primes to return to main tableview: tableViewSwitches.returnedString
        tableViewArrays.editedLensKitReturendToMainTableView(sendString: tableViewSwitches.returnedString)
        print("updated main Tableview\(tableViewArrays.tableViewArray)")
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Set up tableview  lensesToMain
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lensKitArrayEdited.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! primeLensTableViewCell
        cell.lensLabel?.text =   lensKitArrayEdited[indexPath.row]
        // Send switch state and indexpath ro to this func?
        cell.lensSwitch.tag = indexPath.row
        cell.lensSwitch.restorationIdentifier = lensKitArrayEdited[indexPath.row] // lensKitArray[indexPath.row]
        cell.lensSwitch.addTarget(self, action: #selector(switchTriggered(sender:)), for: UIControlEvents.valueChanged)
        return cell
    }
    
    /// logic to modify a lens kit from swich positions in the lens kit tableView
    func switchTriggered(sender: UISwitch) {

        let index = sender.tag
        let content = sender.restorationIdentifier!
        
        print("Lens Switch Index: \(index) For: \(content) Is On: \(sender.isOn)")
        
        // upadate switch off 0 _ 3
        //tableViewSwitches.updateArray(index: 0, switchPos: false)
        tableViewSwitches.updateArray(index: index, switchPos: sender.isOn)
        
        // remove  element from Edited Array
        if sender.isOn != true {
        }
        // insert element to array
        if sender.isOn {
        }
    }
}
