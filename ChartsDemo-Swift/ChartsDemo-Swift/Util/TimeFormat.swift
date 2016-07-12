//
//  NSTimeInterval+Format.swift
//  NewUstock
//
//  Created by Kyle on 16/5/31.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit

extension NSTimeInterval {

	func timeFormat() -> String {

		let date = NSDate(timeIntervalSince1970: self)
		return date.timeFormat()

	}

	func displayFormat() -> String {
		let date = NSDate(timeIntervalSince1970: self)
		return date.displayFormat()

	}

	func dateDisplayFormat() -> String {
		let date = NSDate(timeIntervalSince1970: self)
		return date.dateDisplayFormat()

	}
}

var us_DayFormatKey = 0
var us_HourMinuteFormatKey = 0
var us_TimeFormatKey = 0
var us_DisplayFormatKey = 0
var us_DateDisplayFormatKey = 0

extension NSDate {

	private var us_DayFormatter: NSDateFormatter {
		get {
			guard let formatter = objc_getAssociatedObject(self, &us_DayFormatKey) as? NSDateFormatter else {
				let newFormatter = NSDateFormatter()
				newFormatter.dateFormat = "MM-dd"

				return newFormatter
			}
			return formatter
		}
	}
    
    private var us_HourMinuteFormatter: NSDateFormatter {
        get {
            guard let formatter = objc_getAssociatedObject(self, &us_HourMinuteFormatKey) as? NSDateFormatter else {
                let newFormatter = NSDateFormatter()
                newFormatter.dateFormat = "HH:mm"
                
                return newFormatter
            }
            return formatter
        }
    }
    

	private var us_GMTFormatter: NSDateFormatter {
		get {
			guard let formatter = objc_getAssociatedObject(self, &us_TimeFormatKey) as? NSDateFormatter else {
				let newFormatter = NSDateFormatter()
				newFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

				return newFormatter
			}
			return formatter
		}
	}

	private var us_DisplayFormat: NSDateFormatter {
		get {
			guard let formatter = objc_getAssociatedObject(self, &us_DisplayFormatKey) as? NSDateFormatter else {
				let newFormatter = NSDateFormatter()
				newFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
				newFormatter.timeZone = NSTimeZone.localTimeZone()

				return newFormatter
			}
			return formatter
		}
	}

	private var us_DateDisplayFormat: NSDateFormatter {
		get {
			guard let formatter = objc_getAssociatedObject(self, &us_DateDisplayFormatKey) as? NSDateFormatter else {
				let newFormatter = NSDateFormatter()
				newFormatter.dateFormat = "yyyy-MM-dd"
				newFormatter.timeZone = NSTimeZone.localTimeZone()

				return newFormatter
			}
			return formatter
		}
	}
    // 12-11
	func dayFormat() -> String {
		return self.us_DayFormatter.stringFromDate(self)
	}
    // 13:30
    func hourMinuteFormat() -> String {
        return self.us_HourMinuteFormatter.stringFromDate(self)
    }
    //
	func timeFormat() -> String {
		return self.us_GMTFormatter.stringFromDate(self)
	}

	func displayFormat() -> String {
		return self.us_DisplayFormat.stringFromDate(self)
	}

	func dateDisplayFormat() -> String {
		return self.us_DateDisplayFormat.stringFromDate(self)
	}
}

extension String {

	func gmtDate() -> NSDate {

		let timeFormat = NSDateFormatter()

		timeFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

		let date = timeFormat.dateFromString(self)

		if let _ = date {
			return date!
		}
		return NSDate()

	}

	func formatTimeInterval() -> NSTimeInterval {

		let date = self.gmtDate()

		return date.timeIntervalSince1970
	}

	func displayFormat() -> String {
		return self.gmtDate().displayFormat()
	}

	func dateDisplayFormat() -> String {
		return self.gmtDate().dateDisplayFormat()
	}

	func timeAgo() -> String {
		let currentCalendar = NSCalendar.currentCalendar()
		let flags: NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute]
		let nowComponents = currentCalendar.components(flags, fromDate: NSDate())
		let timeComponents = currentCalendar.components(flags, fromDate: self.gmtDate())

		// 比较时差
		if timeComponents.year == nowComponents.year {
			if timeComponents.month == nowComponents.month {
				if timeComponents.day == nowComponents.day {
					if timeComponents.hour == nowComponents.hour {
						return "\(nowComponents.minute - timeComponents.minute)分钟前"
					} else {
						var houStr = String(timeComponents.hour)
						var minStr = String(timeComponents.minute)
						if timeComponents.hour < 10 {
							houStr = "0\(houStr)"
						}
						if timeComponents.minute < 10 {
							minStr = "0\(minStr)"
						}
						return "今天 \(houStr):\(minStr)"
					}
				} else {
					if nowComponents.day - timeComponents.day == 1 {
						var houStr = String(timeComponents.hour)
						var minStr = String(timeComponents.minute)
						if timeComponents.hour < 10 {
							houStr = "0\(houStr)"
						}
						if timeComponents.minute < 10 {
							minStr = "0\(minStr)"
						}
						return "昨天 \(houStr):\(minStr)"
					} else {
						return "\(nowComponents.day - timeComponents.day)天前"
					}
				}
			} else {
				return "\(nowComponents.month - timeComponents.month)月前"
			}

		} else {
			return self.gmtDate().dateDisplayFormat()
		}
	}

}
