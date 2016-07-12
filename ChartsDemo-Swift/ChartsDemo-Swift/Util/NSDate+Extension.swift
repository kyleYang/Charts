//
//  NSDate+Extension.swift
//  NewUstock
//
//  Created by Kyle on 16/7/5.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit
import SwiftDate

extension NSDate {
    
    
    class func addMonths(date : NSDate? = NSDate(), months : Int) -> NSDate{
        var after : NSDate!
        if months < 0 {
            after = abs(months).months.agoFromDate(date)
        }else{
            after = months.months.fromDate(date)
        }
        return after.startOf(.Day)
    }
    
    class func addYears(date : NSDate? = NSDate(), years : Int) -> NSDate{
        var after : NSDate!
        if years < 0 {
            after = abs(years).years.agoFromDate(date)
        }else{
            after = years.years.fromDate(date)
        }
        return after.startOf(.Day)
    }
    
    class func thisYear(date : NSDate? = NSDate()) -> NSDate {
        return date!.startOf(.Year)
    }
    
    
    class func getToday() -> NSDate {
        return NSDate().startOf(.Day)
        
    }
    
    class func between(firstDate : NSDate , secondDate : NSDate) -> Int {
        
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDayForDate(firstDate)
        let date2 = calendar.startOfDayForDate(secondDate)
        
        let flags = NSCalendarUnit.Day
        let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
        
        return components.day
        
    }
    
}