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
        
        // get event + user from realm
        let savedEvent = realm.objects(EventRealm.self)

        // Awesome!
        // Populate vc with saved event / user
        for index in savedEvent {
            userName.text       = index.userInfo!.name
            production.text     = index.userInfo!.production
            company.text        = index.userInfo!.company
            dateTextInput.text  = index.userInfo!.date
        }
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                             update this user - segue back                             |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    
    @IBAction func updateAction(_ sender: Any) {
        
        // overwite event + user with text input
        let savedEvent = realm.objects(EventRealm.self)
        
        for things in savedEvent {
            guard let evnt = things.userInfo else {
                print("error")
                return
            }
            
            // Persist your data easily
            try! realm.write {
                evnt.name = userName.text!
                evnt.production = production.text!
                evnt.company = company.text!
                evnt.city = citySearch.text!
                evnt.date = dateTextField.text!
                evnt.weather = weatherDisplay.text
            }
        }
        
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
        
        datePickerView.addTarget(self, action: #selector(UserViewController.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    //MARK: - format the selected Date and update vars used in weather forcast
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateTextInput.text = dateFormatter.string(from: sender.date)
        
        thisEvent.user.date  = dateFormatter.string(from: sender.date)
        
    }
    
    
    @IBAction func showUserAction(_ sender: Any) {

        // get event / user from realm
        let savedEvent = realm.objects(EventRealm.self)
        var message = ""
        for things in savedEvent {
            guard let evnty = things.userInfo else {
                print("error")
                return
            }
            message += "users = \(savedEvent.count)"
            message += "\nName: \(evnty.name)"
            message += "\nProduction: \(evnty.production)"
            message += "\ncompany: \(evnty.company)"
            message += "\ncity: \(evnty.city)"
            message += "\ndate: \(evnty.date)"
            message += "\nweather: \(evnty.weather)"
            
        }
        userData.text = message
    }
    
}
