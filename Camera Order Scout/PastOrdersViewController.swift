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

var globalCurrentEvent = "Default"

class PastOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBOutlet weak var eventNameInput: UITextField!
    
    //let realm = try! Realm()
    
    //var eventToWorkOn = EventRealm()
    
    var tableViewTitleArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "S A V E / L O A D"
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        print("\n*** Entering PastOrdersViewController *** vDL loads first")
        reloadTableViewNames()

    }

    //MARK: - Lifecycle Events
    override func viewWillAppear(_ animated: Bool) {
        print("vWA laods second")

    }
    
    func reloadTableViewNames() {

//        let savedEvent = realm.objects(EventRealm.self)
//        tableViewTitleArray.removeAll()
//
//        for index in savedEvent {
//            print("\nIn the loop reload tableviews\(index.eventName)")
//            tableViewTitleArray.append(index.eventName)
//        }
//        eventsTableView.reloadData()
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                                    Save New Event                                     |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    
    // problem is ther is only 1 user ever and i should creat a new user and save it to the event... 
    //****          or just update the event with this user info what I update user
    //MARK: - Save Event
    @IBAction func saveEvent(_ sender: Any) {

        print("\nEntering Save Event")
        // make sure textInput contains a new name
        if eventNameInput.text != "" {
            
            if let textInput = eventNameInput.text {
                print(textInput)
//                let savedEvent = realm.objects(EventRealm.self)
//                print("\n loaded savedEvent : \(savedEvent)")
//                let savedUsers = realm.objects(UserRealm.self)
//                
//               print("\n*** attempting to copy and event - saved event count: \(savedEvent.count) and user count is:\(savedUsers.count)")
//                
//                for index in savedEvent {
//                    print("In the loop yo")
//                    // use the loop to find default and copy it to new event
//                    if index.eventName == globalCurrentEvent {
//                        try! realm.write() {
//                            realm.create(EventRealm.self, value: ["eventName": textInput,"userInfo": index.userInfo!, "tableViewArray": index.tableViewArray!])
//                        }
//                    }
//                }
//                 globalCurrentEvent = textInput
//                
//                print("\n added to savedEvent : \(savedEvent)")
            }
        } else {
            print("No text input")
            eventNameInput.text = "Please enter a name for this order"
        }
         reloadTableViewNames()
//        let newObjects =  realm.objects(EventRealm.self)
//        print("\n*** leaving copy  event -  count: \(newObjects.count)")
    }

    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                                  Set up Table View                                    |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    //MARK:- Set up Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableViewTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = tableViewTitleArray[indexPath.row]
        
        return cell
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |              Tap on Table View ro returns the Event to main tableview                 |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\nJust tapped tableview row to Load new enebt")
//       let theRow = indexPath.row
//        print("find the tabkeview row\(theRow)")
//        
//        //
//        print("\n globalCurrentEvent event is: \(globalCurrentEvent)")
//        
//        print("\n selected event is: \(tableViewTitleArray[theRow])")
//        
//        print("\nnow replace the \(globalCurrentEvent) with selected event: \(tableViewTitleArray[theRow])")
//        
//        // reaplace the global event with this event and return to main vc
//        globalCurrentEvent = tableViewTitleArray[theRow]
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
}
