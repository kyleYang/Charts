//
//  USChartUtil.swift
//  NewUstock
//
//  Created by Kyle on 16/7/11.
//  Copyright © 2016年 ustock. All rights reserved.
//

import SwiftDate


public func ==(left: USTickerKChartBriefType, right: USTickerKChartBriefType) -> Bool {
    switch (left,right) {
    case (.Hour,.Hour):
        return true
    case (.FiveDay,.FiveDay):
        return true
    case (.Days,.Days):
        return true
    case (.Week,.Week):
        return true
    case (.Minutes(let leftType),.Minutes(let rightType)):
        return leftType == rightType
    default:
        return false
    }
}

public func ==(left: USTickerKCartMinuteType, right: USTickerKCartMinuteType) -> Bool {
    switch (left,right) {
    case (.One,.One):
        return true
    case (.Five,.Five):
        return true
    case (.Fifteen,.Fifteen):
        return true
    case (.Thirty,.Thirty):
        return true
    case (.Sixty,.Sixty):
        return true
    default:
        return false
    }
}


class USChartUtil: NSObject {
    

    static func getXAxis(date:NSDate? = NSDate(), regionId : USTickerChartRegion,chartType : USTickerChartType ,dataType : USTickerKChartBriefType) -> [String?] {
     
        if regionId == .CN {
            return getCNXAxis(date,chartType:chartType, dataType: dataType)
        }
        return []
    }
    
    
    //MARK
    private static func getCNXAxis(date:NSDate? = NSDate(),chartType : USTickerChartType,dataType : USTickerKChartBriefType) -> [String?]{
        
        if chartType == .Brief {
            
            return getCNBriefXAxis(date,dataType:dataType)
            
        }
        return []
    }
    
    //9：30 - 11：30   1：00 - 15：00
    private static func getCNBriefXAxis(date:NSDate? = NSDate(),dataType : USTickerKChartBriefType)-> [String?]{
        
        var xVals : Array<String?> = []
        
        if dataType == .Hour {
            xVals.append("\(date!.month)/\(date!.day)")
            //9：30 - 11：30
            var beginDate = NSDate(year: date!.year, month: date!.month, day: date!.day, hour: 9,minute:31)
            var endDate = NSDate(year: date!.year, month: date!.month, day: date!.day, hour: 11,minute:30)
            
            var tempDate = beginDate;
            repeat{
                if tempDate.minute == 30 {
                    xVals.append("\(tempDate.hour):\(tempDate.minute)")
                }else{
                    xVals.append(nil)
                }
                tempDate = 1.minutes.fromDate(tempDate)
                
            }while tempDate < endDate
            
            xVals.append("\(tempDate.hour):\(tempDate.minute)") // 11：30
            
            //1：00 - 15：00
            beginDate = NSDate(year: date!.year, month: date!.month, day: date!.day, hour: 13,minute:01)
            endDate = NSDate(year: date!.year, month: date!.month, day: date!.day, hour: 15,minute:00)
            
            tempDate = beginDate;
            repeat{
                if tempDate.minute == 0 {
                    xVals.append("\(tempDate.hour):\(tempDate.minute)")
                }else{
                    xVals.append(nil)
                }
                tempDate = 1.minutes.fromDate(tempDate)
                
            }while tempDate < endDate
            xVals.append(nil) //15：00 不显示
            return xVals
        }
        return []
    }

}
