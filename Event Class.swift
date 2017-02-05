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
    var equipment = [[String]]()
    var images = [UIImage]()
    
    init(eventName: String, user: User, equipment: [[String]], images: [UIImage]){
        self.eventName = eventName
        self.user = user
        self.equipment = equipment
        self.images = images
    }
    
}
