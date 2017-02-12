//
//  EventRealm.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/10/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

//class EventRealm: Object {
//    
//    dynamic var eventName = "Default"
//    //  dynamic var user = UserRealm()  //'The `EventRealm.user` property must be marked as being optional.'
//    //dynamic var tableViewArray = [[Any]]()
//
//    
//// Specify properties to ignore (Realm won't persist these)
//    
////  override static func ignoredProperties() -> [String] {
////    return []
////  }
//}

class EventRealm: Object {
    dynamic var eventName = "Default"
    dynamic var userInfo: UserRealm?
    dynamic var tableViewArray:  EventTableView?
}
