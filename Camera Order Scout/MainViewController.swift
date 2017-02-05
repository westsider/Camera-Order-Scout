//
//  MainViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/4/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |             The Big difference in this iteration is the tableview equipment           |
     |             is now stored in the event class and will avoid confusion when            | 
     |             updating the table view lenses                                            |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/

import Foundation
import UIKit

var thisEvent: Event!

class MainTableViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var pickerEquipment = Equipment()       // picker equipment object
    
    var tableViewArrays = TableViewArrays()   // tableview array object
    
    var defaultUser = User(name: "Warren Hansen", production: "Nike", company: "CO3", city: "SantaMonica", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
     var image = [UIImage]()
    
     let cellIdentifier = "ListTableViewCell"

    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "C A M E R A  O R D E R"
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        thisEvent = Event(eventName: "Current", user: defaultUser, tableViewArray: [["1","cam","arri","alexa"]], images: image)
        thisEvent.images.append(thisEvent.user.icon)
        
        tableViewArrays.appendTableViewArray(title: "Warren Hansen Director of Photography", detail: "Camera Order Nike 12 / 20 / 2016", icon: defaultUser.icon)
    }
    
    //MARK: - Add Action
    
    @IBAction func addAction(_ sender: Any) {

        tableViewArrays.appendTableViewArray(title: "1 Camera", detail: "Arri Alexa", icon: UIImage(named: "cameraIcon")!)
        
        myTableView.reloadData()
    }
    

    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                             NEW AWESOME PICKER OBJECT                                 |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    // MARK: - Set up Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return   pickerEquipment.pickerArray[component].count //pickerEquipment[component].count
    
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerEquipment.pickerArray[component][row]
    }

    // MARK: - when picker wheels move change the pickerArray and reload
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            dontReloadOnComp0or3(component: component, row: row, lastCatagory: pickerEquipment.prevCatagory)
            reloadComponentsAndText(component: component, row: row)
            zeroThePicker(component: component, row: row)
    }
    
    //  make picker text fill space allowed
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.text = pickerEquipment.pickerArray[component][row]
        pickerLabel.font = UIFont(name: "Helvetica", size: 18) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.adjustsFontSizeToFitWidth = true
        return pickerLabel
    }
    
    // MARK: - Picker Convience Functions
    /// reload the text in picker depending on the component switched
    func reloadComponentsAndText(component: Int, row: Int) {
        
        switch component {  // reload only the next picker when prior wheel moves
        case 0:
        break           //  dont reload because quantity changes
        case 1:
            myPicker.reloadComponent(2)
            myPicker.reloadComponent(3)
        case 2:
            myPicker.reloadComponent(3)
        case 3:
        break           //  dont reload becuase only the model changed
        default:
            break
        }
    }
    
    ///  dont reload localPickerIndex when component 0 or 3 move
    func dontReloadOnComp0or3(component: Int, row: Int, lastCatagory: Int) {
        
        if component == 1 || component == 2 {     //  full update on comp 1 and 2 only
            pickerEquipment.setPickerArray(component: component, row: row, lastCatagory: pickerEquipment.prevCatagory)
        }
    }
    
    /// zero the picker wheels when Catagory changes
    func zeroThePicker(component: Int, row: Int){
        if component == 1 {  // with new catagory set wheel 2 and 3 safely to index 0
            myPicker.selectRow(0, inComponent: 2, animated: true)
            myPicker.selectRow(0, inComponent: 3, animated: true)
            pickerEquipment.prevCatagory = row    // if wheel 1 moves save the componennt to pass to setPickerArray
        }
    }
    
    // NEXT SET UP TABLE VIEW
    
    /*---------------------------------------------------------------------------------------
    |                                                                                       |
    |                             NEW AWESOME TABLEVIEW OBJECT                              |
    |                                                                                       |
    ---------------------------------------------------------------------------------------*/
    
    //MARK: Set up Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewArrays.tableViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        cell.imageTableViewCell.image = tableViewArrays.tableViewArray[indexPath.row][2] as? UIImage
        cell.titleTableView?.text =  tableViewArrays.tableViewArray[indexPath.row][0] as? String
        cell.detailTableView?.text =  tableViewArrays.tableViewArray[indexPath.row][1] as? String
        return cell
    }

}

