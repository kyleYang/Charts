//
//  USDateTransForm.swift
//  NewUstock
//
//  Created by Kyle on 16/6/6.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

public class USDateTransForm: DateTransform {
    
    public override func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let timeInt = value as? Double {
            return NSDate(timeIntervalSince1970: NSTimeInterval(timeInt))
        }
        
        if let timeStr = value as? String {
            return timeStr.gmtDate()
        }
        
        return nil
    }
    
}
