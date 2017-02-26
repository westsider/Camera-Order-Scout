//
//  AksKitViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/25/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//
//  DONE: load all arrays into realm on first load in main vc with switch pos
//  DONE: create realm objects for all fuckers aks, support filters
//  DONE: first run in main populate these objects
//  DONE: find if aks or support has been loaded
//  DONE: Create new vc
//  DONE: load vc todoList with  aks || filters
//  DONE: populate tableview
//  DONE: edit tableview

//  persist switches
//  prove add to main


import UIKit
import RealmSwift

class AksKitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleDescription: UILabel!
    
    var pickerEquipment = Equipment()
    
    let cellIdentifier = "aksTableViewCell"
    
    var pickerRow = 5
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pickerRow = pickerEquipment.pickerState[1]
        setUpUI()
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
            
            self.updateRealm(state: self.pickerRow, item: textInput)
            
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
        
        // Send switch state and indexpath ro to this func?
//        cell.aksSwitch.tag = indexPath.row
//        cell.aksSwitch.restorationIdentifier = displayLensArray[indexPath.row]
//        cell.aksSwitch.addTarget(self, action: #selector(switchTriggered(sender:)), for: UIControlEvents.valueChanged)
        cell.aksLabel.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    // modify realm object called by picker state
    func getAksLabelText(state: Int, row: Int) -> (detail: String, count: Int) {
        var labelString = ""
        var size = 1
        
        if state == 5 { // if aks
            let realm = try! Realm()
            
            var todoList: Results<AksItem> {
                get {
                    return realm.objects(AksItem.self)
                }
            }
            
            size = todoList.count
            labelString =  todoList[row].detail
        }
        
        if state == 7 { // if FilterItem
            let realm = try! Realm()
            
            var todoList: Results<FilterItem> {
                get {
                    return realm.objects(FilterItem.self)
                }
            }
            
            size = todoList.count
            labelString =  todoList[row].detail
        }
        
        if state == 8 { // if SupportItem
            let realm = try! Realm()
            
            var todoList: Results<SupportItem> {
                get {
                    return realm.objects(SupportItem.self)
                }
            }
            
            size = todoList.count
            labelString =  todoList[row].detail
        }
       
        return (labelString, size)
    }
 
    // modify realm object called by picker state
    func updateRealm(state: Int, item: String)  {
        
        let realm = try! Realm()
        
        if state == 5 { // if aks
            let todoItem = AksItem()
            todoItem.detail = item
            todoItem.status = 0
            
            try! realm.write({
                realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: self.getAksLabelText(state: self.pickerRow, row: 0).count-1, section: 0)], with: .automatic)
            })
        }
        
        if state == 7 { // if FilterItem
            let todoItem = FilterItem()
            todoItem.detail = item
            todoItem.status = 0
            
            try! realm.write({
                realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: self.getAksLabelText(state: self.pickerRow, row: 0).count-1, section: 0)], with: .automatic)
            })
        }
        
        if state == 8 { // if SupportItem
            let todoItem = SupportItem()
            todoItem.detail = item
            todoItem.status = 0
            
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
            titleDescription.text = "Switch 0n filters needed"
        }
        // 8 support
        if pickerEquipment.pickerState[1] == 8 {
            print("sent form Support")
            title = "Select Support"
            titleDescription.text = "Switch on support items needed"
        }
    }
}
