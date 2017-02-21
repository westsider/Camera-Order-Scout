//
//  RealmTestViewController.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/10/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit
import RealmSwift


class RealmTestViewController: UIViewController {
 
    @IBOutlet weak var loadAction: NSLayoutConstraint!
    
    @IBOutlet weak var saveAction: UIButton!
    
    @IBOutlet weak var textInput: UITextField!

    @IBOutlet weak var savedText: UITextView!

    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allEvents = realm.objects(EventUserRealm.self)
        var message = ""
        for events in allEvents {
            message += "\n\(events.eventName)"
            message += "\n\(events.userName)"
            message += "\n\(events.taskID)"
            for rows in events.tableViewArray {
                message += "\nicon = \(rows.icon)"
                message += "\n\(rows.title)"
                message += "\n\(rows.detail)"
            }
            message += "\n"
        }
        savedText.text =  message
    }

    @IBAction func saveItAction(_ sender: Any) {
    }

    @IBAction func loadIItAction(_ sender: Any) {
    }
}

