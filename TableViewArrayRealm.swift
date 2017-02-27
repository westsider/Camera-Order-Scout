//
//  TableViewArrayRealm.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/11/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

// class to add tableview rows to each event
class TableViewRow: Object {
    dynamic var icon = ""
    dynamic var title = ""
    dynamic var detail =  ""
    dynamic var catagory = 0    // to sort this later
    
    override var description: String { return "TableViewRow {\(icon), \(title), \(detail)}" }
}

//  class to track past events
class EventTracking: Object {
    dynamic var lastID = ""
}
