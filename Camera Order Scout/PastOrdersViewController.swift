//
//  PastOrdersViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 12/13/16.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import RealmSwift

class PastOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBOutlet weak var eventNameInput: UITextField!
    
    let realm = try! Realm()
    
    var tasks: Results<EventUserRealm>! // for tableview
    
    var tableViewTitleArray = [String]()

    //MARK: - Lifecycle Events
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "S A V E / L O A D"
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        tasks = realm.objects(EventUserRealm.self)  // for tableview
        // just for testing
        eventNameInput.text = "second event"
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                                    Save New Event                                     |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    
    //MARK: - Save Event
    @IBAction func saveEvent(_ sender: Any) {

        // make sure textInput contains a new name
        if eventNameInput.text != "" {
            
            if let textInput = eventNameInput.text {
                let newEvntUser = EventUserRealm()
                let id = getLastIdUsed()
                
                // get the current event to poplate new event tableview
                let currentEvent = realm.objects(EventUserRealm.self).filter("taskID == %@", id).first!
                
                // populate tableview equipment from current order
                for oldRow in currentEvent.tableViewArray {
                    let newRow = TableViewRow()
                    newRow.detail = oldRow.detail
                    newRow.title = oldRow.title
                    newRow.icon = oldRow.icon
                    newEvntUser.tableViewArray.append(newRow)
                }
                // update all details
                newEvntUser.eventName = textInput
                newEvntUser.userName = currentEvent.userName
                newEvntUser.production = currentEvent.production
                newEvntUser.company = currentEvent.company
                newEvntUser.city = currentEvent.city
                newEvntUser.date = currentEvent.date
        
                try! realm.write {
                    realm.add(newEvntUser)
                }
                saveLastID(ID: newEvntUser.taskID)
            }
        } else {
            eventNameInput.text = "Please enter a name for this order"
        }
        
        eventsTableView.reloadData()
    }

    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                                  Set up Table View                                    |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    //MARK:- Set up Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task =  "\(tasks[indexPath.row].eventName) for \(tasks[indexPath.row].userName)"
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text =  task //testTableViewArray[indexPath.row]
        
        return cell
    }
    
    //Mark: - delete tableview row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            try! tasks.realm!.write {
                let task = self.tasks[indexPath.row]
                self.tasks.realm!.delete(task)
            }
        }
        let allEvents = realm.objects(EventUserRealm.self)
        // get last id in events to save new last id
        let numItems = allEvents.count
        var index = numItems - 1
        if index < 0 {  index = 0   } // catch -1 index if events edited to 1 event
        let thisID = tasks[index].taskID
        saveLastID(ID: thisID)
        eventsTableView.reloadData()
        
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |              Tap on Table View ro returns the Event to main tableview                 |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let theRow = indexPath.row
        let id = EventTracking()
        
        try! realm.write {
            id.lastID = tasks[theRow].taskID
            realm.add(id)
        }
        saveLastID(ID: id.lastID)
        
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    //Mark: - save sast id and get last id done differenltly than class onject
    func saveLastID(ID: String) {
        let id = EventTracking()
        try! realm.write {
            id.lastID = ID
            realm.add(id)
        }
    }
    
    func getLastIdUsed() -> String {

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
}
