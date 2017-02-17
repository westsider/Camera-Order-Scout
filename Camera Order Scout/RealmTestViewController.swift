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
    //let user = UserRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveItAction(_ sender: Any) {

    }

    @IBAction func loadIItAction(_ sender: Any) {
        
        let currentEvent = realm.objects(EventUserRealm.self)
        savedText.text =  "all events\n\(currentEvent)"
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
//        let savedUser = realm.objects(UserRealm.self)
//        
//        print("savedUser before delete \(savedUser.count)")
//        try! realm.write {
//            realm.deleteAll()
//            
//        }
//        print("user after delete \(savedUser.count)")
    }
    
    @IBAction func setImage(_ sender: Any) {
        
       // let input = "1 Camera" as Any
        
        //iconImage.image = setTableViewIco
    }
    
    @IBAction func clearImage(_ sender: Any) {
        
        iconImage.image = UIImage(named: "manIcon")
        
    }
    
}

