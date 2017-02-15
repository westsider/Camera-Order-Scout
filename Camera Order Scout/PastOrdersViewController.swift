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

//  task: delete row in tableview to prove this
//  click on row and replace defaultUser with selection

import UIKit
import RealmSwift

class PastOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var tableViewTitleArray = [String]()
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBOutlet weak var eventNameInput: UITextField!
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "S A V E / L O A D"
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        print("vDL loads first")
        reloadTableViewNames()

    }

    //MARK: - Lifecycle Events
    override func viewWillAppear(_ animated: Bool) {
        print("vWA laods second")

    }
    
    func reloadTableViewNames() {

        let savedEvent = realm.objects(EventRealm.self)
        tableViewTitleArray.removeAll()

        for index in savedEvent {
            print("In the loop yo\(index.eventName)")
            tableViewTitleArray.append(index.eventName)
        }
        eventsTableView.reloadData()
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
                print(textInput)
                let savedEvent = realm.objects(EventRealm.self)
                print("\n loaded savedEvent : \(savedEvent)")
                
                for index in savedEvent {
                    print("In the loop yo")
                    // use the loop to find default and copy it to new event
                    if index.eventName == "Default" {
                        try! realm.write() {
                            realm.create(EventRealm.self, value: ["eventName": textInput,"userInfo": index.userInfo!, "tableViewArray": index.tableViewArray!])
                        }
                    }
                }
                print("\n added to savedEvent : \(savedEvent)")
            }
        } else {
            print("No text input")
            eventNameInput.text = "Please enter a name for this order"
        }
         reloadTableViewNames()
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
        
       let theRow = indexPath.row
        print("find the tabkeview row\(theRow)")
        
        let savedEvent = realm.objects(EventRealm.self)
        print("\nSelected Event Only")
        print("\n loaded savedEvent : \(savedEvent[theRow])")
        
        for index in savedEvent {
            //print("In the loop yo")
            // use the loop to find default and copy it to new event
            //print("\n loaded savedEvent : \(savedEvent)")
            
           
        }
        //_ = navigationController?.popToRootViewController(animated: true)
        
    }
}
