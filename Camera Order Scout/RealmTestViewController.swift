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

class RealmTestViewController: UIViewController {
 @IBOutlet weak var loadAction: NSLayoutConstraint!
     @IBOutlet weak var saveAction: UIButton!
    
    @IBOutlet weak var textInput: UITextField!

    @IBOutlet weak var savedText: UITextView!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    
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
    
    @IBAction func setImage(_ sender: Any) {
        
       // let input = "1 Camera" as Any
        
        //iconImage.image = setTableViewIco
    }
    
    @IBAction func clearImage(_ sender: Any) {
        
        iconImage.image = UIImage(named: "manIcon")
        
    }
    
}

