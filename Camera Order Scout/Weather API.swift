//
//  Weather API.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/6/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

struct ForecastDetail {
    let high: String
    let low: String
    let conditions: String
    let icon: String
    let pop: Float
    let humidity: Float
}

struct ForecastDate {
    let yday: Int
    let weekdayShort: String
    let weekday: String
    let month: Int
    let dayte: Int
}

func setIcon(input:String)-> UIImage {
    
    var thisImage:UIImage
    
    switch input {
    case "chancerain":
        thisImage = UIImage(named: "chancerain")!
    case "chancetstorms":
        thisImage =  UIImage(named: "chancetstorms")!
    case "clear":
        thisImage = UIImage(named: "clear")!
    case "nt_clear":
        thisImage = UIImage(named: "nt_clear")!
    case "partlycloudy":
        thisImage = UIImage(named: "partlycloudy")!
    case "overcast":
        thisImage = UIImage(named: "overcast")!
    case "cloudy":
        thisImage = UIImage(named: "overcast")!
    case "mostlycloudy":
        thisImage = UIImage(named: "overcast")!
    case "rain":
        thisImage = UIImage(named: "chancerain")!
    case "nt_partlycloudy":
        thisImage = UIImage(named: "partlycloudy")!
    case "snow":
        thisImage = UIImage(named: "snow")!
    case "fog":
        thisImage = UIImage(named: "snow")!
    default:
        thisImage = UIImage(named: "none")!
    }
    
    return thisImage
}

extension ForecastDate {
    
    /// Initialize ForecastDate model from JSON data.
    /// - parameter json: JSON data
    init?(json: [String: Any]) {
        
        // extract dictionary from json data
        guard let date = json["date"] as? [String: Any] else { return nil }
        
        // extract values from dictionary
        guard let yd = date["yday"] as? Int else { return nil }
        guard let dayshort = date["weekday_short"] as? String else { return nil }
        guard let day = date["weekday"] as? String else { return nil }
        guard let month = date["month"] as? Int else { return nil }
        guard let dayte = date["day"] as? Int else { return nil }
        
        // set struct properties
        self.yday = yd
        self.weekdayShort = dayshort
        self.weekday = day
        self.month = month
        self.dayte = dayte
    }
    
    /// An array of ForecastDate structs from JSON data.
    /// - parameter json: JSON data
    
    static func forecastDateArray(json: [String: Any]) -> [ForecastDate]? {
        guard let forecast = json["forecast"] as? [String: Any] else { return nil }
        guard let simpleforecast = forecast["simpleforecast"] as? [String: Any] else { return nil }
        guard let forecastArray = simpleforecast["forecastday"] as? [[String: Any]] else { return nil }
        let forecasts = forecastArray.flatMap{ ForecastDate(json: $0) }
        return forecasts.count > 0 ? forecasts : nil    // if array has no elements return nil
    }
}

extension ForecastDetail {
    
    /// Initialize ForecastDetail model from JSON data.
    /// - parameter json: JSON data
    
    init?(json: [String: Any]) {
        
        // extract dictionaries from json data
        guard let high = json["high"] as? [String: Any] else { return nil }
        guard let low = json["low"] as? [String: Any] else { return nil }
        
        // extract values from dictionaries
        guard let hi = high["fahrenheit"] as? String else { return nil }
        guard let lo = low["fahrenheit"] as? String else { return nil }
        guard let co = json["conditions"] as? String else { return nil }
        guard let ic = json["icon"] as? String else { return nil }
        guard let po = json["pop"] as? Float else { return nil }
        guard let hu = json["avehumidity"] as? Float else { return nil }
        
        // set struct properties
        self.high = hi
        self.low = lo
        self.conditions = co
        self.icon = ic
        self.pop = po
        self.humidity = hu
    }
    
    /// An array of ForecastDetail structs from JSON data.
    /// - parameter json: JSON data
    static func forecastDetialArray(json: [String: Any]) -> [ForecastDetail]? {
        guard let forecast = json["forecast"] as? [String: Any] else { return nil }
        guard let simpleforecast = forecast["simpleforecast"] as? [String: Any] else { return nil }
        guard let forecastArray = simpleforecast["forecastday"] as? [[String: Any]] else { return nil }
        let forecasts = forecastArray.flatMap{ ForecastDetail(json: $0) }
        return forecasts.count > 0 ? forecasts : nil    // if array has no elements return nil
    }
}

class GetWeather {
    // MARK: - Forecast
    func getForecast(completion: @escaping (_ result: String) -> Void) {
        
        var theWeather: String = ""
        
        let task = URLSession.shared.dataTask(with: CurrentLocation.sharedInstance.forcastURL! as URL) {(data, response, error) in
            
            let json: [String: Any]?
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                
            } catch {
                json = nil
            }
            // weather detail object
            if  let forecastDetail = ForecastDetail.forecastDetialArray(json: json!) {
                
                var dateDetailArray:[String] = [" "]
                
                var i = 0
                
                dateDetailArray.removeAll()
                
                for element in forecastDetail {
                    
                    // date object array
                    let forecastDate = ForecastDate.forecastDateArray(json: json!)
                    var thisDate = "17"
                    // parse month / day
                    if forecastDate?[i].month != nil && forecastDate?[i].dayte != nil
                    {
                        thisDate = String(forecastDate![i].month) + "/" + String(forecastDate![i].dayte)
                    }
                    // setting one line fore each day
                    let newLine = thisDate + "  " + element.low + "°-" + element.high + "°  " + element.conditions + "\r\n"
                    dateDetailArray.append(newLine)
                    
                    i = i + 1
                }
                
                DispatchQueue.main.async(execute: {
                    // create text block for weather forecast array
                    for element in dateDetailArray {
                        let newElement = element
                        theWeather = theWeather + newElement
                    }
                    
                    completion("\(theWeather)")
                    
                })
            }
        }
        task.resume()
    }
}

