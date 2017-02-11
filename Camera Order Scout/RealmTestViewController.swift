//
//  RealmTestViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/10/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import RealmSwift

// Define your models like regular Swift classes
/*
class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
}
class Person: Object {
    dynamic var name = ""
    dynamic var picture: NSData? = nil // optionals supported
    let dogs = List<Dog>()
}

class UserRealm: Object {
    
    dynamic var name = ""
    dynamic var production = ""
    dynamic var company = ""
    dynamic var city = ""
    dynamic var date = ""
    dynamic var weather = ""
    dynamic var icon:  NSData?
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
}
*/
class RealmTestViewController: UIViewController {
 @IBOutlet weak var loadAction: NSLayoutConstraint!
     @IBOutlet weak var saveAction: UIButton!
    
    @IBOutlet weak var textInput: UITextField!

    @IBOutlet weak var savedText: UITextView!
    
    
    
    // Get the default Realm
    let realm = try! Realm()
    // Use them like regular Swift objects
    let user = UserRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveItAction(_ sender: Any) {
   
        if textInput.text != "" {
            
            var message = ""
            let textToSave = textInput.text
            
            user.name = textToSave!

            print("name of  new user: \(user.name)")
            message = "name of  new user: \(user.name)"
            
            let savedUser = realm.objects(UserRealm.self)
            
            print("savedUser before write \(savedUser.count)")
            message += "\nsavedUser before write \(savedUser.count)"
            
            // Persist your data easily
            try! realm.write {
                realm.add(user)
                print("add user")
            }
            
            // Queries are updated in realtime
            print("user after write \(savedUser.count)")
            message += "\nuser after write \(savedUser.count)"
            savedText.text = message
        }
    }

    @IBAction func loadIItAction(_ sender: Any) {
        
        let savedUser = realm.objects(UserRealm.self)
        var message = "user count = \(savedUser.count)"
        
        print("user name: \(savedUser[0].name)")
        
        for items in savedUser {
         print("loadTheSavedUsers from loadIItAction \(savedUser.count)  \(items.name)") // => 1
            message += "\nUser Name: \(items.name)"
        }
        savedText.text = message
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        let savedUser = realm.objects(UserRealm.self)
        
        print("savedUser before delete \(savedUser.count)")
        try! realm.write {
            realm.deleteAll()
            
        }
        print("user after delete \(savedUser.count)")
    }
    
}

/*
 in main vc add user if user.count = 0
 
 // Get the default Realm
 let realm = try! Realm()
 // Use them like regular Swift objects
 let user = UserRealm()
 
// check for users
 if user.count = 0 {}
 try! realm.write {
 realm.add(user)
 print("add user")
 }
 
 
 in user vc just update the user values --
 
 // Get the default Realm
 let realm = try! Realm()
 // Use them like regular Swift objects
 let user = UserRealm()
 
 user.name = userName.text
 
 */
