//
//  UserRealm.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/10/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

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
