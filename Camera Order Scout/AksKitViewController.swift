//
//  AksKitViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/25/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//


import UIKit
import RealmSwift

class AksKitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleDescription: UILabel!
    
    var pickerEquipment = Equipment()
    
    let cellIdentifier = "aksTableViewCell"
    
    var pickerRow = 5
    
    var returnedString = ""
    
    let realm = try! Realm()
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pickerRow = pickerEquipment.pickerState[1]
        setUpUI()
    }
    
    //MARK: - Update main tableview
    @IBAction func updateAction(_ sender: Any) {
        
        finalizeKitArray()
        
        //  create tableview row realm objects and differentiate lenses from aks
        let newRow = TableViewRow()
        newRow.icon = pickerEquipment.pickerSelection[1]
        //     populate AKS ect
        newRow.title = pickerEquipment.pickerSelection[0] + " " + pickerEquipment.pickerSelection[1]
        newRow.detail = returnedString
        newRow.catagory = pickerEquipment.pickerState[1] // added for sort
        
        // get realm event and append tableview row objects
        let id = getLastIdUsed()
        
        let currentEvent = realm.objects(EventUserRealm.self).filter("taskID == %@", id).first!
        
        try! realm.write {
            currentEvent.tableViewArray.append(newRow)
        }
        
        sortRealmEvent()
        
        //print("\nhere is what will be returned to realm as the kit:\n\(returnedString)\n")
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func finalizeKitArray() {   // in segue back to main VC
        
        if pickerRow == 5 {  // if aks
            
            var todoList: Results<AksItem> {
                get {
                    return realm.objects(AksItem.self)
                }
            }
            for items in todoList {
                
                if items.status == true {
                 returnedString += items.detail + ", "
                }
            }
            //print("\nhere is the whole list: \(todoList)")
        }
        
        if pickerRow == 7 {  // if FilterItem
            
            var todoList: Results<FilterItem> {
                get {
                    return realm.objects(FilterItem.self)
                }
            }
            for items in todoList {
                if items.status == true {
                    returnedString += items.detail + ", "
                }
            }
            
        }
        
        if pickerRow == 8 {  // if SupportItem
            
            var todoList: Results<SupportItem> {
                get {
                    return realm.objects(SupportItem.self)
                }
            }
            for items in todoList {
                if items.status == true {
                    returnedString += items.detail + ", "
                }
            }
        }
        // remove last comma
        let endIndex = returnedString.index(returnedString.endIndex, offsetBy: -2)
        let truncated = returnedString.substring(to: endIndex)
        returnedString = truncated
    }

    //MARK: - Add new items to kit
    @IBAction func addNewItemsAction(_ sender: Any) {
        
        let alertController : UIAlertController = UIAlertController(title: "New Todo", message: "What do you plan to do?", preferredStyle: .alert)
        
        alertController.addTextField { (UITextField) in
            
        }
        
        let action_cancel = UIAlertAction.init(title: "Cancel", style: .cancel) { (UIAlertAction) -> Void in
            
        }
        alertController.addAction(action_cancel)
        
        let action_add = UIAlertAction.init(title: "Add", style: .default) { (UIAlertAction) -> Void in
            let textField_todo = (alertController.textFields?.first)! as UITextField
            print("You entered \(textField_todo.text)")
            
            var textInput = ""
            if  textField_todo.text! != "" {
                textInput = textField_todo.text!
            }
            
        self.updateRealm(state: self.pickerRow, item: textInput, onOff: true)
            
        }
        alertController.addAction(action_add)
        
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Set up tableview  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAksLabelText(state: pickerRow, row: 0).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AKSTableViewCell
        
        cell.aksLabel?.text = getAksLabelText(state: pickerRow, row: indexPath.row).detail
        
        cell.aksSwitch.isOn = getAksLabelText(state: pickerRow, row: indexPath.row).onOff
        
        // Send switch state and indexpath ro to this func?
        cell.aksSwitch.tag = indexPath.row
        cell.aksSwitch.restorationIdentifier = getAksLabelText(state: pickerRow, row: indexPath.row).detail
        cell.aksSwitch.addTarget(self, action: #selector(switchTriggered(sender:)), for: UIControlEvents.valueChanged)
        cell.aksLabel.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    /// logic to modify swich positions in realm
    func switchTriggered(sender: UISwitch) {
        
        let index = sender.tag
        let content = sender.restorationIdentifier!
        print("Lens Switch Index: \(index) For: \(content) Is On: \(sender.isOn)")
        
        //let realm = try! Realm()
        
        if pickerRow == 5 {  // if aks
            
            var todoList: Results<AksItem> {
                get {
                    return realm.objects(AksItem.self)
                }
            }
            
            try! realm.write {
                todoList[index].status = sender.isOn
            }
        }
        
        if pickerRow == 7 {  // if FilterItem
            
            var todoList: Results<FilterItem> {
                get {
                    return realm.objects(FilterItem.self)
                }
            }
            
            try! realm.write {
                todoList[index].status = sender.isOn
            }
        }
        
        if pickerRow == 8 {  // if SupportItem
            
            var todoList: Results<SupportItem> {
                get {
                    return realm.objects(SupportItem.self)
                }
            }
            
            try! realm.write {
                todoList[index].status = sender.isOn
            }
        }
    }
    
    // modify realm object called by picker state
    func getAksLabelText(state: Int, row: Int) -> (detail: String, onOff: Bool, count: Int) {
        var labelString = ""
        var size = 1
        var isSwitchOn = false
        
        if state == 5 { // if aks
            //let realm = try! Realm()
            
            var todoList: Results<AksItem> {
                get {
                    return realm.objects(AksItem.self)
                }
            }
            
            size = todoList.count
            labelString =  todoList[row].detail
            isSwitchOn = todoList[row].status
        }
        
        if state == 7 { // if FilterItem
            //let realm = try! Realm()
            
            var todoList: Results<FilterItem> {
                get {
                    return realm.objects(FilterItem.self)
                }
            }
            
            size = todoList.count
            labelString =  todoList[row].detail
            isSwitchOn = todoList[row].status
        }
        
        if state == 8 { // if SupportItem
            //let realm = try! Realm()
            
            var todoList: Results<SupportItem> {
                get {
                    return realm.objects(SupportItem.self)
                }
            }
            
            size = todoList.count
            labelString =  todoList[row].detail
            isSwitchOn = todoList[row].status
        }
       
        return (labelString, isSwitchOn, size)
    }
 
    // modify realm object called by picker state
    func updateRealm(state: Int, item: String, onOff: Bool)  {
        
       // let realm = try! Realm()
        
        if state == 5 { // if aks
            let todoItem = AksItem()
            todoItem.detail = item
            todoItem.status = onOff
            
            try! realm.write({
                realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: self.getAksLabelText(state: self.pickerRow, row: 0).count-1, section: 0)], with: .automatic)
            })
        }
        
        if state == 7 { // if FilterItem
            let todoItem = FilterItem()
            todoItem.detail = item
            todoItem.status = onOff
            
            try! realm.write({
                realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: self.getAksLabelText(state: self.pickerRow, row: 0).count-1, section: 0)], with: .automatic)
            })
        }
        
        if state == 8 { // if SupportItem
            let todoItem = SupportItem()
            todoItem.detail = item
            todoItem.status = onOff
            
            try! realm.write({
                realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: self.getAksLabelText(state: self.pickerRow, row: 0).count-1, section: 0)], with: .automatic)
            })
        }
    }
    
    // modify view info by picker state
    func setUpUI() {
        // 5 aks
        if pickerEquipment.pickerState[1] == 5 {
            print("sent form AKS")
            title = "Select AKS"
            titleDescription.text = "Switch on AKS items needed"
        }
        // 7 filters
        if pickerEquipment.pickerState[1] == 7 {
            print("sent form Filters")
            title = "Select Filters"
            titleDescription.text = "Switch on filters needed"
        }
        // 8 support
        if pickerEquipment.pickerState[1] == 8 {
            print("sent form Support")
            title = "Select Support"
            titleDescription.text = "Switch on support items needed"
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
