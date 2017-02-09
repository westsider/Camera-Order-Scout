//
//  PastOrdersViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 12/13/16.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

// task: return a previous order to main vc

import UIKit

var allEvents = [Event]()   // global ubntil I design persistance in Core Data

class PastOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var newEvent: Event!
    
    var tableViewTitleArray = [String]()
    
    var equipment = [String]()
    
    var image = UIImage()
    
    var tableviewArraysFAKE = [[Any]]() 
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBOutlet weak var eventNameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "S A V E / L O A D"
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
    }

    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                             Lifecycle Events                                          |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    //MARK: - Lifecycle Events
    override func viewWillAppear(_ animated: Bool) {

        // create past events until I persist
        let imagey = [UIImage]()
        tableviewArraysFAKE = [["Warren Hansen Director of Photography", "Camera Order Nike 12 / 20 / 2016", image], ["1 Camera", "Arri Alexa", image], ["1 Primes", "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss ZMP", image]]

        newEvent = thisEvent
        
        //  only load this until allEvents are persistant then delete
        let pastUser00 = User(name: "Warren Hansen", production: "Nike", company: "CO3", city: "Santa Monica, CA", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
        let pastUser01 = User(name: "Tom Lazarevich Hansen", production: "Taco Bell", company: "Wood Shop", city: "Culver City, CA", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
        let pastUser02 = User(name: "Roger Deakins", production: "No COntry", company: "The Brothers", city: "Venice, CA", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
        
        let pastEvent00 = Event(eventName: "daylight order fake", user: pastUser00, tableViewArray: tableviewArraysFAKE, images: imagey)
        let pastEvent01 = Event(eventName: "tungsten order fake", user: pastUser01, tableViewArray: tableviewArraysFAKE, images: imagey)
        let pastEvent02 = Event(eventName: "studio order fake", user: pastUser02, tableViewArray: tableviewArraysFAKE, images: imagey)
        
        
        if allEvents.count == 0 {
            allEvents.append(pastEvent00)
            allEvents.append(pastEvent01)
            allEvents.append(pastEvent02)
        }
        
        // load table view name array
        for events in allEvents {
            let name =  events.eventName
            tableViewTitleArray.append(name)
        }
        
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                                       Save Event                                      |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    //MARK: - Save Event
    @IBAction func saveEvent(_ sender: Any) {
        
        // make sure textInput contains a new name
        if eventNameInput.text != "" {
            
            if let textInput = eventNameInput.text {
                print("here is textInput: \(textInput)")
                newEvent.eventName = textInput // getting an error her - have not inititated user yed, doing that now
                tableViewTitleArray.insert(newEvent.eventName, at: 0)
                allEvents.insert(newEvent, at: 0)
            }
        } else {
            print("No text input")
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
        
        return tableViewTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = tableViewTitleArray[indexPath.row]
        
        return cell
    }

}
