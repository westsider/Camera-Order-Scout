//
//  DatePicker.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/6/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation

/** Functions to convert picker date to a Day in the future for forecast */
class DatePickerUtility {
    
    // MARK: - calculate number of days bettween 2 Dates
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day!
    }
    
    //  MARK: -  convert number of days in the future to Short Date
    func convertShortDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM / dd"
        let stringDate = formatter.string(from: date)
        return stringDate
    }
    
    // MARK: - Create a future Date with an Int from today
    func addDays(days: Int) -> Date {
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: days, to: today)
        print("\(tomorrow)")
        return tomorrow!
    }
    
    // MARK: - Convert Number of tadys from today to a short date string
    func numOfDaysToShortDate(numOfDays: Int) -> String {
        
        let firstFutureDate = self.addDays(days: numOfDays)
        
        print("Is This the first future DATE? \(firstFutureDate)")     // future DATE
        
        return self.convertShortDate(date: firstFutureDate)
    }
    
}
