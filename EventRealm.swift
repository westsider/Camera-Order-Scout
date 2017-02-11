//
//  EventRealm.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/10/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

class EventRealm: Object {
    
    dynamic var eventName = "Default"
    dynamic var user = UserRealm()
    dynamic var tableViewArray = [[Any]]()
    dynamic var images = [NSData]()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}