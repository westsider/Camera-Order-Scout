//
//  Event User Realm Object.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/16/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

// class to hold each event, user and tableview list of equipment
class EventUserRealm: Object {
    
    dynamic var eventName = "Default"
    dynamic var taskID = NSUUID().uuidString    //   primaryKey
    dynamic var userName = "Default"
    dynamic var production = ""
    dynamic var company = ""
    dynamic var city = ""
    dynamic var date = ""
    dynamic var weather = ""
    
    var tableViewArray = List<TableViewRow>()
}


