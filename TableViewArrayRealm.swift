//
//  TableViewArrayRealm.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/11/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

// tableview row object for realm
class TableViewRow: Object {
    dynamic var icon = ""
    dynamic var title = ""
    dynamic var detail =  ""
    
    override var description: String { return "TableViewRow {\(icon), \(title), \(detail)}" }
}

//  tableview object for realm
class EventTableView: Object {
    let rows = List<TableViewRow>()
    //override var description: String { return "Car {\(brand), \(name), \(year)}" }
    
    func replaceUser(){
        print("replace user called")
    }
}
