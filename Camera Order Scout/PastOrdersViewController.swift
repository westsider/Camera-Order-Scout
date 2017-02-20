//
//  PastOrdersViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 12/13/16.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//
//  save a new user
//  task: saved events - populate the tableview array with event names
//  task: click on a row and prove the event cpontents
//  fix: trouble with 2 events loading in main VC... if returning only load the saved array on add or  clicked array
//  task: delete row in tableview to prove this

//  click on row and replace defaultUser with selection

import UIKit
import RealmSwift

class PastOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBOutlet weak var eventNameInput: UITextField!
    
    let realm = try! Realm()
    
    var tasks: Results<EventUserRealm>! // for tableview
    
    var tableViewTitleArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "S A V E / L O A D"
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        print("\n*** Entering PastOrdersViewController *** vDL loads first")
        tasks = realm.objects(EventUserRealm.self)  // for tableview
        
        
    }

    //MARK: - Lifecycle Events
    override func viewWillAppear(_ animated: Bool) {
        print("vWA laods second")

    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                                    Save New Event                                     |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    
    //MARK: - Save Event
    @IBAction func saveEvent(_ sender: Any) {

        print("\nEntering Save Event")
        // make sure textInput contains a new name
        if eventNameInput.text != "" {
            
            if let textInput = eventNameInput.text {
                print(textInput)
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
                // save last used event id
                saveLastID(ID: newEvntUser.taskID)
            }
        } else {
            print("No text input")
            eventNameInput.text = "Please enter a name for this order"
        }
        let allEvents = realm.objects(EventUserRealm.self)
        
        print("New EventUser added:\n\(allEvents)")
        
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
        //return tableViewTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        //cell.textLabel?.text = tableViewTitleArray[indexPath.row]
        
        let task =  "\(tasks[indexPath.row].eventName) for \(tasks[indexPath.row].userName)"
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text =  task //testTableViewArray[indexPath.row]
        
        return cell
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |              Tap on Table View ro returns the Event to main tableview                 |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\nJust tapped tableview row to Load new enebt")
       let theRow = indexPath.row
//print("\nthe row is \(theRow)\nthe task id is \(tasks[theRow].taskID)")
        
        // save event id as lastId - last event, which is the current eventloaded in the main vc becomes the selected event and can be loaded into the main vs
        let id = EventTracking()
        try! realm.write {
            id.lastID = tasks[theRow].taskID
            realm.add(id)
        }
        _ = navigationController?.popToRootViewController(animated: true)
        
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
