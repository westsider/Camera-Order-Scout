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

    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |             The Big difference in this iteration is the tableview equipment           |
     |             is now stored in the event class and will avoid confusion when            | 
     |             updating the table view lenses                                            |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
/*  
 realm objects
 Class =  Event
 attributes =
 var eventName: String = "Default"
 var user: User
 var tableViewArray = [[Any]]()
 var images = [UIImage]()
 
 Class = User
 Attributes =
 var name: String
 var production: String
 var company: String
 var city: String
 var date: String
 var weather: String
 var icon: UIImage
 */

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
//  task: realm persistence of event                    fri 2/11
//  task: first run Tutorial                            sat 2/11
//  http://stackoverflow.com/questions/13335540/how-to-make-first-launch-iphone-app-tour-guide-with-xcode
//  task: turn print into share                         sat 2/11
//  task: finish all extra equipment                    sun 2/12

// fix back to say back
// tableview array object -- should replace with  thisEvent.tableViewArray, copy updateUser and updateTableView

import Foundation
import UIKit
import RealmSwift

var thisEvent: Event! // has user instanciate one here next, user crash on way back to main vc, past orders crashed on update

var defaultUser: User!        // fuck default user - its in the event?

var pickerEquipment = Equipment()       // picker equipment object

var tableViewArrays = TableViewArrays()   // tableview array object -- should replace wit  thisEvent.tableViewArray

class MainTableViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myPicker: UIPickerView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var defaultUser = User(name: "Warren Hansen", production: "Nike", company: "CO3", city: "Santa Monica, CA", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
    var image = [UIImage]()

    let cellIdentifier = "ListTableViewCell"
    
    let isFirstLaunch = UserDefaults.isFirstLaunch()
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                                  Realm Storage                                        |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    
    let realm = try! Realm()            // Get the default Realm
    let user = UserRealm()              // Use them like regular Swift objects

    //MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "C A M E R A  O R D E R"
        self.myPicker.dataSource = self
        self.myPicker.delegate = self
        
        // populate event on 1st load only
        if thisEvent == nil {
            thisEvent = Event(eventName: "an event", user: defaultUser, tableViewArray: [["1","cam","arri","alexa"]], images: image)
        } else {
            // update user?
            // update table view user
            tableViewArrays.updateUser(title: "\(thisEvent.user.name) Director of Photography", detail: "Camera Order \(thisEvent.user.production) \(thisEvent.user.date)")
        }
        
        // populate pickerSelection on first load
        pickerEquipment.pickerSelection[0] = pickerEquipment.pickerArray[0][pickerEquipment.pickerState[0]]
        pickerEquipment.pickerSelection[1] = pickerEquipment.pickerArray[1][pickerEquipment.pickerState[1]]
        pickerEquipment.pickerSelection[2] = pickerEquipment.pickerArray[2][pickerEquipment.pickerState[2]]
        pickerEquipment.pickerSelection[3] = pickerEquipment.pickerArray[3][pickerEquipment.pickerState[3]]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // get user from realm
        let savedUser = realm.objects(UserRealm.self)
        // set up default user
        if savedUser.count == 0 {
            // Persist your data easily
            try! realm.write {
                realm.add(user)
                print("add user")
            }
        }
            var userRealm = ""
            var productionRealm  = ""
            //var companyRealm  = ""
            var dateRealm  = ""
            //var iconRealm = NSData(data: UIImagePNGRepresentation(#imageLiteral(resourceName: "manIcon"))!)
            for items in savedUser {
                userRealm        = items.name
                productionRealm  = items.production
                //companyRealm     = items.company
                dateRealm        = items.date
                // iconRealm       = items.icon!
            }
        
        
        // add defalt user if tableview array is empty - first load
        if tableViewArrays.tableViewArray.isEmpty {
           tableViewArrays.appendTableViewArray(title: "\(userRealm) Director of Photography", detail: "Camera Order \(productionRealm) \(dateRealm)", icon: thisEvent.user.icon, compState: [0,0,0,0])
        } else {
            // if we come back from user update the taleview user
            print("\nview will appera Else")
            tableViewArrays.tableViewArray = thisEvent.tableViewArray // should do away with tableViewArrays.tableViewArray
            tableViewArrays.updateUser(title: "\(thisEvent.user.name) Director of Photography", detail: "Camera Order \(thisEvent.user.production) \(thisEvent.user.date)")
            //update main user
            print("\nView will appear Main View >>>>>>>>>>>>>>>>>>>>>>>>>>>")
            print("thisEvent.eventName: \(thisEvent.eventName)")
            print("thisEvent.user, prod, company, city: \(thisEvent.user.name)  \(thisEvent.user.production)  \(thisEvent.user.company)  \(thisEvent.user.city)")
            print("thisEvent.tableviewarray: \(thisEvent.tableViewArray)")
            print("thisEvent.image: \(thisEvent.images)")
            
        }
       
        myTableView.reloadData() // reload when returning to this VC
        
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                             add equipment to tableview                                |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    //MARK: - Add Action
    @IBAction func addAction(_ sender: Any) {
        
        // append the equipment to the tableview
        tableViewArrays.appendTableViewArray(title: pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1], detail: pickerEquipment.pickerSelection[2] + " " + pickerEquipment.pickerSelection[3], icon: UIImage(named: "manIcon")!, compState: pickerEquipment.pickerState)
        
        // update thisUser
        thisEvent.tableViewArray = tableViewArrays.tableViewArray
        
        myTableView.reloadData()
        
        // if a lens segue to lenses
        if pickerEquipment.pickerState[1] == 1 {
            performSegue(withIdentifier: "mainToLenses", sender: self)
        }
        
        // if a aks segue to lenses/aks
        if pickerEquipment.pickerState[1] >= 5{
            performSegue(withIdentifier: "mainToLenses", sender: self)
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
        
        //TODO: - set pickerSelected property with picker array current selection *** I wish this was a function
        pickerEquipment.pickerState = [ myPicker.selectedRow(inComponent: 0), myPicker.selectedRow(inComponent: 1), myPicker.selectedRow(inComponent: 2), myPicker.selectedRow(inComponent: 3) ]
        
        //TODO: - update pickerSelection make this a function
        pickerEquipment.pickerSelection[0] = pickerEquipment.pickerArray[0][pickerEquipment.pickerState[0]]
        pickerEquipment.pickerSelection[1] = pickerEquipment.pickerArray[1][pickerEquipment.pickerState[1]]
        pickerEquipment.pickerSelection[2] = pickerEquipment.pickerArray[2][pickerEquipment.pickerState[2]]
        pickerEquipment.pickerSelection[3] = pickerEquipment.pickerArray[3][pickerEquipment.pickerState[3]]
        
        print("pickerEquipment.pickerSelection[3]: \(pickerEquipment.pickerSelection[3])")
    }
    
    //  make picker text fill horizontal space allowed
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
    
    // MARK: - Segue to User VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //  print("Row: \(indexPath.row) segue to User")
            
            performSegue(withIdentifier: "mainToUser", sender: self)
        }
    }

}

