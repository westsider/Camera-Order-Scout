//
//  Location API.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/6/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation

class CurrentLocation {
    
    static let sharedInstance = CurrentLocation()
    
    var cityInput = ""
    
    var last = ""
    
    var first = ""
    
    var url = NSURL(string: "https://api.wunderground.com/api")
    
    var forcastURL = NSURL(string: "api.openweathermap.org/data/2.5/forecast/q={city name},{country code}&cnt={cnt}")
    func parseCurrentLocation(input: String)-> String {
        //  let location = cityInput.text!
        let location = input
        let str = location
        let split = str.characters.split(separator: " ")
        let size = split.count
        var last = ""
        var first = ""
        
        
        switch size {
            
        // no text entered, use gps to find location
        case 0:
            return  "Please Enter a City and State or Country"
        //  city , state -- Venice, CA
        case 2:
            last = String(split.suffix(1).joined(separator: [" "]))
            first = String(split.prefix(upTo: 1).joined(separator: [" "]))
            // set forecast url
            forcastURL = NSURL(string: "https://api.wunderground.com/api/f6373e95fa296c84/forecast10day/q/" + last + "/" + first + ".json")
            return first + last
            
        // city city, state -- San Fransisco, CA
        case 3:
            last = String(split.suffix(1).joined(separator: [" "]))
            first = String(split.prefix(upTo: 2).joined(separator: [" "]))
            // must join first 2 city names by _ underscore
            first = first.replacingOccurrences(of: " ", with: "_")
            // must remove commas
            first = first.replacingOccurrences(of: ",", with: "")
            // set forecast url
            self.forcastURL = NSURL(string: "https://api.wunderground.com/api/f6373e95fa296c84/forecast10day/q/" + last + "/" + first + ".json")
            return first + last
            
        // city city city, state -- Marina Del Rey, CA
        case 4:
            last = String(split.suffix(1).joined(separator: [" "]))
            first = String(split.prefix(upTo: 3).joined(separator: [" "]))
            // must join first 2 city names by _ underscore
            first = first.replacingOccurrences(of: " ", with: "_")
            // must remove commas
            first = first.replacingOccurrences(of: ",", with: "")
            // set forecast url
            self.forcastURL = NSURL(string: "https://api.wunderground.com/api/f6373e95fa296c84/forecast10day/q/" + last + "/" + first + ".json")
            return first + last
        // only 1 word entered, need more info
        default:
            //  first = String(split.prefix(upTo: 1).joined(separator: [" "]))
            //  url = NSURL(string: "https://api.wunderground.com/api/f6373e95fa296c84/conditions/q/" + first + ".json")
            //  forcastURL = NSURL(string: "https://api.wunderground.com/api/f6373e95fa296c84/forecast10day/q/" + first + ".json")
            return "Please include a state or country"
        }
        
    }
    
}
