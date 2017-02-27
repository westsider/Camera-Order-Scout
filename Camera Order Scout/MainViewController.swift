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
//                      find bug: updating user name sets both tableview names
//                          take debugging class, use realm as tableview
//                          bug: adding lens doesnt show up in tableview, construct tableview from RealmEvent
//                              task: move equipment and tableviewarrays inside this class and push to lenses vc
//                                  task: delete items in current tableview
//                                      task: delete items in events
//                                          task:add tableview icons
//  feat: finished implementing persistance with realm                                  tue 2/21
//  cameras now plural
//  task: turn print into share
//  fix: back to <
//  task: first run Tutorial
//  http://stackoverflow.com/questions/13335540/how-to-make-first-launch-iphone-app-tour-guide-with-xcode
//  auto size lens tableview for longet lines
//  zoom & probe not repopulating lens
//  probe populates lens items
//  task: finish all extra equipment
//  fix: lens order title wrong for aks
//  task: switches off by default for aks, support
//  test: completed test of tableview switches
//  task: add write in AKS, Support - add new view - add text to array - make persistant
//  task: updated to realm 2.4.3
//  task: sort list by: camera, primes, macros, probes, zooms, aks ect

//  task: make UI Awesome
//  task: how-to images



import Foundation
import UIKit
import RealmSwift

class MainTableViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var currentEventLable: UILabel!
    
    var image = [UIImage]()
    
    let cellIdentifier = "ListTableViewCell"
    
    let isFirstLaunch = UserDefaults.isFirstLaunch()
    
    var tableViewArrays = TableViewArrays() // this is only to pass primes kit to next vc
    
    var pickerEquipment = Equipment()       // needs to move inside the class and pushed to lenses vc
    
    let realm = try! Realm()
    
    var tableviewEvent = EventUserRealm()
    
    //MARK: - Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        
        //Mark: - on first run
        let checkEventUser = realm.objects(EventUserRealm.self)
        
        if checkEventUser.count == 0 {
            
            FirstRun().populateRealmKits() // set up realm kits for user additions
            
            let defaultEventUsers = EventUserRealm()
            
            // in first run fill in values with defaut
            defaultEventUsers.eventName = "first event"
            defaultEventUsers.userName = "first user"
            defaultEventUsers.city = "Santa Monica, CA"
            defaultEventUsers.production  = "new production"
            defaultEventUsers.company  = "new company"
            defaultEventUsers.date  = "no date yet"
            currentEventLable.text = "first event"
            
            //                  create tableview object
            let rowOne = TableViewRow()
            rowOne.icon = "man" ; rowOne.title = "\(defaultEventUsers.userName) Director of Photography" ; rowOne.detail = "Camera Order \(defaultEventUsers.production) \(defaultEventUsers.date )"
            rowOne.catagory = -1 // added for sort

            defaultEventUsers.tableViewArray.append(rowOne) // = defaultTableview
  
            try! realm.write {                   //  persiste default event
                realm.add(defaultEventUsers)
            }
            
            saveLastID(ID: defaultEventUsers.taskID)    // save last used event id
            
            tableviewEvent = defaultEventUsers  // populate tableview
            
            // on first launch go to info screen
            performSegue(withIdentifier: "mainToInfo", sender: self)

        } else {
            
            //Mark: - we have a past user and will get last id used
            let currentEvent = getLastEvent()
            
            tableviewEvent = currentEvent   // populate tableview
            
            currentEventLable.text = currentEvent.eventName // show event name in UI
        }
        
        currentEventLable.isHidden = true
        myTableView.reloadData();
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "C A M E R A  O R D E R"
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
        myTableView.reloadData()
        updatePickerSelection() // so we dont get nil on first run
        sortRealmEvent()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    //Mark: - Save current Event
    @IBAction func saveAction(_ sender: Any) { }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                             add equipment to tableview                                |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    //MARK: - Add Action
    @IBAction func addAction(_ sender: Any) {
        
        // if 1 new camera or zoom 4
        if pickerEquipment.pickerState[1] == 0  && pickerEquipment.pickerState[0] == 0 {
            //  create tableview row realm objects
            let newRow = TableViewRow()
            newRow.icon = pickerEquipment.pickerSelection[1];
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1];
            newRow.detail = pickerEquipment.pickerSelection[2] + " " +  pickerEquipment.pickerSelection[3];
            newRow.catagory = pickerEquipment.pickerState[1] // added for sort

            let currentEvent = getLastEvent()
            try! realm.write {
                currentEvent.tableViewArray.append(newRow)
            }
            
            sortRealmEvent()
            
            myTableView.reloadData()
            
        } else         // if 2+ new cameras
        if pickerEquipment.pickerState[1] == 0  && pickerEquipment.pickerState[0] > 0 {
            //  create tableview row realm objects
            let newRow = TableViewRow()
            newRow.icon = pickerEquipment.pickerSelection[1];
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1] + "s";
            newRow.detail = pickerEquipment.pickerSelection[2] + " " +  pickerEquipment.pickerSelection[3];
            newRow.catagory = pickerEquipment.pickerState[1] // added for sort
            let currentEvent = getLastEvent()
            try! realm.write {
                currentEvent.tableViewArray.append(newRow)
            }
            
            sortRealmEvent()
            
            myTableView.reloadData()
        }
        // if a lens segue to lenses
        if pickerEquipment.pickerState[1] > 0 && pickerEquipment.pickerState[1] <= 3  {
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState) // populate var for the next controller
            let myVc = storyboard?.instantiateViewController(withIdentifier: "lensViewController") as! LensesViewController
            myVc.thePrimes = tableViewArrays.thePrimes   //TableViewArrays().setPrimesKit(compState: pickerEquipment.pickerState)
            myVc.displayLensArray = tableViewArrays.displayLensArray
            myVc.pickerEquipment = pickerEquipment  // push picker login to next vc
            navigationController?.pushViewController(myVc, animated: true)
        }
        
        // if a zoom lens, just add
        if pickerEquipment.pickerState[1] == 4 {
            //  create tableview row realm objects
            let newRow = TableViewRow()
            newRow.icon = pickerEquipment.pickerSelection[1];
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1];
            newRow.detail = pickerEquipment.pickerSelection[2] + " " +  pickerEquipment.pickerSelection[3];
            newRow.catagory = pickerEquipment.pickerState[1] // added for sort
            let currentEvent = getLastEvent()
    sortRealmEvent()
            try! realm.write {
                currentEvent.tableViewArray.append(newRow)
            }
            myTableView.reloadData()
        }
        
        // if a finder, just add
        if pickerEquipment.pickerState[1] == 6 {
            //  create tableview row realm objects
            let newRow = TableViewRow()
            newRow.icon = pickerEquipment.pickerSelection[1];
            newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1];
            newRow.detail = pickerEquipment.pickerSelection[2] + " " +  "Finder";
            newRow.catagory = pickerEquipment.pickerState[1] // added for sort
            let currentEvent = getLastEvent()
      sortRealmEvent()
            try! realm.write {
                currentEvent.tableViewArray.append(newRow)
            }
            myTableView.reloadData()
        }
        
        // segue to aks[5] filters[7] support[8]
        if pickerEquipment.pickerState[1] == 5 || pickerEquipment.pickerState[1] > 6 {
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState) // populate the next controller?
            tableViewArrays.setPrimesKit(compState: pickerEquipment.pickerState)
            let myVc = storyboard?.instantiateViewController(withIdentifier: "aksViewController") as! AksKitViewController
            //myVc.thePrimes = tableViewArrays.thePrimes
            //myVc.displayLensArray = tableViewArrays.displayLensArray
            myVc.pickerEquipment = pickerEquipment  // push picker login to next vc
            navigationController?.pushViewController(myVc, animated: true)
        }
    }
    
    //MARK: - Share Camera Order
    @IBAction func shareAction(_ sender: Any) {
        
        let thisEvent = getLastEvent()
    
        //sortRealmEvent()

        var messageArray = [String]()
        
        for rows in thisEvent.tableViewArray {

            let mixedCase = rows.title.uppercased()
            messageArray.append(mixedCase)
            messageArray.append("\n")
            messageArray.append(rows.detail)
            messageArray.append("\n\n")
        }
        messageArray.append("\nWeather forecast for \(thisEvent.city)\n\(thisEvent.weather)")
        messageArray.append("  ")
        print(messageArray)
        // write over user to add company
        messageArray[0] = "\(thisEvent.userName.uppercased()) Director of Photography\n"
        messageArray[1] = "Camera Order “\(thisEvent.production)” \(thisEvent.date) \(thisEvent.company)\n"
        messageArray[2] = ""
        
        let message = messageArray.joined(separator: "")
        let subject = messageArray[1] // this is for email subject line
        print("\nsubject: \(subject)")
        print("\nmessage: \(message)")
        
        // share section
        // set up activity view controller
        let textToShare = [ message ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
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
        //return tableViewArrays.tableViewArray.count
        return tableviewEvent.tableViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // consider refactoring the way I get a tableview icon... from previous core data approach
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        let iconString = tableviewEvent.tableViewArray[indexPath.row].icon
        
        cell.imageTableViewCell.image = tableViewArrays.setTableViewIcon(title: iconString)
        
        cell.titleTableView?.text = tableviewEvent.tableViewArray[indexPath.row].title

        cell.detailTableView?.text = tableviewEvent.tableViewArray[indexPath.row].detail
        
        return cell
    }
    
    //Mark: - delete tableview row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentEvent = getLastEvent()
            
            try! currentEvent.realm!.write {
                let row = currentEvent.tableViewArray[indexPath.row]
                row.realm!.delete(row)
            }
            
            tableviewEvent = currentEvent   // re - populate tableview
            tableView.reloadData()
        }
    }



    
    //MARK: - Segue to User VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "mainToUser", sender: self)
        }
    }
    

    //Mark: - populate the tableview
    func populateTableviewFromEvent(currentEvent: EventUserRealm ) {
        
        tableViewArrays.removeAll();
            for eachRow in currentEvent.tableViewArray {                
                tableViewArrays.appendTableViewArray(title: eachRow.title, detail: eachRow.detail, compState: pickerEquipment.pickerState)
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
        var newID = false
        let id: EventTracking
        if let existingID = realm.objects(EventTracking.self).first {
            id = existingID
        } else {
            newID = true
            id = EventTracking()
        }

        try! realm.write {
            if newID {
                realm.add(id)
            }
            id.lastID = ID
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

