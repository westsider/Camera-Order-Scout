//
//  Event Class.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/4/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var eventName: String = "Default"
    var user: User
    var tableViewArray = [[Any]]()    //  tableViewArray[[String]]
    var images = [UIImage]()
    
    init(eventName: String, user: User, tableViewArray: [[Any]], images: [UIImage]){
        self.eventName = eventName
        self.user = user
        self.tableViewArray = tableViewArray
        self.images = images
    }
    
    func addUserToTableviewArray (){
        
        images.append( UIImage(named: "manIcon")!)
        
        tableViewArray = [["\(user.name) Director of Photography"], ["Camera Order \(user.production) \(user.date)"]]
    }
}
