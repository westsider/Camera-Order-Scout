//
//  PastOrdersViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 12/13/16.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

// task: make sure this event's name is being updated in pastOrders
// task: make sure thisEvent is being update to the selected event in pastOrders
// yet it is but not showing in main tableview...
// task: return a previous order to main vc
// // task: when clicking on element 0... funki
// save replaces all new events
//  task: finishjed past orders logic

import UIKit

var allEvents = [Event]()   // global ubntil I design persistance in Core Data

class PastOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var tableViewTitleArray = [String]()
    
    var equipment = [String]()
    
    var image = UIImage()
    
    let imagey = [UIImage]() // fake until persisteance
    
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
        let tableviewArraysFAKE = [["Warren Hansen Director of Photography", "Camera Order Nike 12 / 20 / 2016", image], ["1 Camera", "Arri Alexa", image], ["1 Primes", "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss ZMP", image]]
        let tableviewArraysFAKE01 = [["Tom Lazarevich Director of Photography", "Camera Order Nike 12 / 20 / 2016", image], ["1 Camera", "Arri Alexa", image], ["1 Primes", "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss ZMP", image]]
        let tableviewArraysFAKE02 = [["Dean Hawking Director of Photography", "Camera Order Nike 12 / 20 / 2016", image], ["1 Camera", "Arri Alexa", image], ["1 Primes", "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss ZMP", image]]
        
        //  only load this until allEvents are persistant then delete
        let pastUser00 = User(name: "Warren Hansen", production: "Nike", company: "CO3", city: "Santa Monica, CA", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
        let pastUser01 = User(name: "Tom Lazarevich", production: "Taco Bell", company: "Wood Shop", city: "Culver City, CA", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
        let pastUser02 = User(name: "Roger Deakins", production: "No Contry", company: "The Brothers", city: "Venice, CA", date: "12 / 20 / 2016", weather: "Sunny 72", icon: UIImage(named: "manIcon")!)
        
        let pastEvent00 = Event(eventName: "daylight order fake", user: pastUser00, tableViewArray: tableviewArraysFAKE, images: imagey)
        let pastEvent01 = Event(eventName: "tungsten order fake", user: pastUser01, tableViewArray: tableviewArraysFAKE01, images: imagey)
        let pastEvent02 = Event(eventName: "studio order fake", user: pastUser02, tableViewArray: tableviewArraysFAKE02, images: imagey)
    
        
        //  populate fake past orders till persistance
        if allEvents.count == 0 {
            print("\nFirst Load of allEvents")
            allEvents.append(pastEvent00)
            allEvents.append(pastEvent01)
            allEvents.append(pastEvent02)
        }
        
        
        reloadTableViewNames()
        
    }
    
    func reloadTableViewNames() {
        tableViewTitleArray.removeAll()
        // load table view name array
        for events in allEvents {
            let name =  events.eventName
            print("\nreloadTableViewNames() \(name)")
            print("\nevents\(events)")
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
        
        print("\nBefore Save allEvents.count\(allEvents.count)")
        
        // make sure textInput contains a new name
 //       if eventNameInput.text != "" {
            
//            if let textInput = eventNameInput.text {
                
                // classes are passes by reference - must create new instance or I get repeated event names
//                let newEvent = Event(eventName: textInput, user: thisEvent.user, tableViewArray: thisEvent.tableViewArray, images: imagey)
                
                //newEvent.eventName = textInput
//                print("\nGive thisEvent a name: \(newEvent.eventName)")
//                
//                allEvents.append(newEvent)
//                for event in allEvents {
//                    print("Name: \(event.eventName)")
//                }
//                
//                print("\nAfter aopending allEvents count is \(allEvents.count)")
//                print("\nNow append tableViewTitleArray with \(newEvent.eventName)")
//                tableViewTitleArray.append(newEvent.eventName)
//            }
//        } else {
//            print("No text input")
//            eventNameInput.text = "Please enter a name for this order"
//        }
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
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |              Tap on Table View ro returns the Event to main tableview                 |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let theRow = indexPath.row
        
//            // update main event
//            thisEvent = allEvents[theRow]
//            
//            // update main tableview array
//            thisEvent.tableViewArray = allEvents[theRow].tableViewArray
//            //thisEvent.user = allEvents[theRow].user
        

        _ = navigationController?.popToRootViewController(animated: true)
        
    }
}
