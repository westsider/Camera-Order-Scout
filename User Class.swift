//
//  User Class.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/4/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

class User {
    var name: String
    var production: String
    var company: String
    var city: String
    var date: String
    var weather: String
    var icon: UIImage
    //var logo: NSData
    init(name: String, production: String, company: String, city: String, date: String, weather: String, icon: UIImage) {
        self.name = name
        self.production = production
        self.company = company
        self.city = city
        self.date = date
        self.weather = weather
        self.icon = icon
    }
}
