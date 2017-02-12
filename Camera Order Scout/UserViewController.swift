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
    
    let user = UserRealm()              // Use them like regular Swift objects
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userName.delegate = self
        self.production.delegate = self
        self.company.delegate = self
        self.dateTextInput.delegate = self
        title = "J O B  I N F O"
        
        
        // fill in city from previous use on this VC *** use thisEvent.user.city
        if  thisEvent.user.city.isEmpty {
            citySearch.text = "please enter a city"
        } else {
            citySearch.text = thisEvent.user.city
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        // get user from realm
        let savedUser = realm.objects(UserRealm.self)
        
        for items in savedUser {
            userName.text       = items.name
            production.text     = items.production
            company.text        = items.company
            dateTextInput.text  = items.date
        }
        
        //  get user from main vc - use event
        print("\nEvent Lifecycle 2, user vwl, create the event \(thisEvent.eventName, thisEvent.user.name, thisEvent.user.production, thisEvent.user.company, thisEvent.user.city, thisEvent.user.date, thisEvent.user.weather)")
    }
    
    /*---------------------------------------------------------------------------------------
     |                                                                                       |
     |                             update this user - segue back                             |
     |                                                                                       |
     ---------------------------------------------------------------------------------------*/
    
    @IBAction func updateAction(_ sender: Any) {
        
        let savedUser = realm.objects(UserRealm.self)
        
        // change default text to user name
        if (userName.text?.isEmpty)! {
            print("Username Empty")
        } else {
            let name = userName.text!
            thisEvent.user.name = name
            
            // Persist your data easily
            try! realm.write {
                savedUser[0].name = name    // update in realm
                //savedUser[0].icon = NSData(data: UIImagePNGRepresentation(#imageLiteral(resourceName: "manIcon"))!)
                print("user name uodated to: \(savedUser[0].name)")
            }
        }
        
        // change default text to production
        if production.text! == "default" {
            print("production Empty")
        } else {
              thisEvent.user.production = production.text!
            // Persist your data easily
            try! realm.write {
                savedUser[0].production = production.text!    // update in realm
                print("user production uodated to: \(savedUser[0].production)")
            }
        }
        
        // change default text to company
        if company.text! == "default"  {
            print("company Empty")
        } else {
              thisEvent.user.company = company.text!
            // Persist your data easily
            try! realm.write {
                savedUser[0].company = company.text!    // update in realm
                print("user company uodated to: \(savedUser[0].company)")
            }
        }
        
        // change default text to date
        if citySearch.text! == ""  {
            print("City Empty")
        } else {
              thisEvent.user.city = citySearch.text!
            
            // Persist your data easily
            try! realm.write {
                savedUser[0].city = citySearch.text!    // update in realm
                print("user city uodated to: \(savedUser[0].city)")
            }
        }
        
        // change default text to date
        if dateTextInput.text! == ""  {
            print("Date Empty")
        } else {
            thisEvent.user.date = dateTextInput.text!
            
            // Persist your data easily
            try! realm.write {
                savedUser[0].date = dateTextInput.text!    // update in realm
                print("user date uodated to: \(savedUser[0].date)")
            }
        }
        
        // chznge default text to weather
        if weatherDisplay.text == "" {
            print("weather Empty")
        } else {
            thisEvent.user.weather = weatherDisplay.text
            
            // Persist your data easily
            try! realm.write {
                savedUser[0].weather = weatherDisplay.text!    // update in realm
                print("user weather uodated to: \(savedUser[0].weather)")
            }
        }
        
        //  get user from main vc - use event
        print("\nEvent Lifecycle 3, user vwl, update the event \(thisEvent.eventName, thisEvent.user.name, thisEvent.user.production, thisEvent.user.company, thisEvent.user.city, thisEvent.user.date, thisEvent.user.weather)")
        
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
        let savedUser = realm.objects(UserRealm.self)
        var message = "users = \(savedUser.count)"
        
        for items in savedUser {
            print("\nsavedUser from Job Info \(savedUser.count)  \(items.name)") // => 1
            message += "\nName: \(items.name)"
            message += "\nProduction: \(items.production)"
            message += "\ncompany: \(items.company)"
            message += "\ncity: \(items.city)"
            message += "\ndate: \(items.date)"
            message += "\nweather: \(items.weather)"
        }
        
        userData.text = message
    }
    
}
