//
//  UserViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/6/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import RealmSwift

class UserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var production: UITextField!
    
    @IBOutlet weak var company: UITextField!
    
    @IBOutlet weak var citySearch: UITextField!
    
    @IBOutlet weak var activityDial: UIActivityIndicatorView!
    
    @IBOutlet weak var weatherDisplay: UITextView!
    
    @IBOutlet weak var dateTextField: UILabel!
    
    @IBOutlet weak var dateTextInput: UITextField!
    
    @IBOutlet weak var userData: UITextView!
    
    let errorOne = "Please include a state or country"
    
    let errorTwo = "Please Enter a City and State or Country"
    
    var datePickerUtility = DatePickerUtility()
    
    let realm = try! Realm()            // Get the default Realm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userName.delegate = self
        self.production.delegate = self
        self.company.delegate = self
        self.dateTextInput.delegate = self
        title = "J O B  I N F O"
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //get last id used
        let id = getLastIdUsed()
        
        var message = "Saved id is\n\(id)\n"
        
        let currentEvent = realm.objects(EventUserRealm.self).filter("taskID == %@", id)
        
        message += "\(currentEvent.count) Event(s) fetched and are:\n\(currentEvent)"
        
        message += " Event user name updated to \(currentEvent[0].userName)\n event now shows\n\(currentEvent)"
        
        print(message)

        // Awesome!
        // Populate vc with saved event / user
        for index in currentEvent {
            citySearch.text     = index.city
            userName.text       = index.userName
            production.text     = index.production
            company.text        = index.company
            dateTextInput.text  = index.date
        }
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                             update this user - segue back                             |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    
    @IBAction func updateAction(_ sender: Any) {
        
        //get last id used
        let id = getLastIdUsed()
        
        var message = "Saved id is\n\(id)\n"
        
        let currentEvent = realm.objects(EventUserRealm.self).filter("taskID == %@", id)
        
        message += "\(currentEvent.count) Event(s) fetched and are:\n\(currentEvent)"
        
        message += " Event user name updated to \(currentEvent[0].userName)\n event now shows\n\(currentEvent)"
        
        print(message)
        
        // update last used event with this user
        for update in currentEvent {
        
            try! realm.write {
                update.userName = userName.text!
                update.production = production.text!
                update.company = company.text!
                update.city = citySearch.text!
                update.date = dateTextInput.text!
                update.weather = weatherDisplay.text
                // update user in tableview row 0 as well
                update.tableViewArray?.rows[0].title = "\(userName.text!) Director of Photography"
                update.tableViewArray?.rows[0].detail = "Camera Order \(production.text!) \(dateTextInput.text!)"
            }
        }
         _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    // MARK: - Keyboard behavior functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userName.resignFirstResponder()
        production.resignFirstResponder()
        company.resignFirstResponder()
        dateTextInput.resignFirstResponder()
        return true
    }
   
    //MARK: - Search Weather
    @IBAction func searchWeather(_ sender: Any) {
        weatherDisplay.text = "Launching Search..."
        
        activityDial.startAnimating()
        
        let searchResult  =  CurrentLocation.sharedInstance.parseCurrentLocation(input: citySearch.text!)
        weatherDisplay.text = searchResult
        
        // if now parsing error call weather api in closure that returns a string for the UI
        if searchResult != errorOne && searchResult !=  errorTwo {
            
            GetWeather().getForecast { (result: String) in
                self.weatherDisplay.text = result
                self.activityDial.stopAnimating()
            }
            
        }  else {
            
            self.weatherDisplay.text = searchResult
            self.activityDial.stopAnimating()
            
        }
    }
    
    //MARK: - Activate date picker view
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    //MARK: - format the selected Date and update vars used in weather forcast
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateTextInput.text = dateFormatter.string(from: sender.date)
        
    }
    
    @IBAction func clearDBAction(_ sender: Any) {
        
                try! realm.write {
                    realm.deleteAll()
                }
    }
    
    @IBAction func showUserAction(_ sender: Any) {

        //get last id used
        let id = getLastIdUsed()
        
        var message = "Saved id is\n\(id)\n"
        
        let currentEvent = realm.objects(EventUserRealm.self).filter("taskID == %@", id)
        
        for things in currentEvent {
            
            message += "\nevent count = \(currentEvent.count)"
            message += "\neventName: \(things.eventName)"
            message += "\nuserName: \(things.userName)"
            message += "\nProduction: \(things.production)"
            message += "\ncompany: \(things.company)"
            message += "\ncity: \(things.city)"
            message += "\ndate: \(things.date)"
            message += "\nweather: \(things.weather)"
        }
        userData.text = message
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
