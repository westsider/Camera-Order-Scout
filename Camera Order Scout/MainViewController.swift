//
//  MainViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//
/*  feat: a new feature
 fix: a bug fix
 docs: changes to documentation
 style: formatting, missing semi colons, etc; no code change
 refactor: refactoring production code
 test: adding tests, refactoring test; no production code change
 chore: updating build tasks, package manager configs, etc; no production code change    */

//  task: set up lenses vc
//  task: populate lense vc - return to main vc tue     mon 2/6
//  task: set up user vc                                mon 2/6
//  task: set up + populate past orders vc              mon 2/6 - where i was stuck : )
//  task: pass user to and from user vc *** thisEvent.user tue 2/7
//  task: set up + populate aks - feed to lenses?       tue 2/7
//  task: set up + populate filters                     tue 2/7
//  task: set up + populate support                     tue 2/7
//  task: implement core data - nogo
//  task: finish past orders                            thur 2/10
//  task: realm persistence of user                     fri 2/11
//  task: realm persistence of event                    sat 2/11
//  create and Event that can store Event Name
//  task: create and Event that can store User          sat 2/11
//  task: use realm to add tableview rows               sun 2/12
//  check add user, - working except date bug
//  bug - getting multiple events, should only be created on first run
//  task: add items to tableview
//  task: get rid of optional in tableview
//  task: first load tableview and subsequent runs load the tableview correctly
//  task: store EventTableView inside event             sun 2/12
//  task: populate tableview from event tableview
//  task: add lens kit to tableview  array event realm
//  task: fix date
//  task: implement icon + removed problem with load tableview
//  task: print statements and unused functions and files                               mon 2/13
//  task: black or white icons only
//  fix: add aks arrow down removed from tableview

//  chore: need to update the user model and event model to move foreward
//      clear realm, change models, fix errors
//          get model working add camera good, add lens good
//              get update user working

//                  get add new event working
//                      delete items in current tableview

//  task: realm persistence of past events
//  task: move equipment and tableviewarrays inside this class and push to lenses vc

//  feat: done with persistance
//  task: first run Tutorial                            mon 2/13
//  http://stackoverflow.com/questions/13335540/how-to-make-first-launch-iphone-app-tour-guide-with-xcode
//  task: turn print into share                         mon 2/13
//  task: finish all extra equipment                    mon 2/13

// fix back to say back
// tableview array object -- should replace with  thisEvent.tableViewArray, copy updateUser and updateTableView

import Foundation
import UIKit
import RealmSwift

var pickerEquipment = Equipment()       // needs to move inside the class and pushed to lenses vc

var tableViewArrays = TableViewArrays()

class MainTableViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var image = [UIImage]()
    
    let cellIdentifier = "ListTableViewCell"
    
    let isFirstLaunch = UserDefaults.isFirstLaunch()
    
    let realm = try! Realm()
    
    let defaultEvent = EventUserRealm()
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        
        //Mark: - on first run
        let checkEventUser = realm.objects(EventUserRealm.self)
        
        if checkEventUser.count == 0 {
            
            let defaultEventUsers = EventUserRealm()
            
            // in first run fill in values with defaut
            defaultEventUsers.eventName = "first event"
            defaultEventUsers.userName = "first user"
            defaultEventUsers.city = "Santa Monica, CA"
            defaultEventUsers.production  = "new production"
            defaultEventUsers.company  = "new company"
            defaultEventUsers.date  = "no date yet"
            
            //                  create tableview object
            let rowOne = TableViewRow()
            rowOne.icon = "man" ; rowOne.title = "\(defaultEventUsers.userName) Director of Photography" ; rowOne.detail = "Camera Order \(defaultEventUsers.production) \(defaultEventUsers.date )"
            
            let defaultTableview = EventTableView()
            defaultTableview.rows.append(objectsIn: [rowOne])
            //defaultEvent.tableViewArray = defaultTableview
            defaultEventUsers.tableViewArray = defaultTableview
            tableViewArrays.appendTableViewArray(title: "\(defaultTableview.rows[0].title)", detail: "\(defaultTableview.rows[0].detail)", compState: [0,0,0,0])
  
            print(defaultEventUsers)
            print("\nFirst run defaultEventUsers:\n\(defaultEventUsers)")
            //  persiste default event
            try! realm.write {
                realm.add(defaultEventUsers)
            }
            
            // save last used event id
            saveLastID(ID: defaultEventUsers.taskID)
            print("\nFirst Run event name: \(defaultEventUsers.eventName) user name: \(defaultEventUsers.userName) savedID = \(defaultEventUsers.taskID)")
        } else {
            //Mark: - we have a past user and will get last id used
            let id = getLastIdUsed()
            
            var message = "we have more than one event and last saved id is \(id)\n"
            
            let currentEvent = realm.objects(EventUserRealm.self).filter("taskID == %@", id)
            
            message += "\nLast event was fetched and is this: \n\(currentEvent)"; print(message)
            
            populateTableviewFromEvent(currentEvent: currentEvent)      // populate tableview
        }
        
        //myTableView.reloadData(); print("\nEnd of viewWillAppear ") // reload when returning to this VC
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "C A M E R A  O R D E R"
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
        myTableView.reloadData()
        updatePickerSelection() // so we dont get nil on first run
    }
    
    //Mark: - Save current Event
    @IBAction func saveAction(_ sender: Any) {
        
        
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                             add equipment to tableview                                |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    //MARK: - Add Action
    @IBAction func addAction(_ sender: Any) {
        
        print("\nEntering Action to populate tableview")
        // if a new camera
        if pickerEquipment.pickerState[1] == 0 {
            //  create tableview row realm objects
            let newRow = TableViewRow()
            newRow.icon = pickerEquipment.pickerSelection[1];                                               print("Realm Icon:\(newRow.icon)")
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1];   print("Realm Title:\(newRow.title)")
            newRow.detail = pickerEquipment.pickerSelection[2] + " " +  pickerEquipment.pickerSelection[3]; print("Realm Detail:\(newRow.detail)")
            
            // get realm event and append tableview row objects
            //get lst id used
            let id = getLastIdUsed()
            
            var message = "Saved id is\n\(id)\n"
            
            let currentEvent = realm.objects(EventUserRealm.self).filter("taskID == %@", id)
            
            try! realm.write {
                currentEvent[0].tableViewArray?.rows.append(objectsIn: [newRow])
            }
            
            message += "\(currentEvent.count) Event(s) fetched and are:\n\(currentEvent)"
            
            // append camera to tableview
            tableViewArrays.appendTableViewArray(title: pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1], detail: pickerEquipment.pickerSelection[2] + " " + pickerEquipment.pickerSelection[3], compState: pickerEquipment.pickerState)
            myTableView.reloadData()
        }
        // if a lens segue to lenses
        if pickerEquipment.pickerState[1] > 0 && pickerEquipment.pickerState[1] <= 5  {
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState) // populate the next controller?
            
            let myVc = storyboard?.instantiateViewController(withIdentifier: "lensViewController") as! LensesViewController
            myVc.thePrimes = tableViewArrays.thePrimes
            navigationController?.pushViewController(myVc, animated: true)
        }
        
        // segue to aks ect
        if pickerEquipment.pickerState[1] > 5{
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState) // populate the next controller?
            
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState)
            let myVc = storyboard?.instantiateViewController(withIdentifier: "lensViewController") as! LensesViewController
            myVc.thePrimes = tableViewArrays.thePrimes
            navigationController?.pushViewController(myVc, animated: true)
        }
    }
    
    //MARK: - Share Camera Order
    @IBAction func shareAction(_ sender: Any) {
        
        let message = tableViewArrays.messageContent()
        print(message)
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                             NEW AWESOME PICKER OBJECT                                 |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    //MARK: - Set up Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    //Mark: - The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return   pickerEquipment.pickerArray[component].count //pickerEquipment[component].count
        
    }
    
    //Mark: - The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerEquipment.pickerArray[component][row]
    }
    
    //MARK: - when picker wheels move change the pickerArray and reload
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        dontReloadOnComp0or3(component: component, row: row, lastCatagory: pickerEquipment.prevCatagory)
        reloadComponentsAndText(component: component, row: row)
        zeroThePicker(component: component, row: row)
        
        // set pickerSelected property with picker array current selection *** I wish this was a function
        pickerEquipment.pickerState = [ myPicker.selectedRow(inComponent: 0), myPicker.selectedRow(inComponent: 1), myPicker.selectedRow(inComponent: 2), myPicker.selectedRow(inComponent: 3) ]
        
        //Mark: - update pickerSelection
        updatePickerSelection()

    }
    
    //Mark: -  make picker text fill horizontal space allowed
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
    
    //Mark: -  dont reload localPickerIndex when component 0 or 3 move
    func dontReloadOnComp0or3(component: Int, row: Int, lastCatagory: Int) {
        
        if component == 1 || component == 2 {     //  full update on comp 1 and 2 only
            pickerEquipment.setPickerArray(component: component, row: row, lastCatagory: pickerEquipment.prevCatagory)
        }
    }
    
    //Mark: - zero the picker wheels when Catagory changes
    func zeroThePicker(component: Int, row: Int){
        if component == 1 {  // with new catagory set wheel 2 and 3 safely to index 0
            myPicker.selectRow(0, inComponent: 2, animated: true)
            myPicker.selectRow(0, inComponent: 3, animated: true)
            pickerEquipment.prevCatagory = row    // if wheel 1 moves save the componennt to pass to setPickerArray
        }
    }
    //Mark: - update pickerSelection
    func updatePickerSelection() {
        pickerEquipment.pickerSelection[0] = pickerEquipment.pickerArray[0][pickerEquipment.pickerState[0]]
        pickerEquipment.pickerSelection[1] = pickerEquipment.pickerArray[1][pickerEquipment.pickerState[1]]
        pickerEquipment.pickerSelection[2] = pickerEquipment.pickerArray[2][pickerEquipment.pickerState[2]]
        pickerEquipment.pickerSelection[3] = pickerEquipment.pickerArray[3][pickerEquipment.pickerState[3]]
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                             NEW AWESOME TABLEVIEW OBJECT                              |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    
    //MARK: - Set up Table View
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
    


    
    //MARK: - Segue to User VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {

            
            performSegue(withIdentifier: "mainToUser", sender: self)
        }
    }
    

    //Mark: - populate the tableview
    func populateTableviewFromEvent(currentEvent: Results<EventUserRealm> ) {
        
        tableViewArrays.removeAll(); print("\nclear the tableview array\n")
        
        for items in currentEvent {     // populate tableview
            // here's whats in the event
            
            print("here's whats in each item tableview row: \(items.tableViewArray?.rows[0].title)")
            
            for eachRow in (items.tableViewArray?.rows)! {
                print("\nhere is each row: \(eachRow)")
                
                tableViewArrays.appendTableViewArray(title: eachRow.title, detail: eachRow.detail, compState: pickerEquipment.pickerState)
            }
        }
        myTableView.reloadData()
    }

    
    @IBAction func clearRealmAction(_ sender: Any) {
        deleteRealmObject()
    }
    func deleteRealmObject() {
        try! realm.write {
            realm.deleteAll()
        }
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
        print("last is\(id)")
        var lastIDvalue = String()
        if id.count > 0 {
            print("more than 1 id\(id.count)")
            let thelastID = id.last
            lastIDvalue = (thelastID?.lastID)!
        } else {
            print("only 1 ID")
            lastIDvalue = "\(id)"
        }
        return lastIDvalue
    }
}

