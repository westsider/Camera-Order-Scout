//
//  LensesViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class LensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var lensTableView: UITableView!
    
    
    let cellIdentifier = "primeLensTableViewCell"
    
    var originalArray = tableViewArrays.tableViewArray
    
    var lensKitArrayEdited = tableViewArrays.editedLensArray
    
    var trackingIndex = [Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "L E N S  O R D E R"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableViewArrays.lensTableView() // load table view lenses
        
        originalArray = tableViewArrays.tableViewArray
        
        lensKitArrayEdited = tableViewArrays.editedLensArray
        
        print("lensKitArrayEdited: \(lensKitArrayEdited)")
        
        trackingIndex = [Bool](repeating: true, count: lensKitArrayEdited.count)
        
       // youShoudSeeThis(say: "****** viewWillAppear for Lenses - originalArray :", see: originalArray as AnyObject)
        
       //  youShoudSeeThis(say: "****** viewWillAppear for Lenses - lensKitArrayEdited :", see: lensKitArrayEdited as AnyObject)
    }
    
    //MARK: - Update the lens kit and return to main VC
    @IBAction func updateAction(_ sender: Any) {
      // print original array - edited array and main tableview array
        
        tableViewArrays.returnEditdedLesesToTableviewArray()
        
        print("edited main TableViewArray\(tableViewArrays.tableViewArray)")
        
        for item in trackingIndex {
            print(item)
            if item == false {
                
            }
        }
        
        // makking major progress - just need to remove switched off values.....
        
        /*
        Thing lift to do:
        
         finish removing itmes from array
         check the main table view for success
         
         add user vc
        
        */
    }
        

        
        
        
        // update equipmet array for Main VC
//        myEquipment.equipment[4] = lensKitArrayEdited.joined(separator: ", ")
//        youShoudSeeThis(say: "Updated myEquipment.equipment[4] ", see: myEquipment.equipment[4] as AnyObject)
//        
//        // need to update tablviewarray   thisEvent.updateLensKit in myEquipment.equipment[4]
//        
//        // this will update the equipment but not the tableview array
//        myEquipment.updateLensKit(update: lensKitArrayEdited.joined(separator: ", "))
//        
//        // update the tableview
//        myEquipment.tableViewArray = thisEvent.populateTableview(catagory:  myEquipment.thisCompState[1] )
        
//  _ = navigationController?.popToRootViewController(animated: true)
        
    
    
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
        
        // remove  element from Edited Array
        if sender.isOn != true {
            
            trackingIndex[index] = false
            //tableViewArrays.removeFromList(index: index)
            print(trackingIndex)
            //print("lensKitArrayEdited Removed \(tableViewArrays.editedLensArray)")

        }
        
        // insert element to array
        if sender.isOn {
            trackingIndex[index] = true
            print(trackingIndex)
            //tableViewArrays.addToList(index: index)
            //print("\nlensKitArrayEdited Added \(lensKitArrayEdited)")
        }
        //print("originalArray Size Is: \(tableViewArrays.originalArray.count) lensKitArrayEdited Size Is: \(tableViewArrays.editedLensArray.count)\n")
    }
}
