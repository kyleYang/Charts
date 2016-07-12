//
//  TickerMinute.swift
//  NewUstock
//
//  Created by Kyle on 16/7/7.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class TickerMinute: BaseObjectModel {
    var tickerId : Int = 0
    var open : Float = 0
    var close : Float = 0
    var high : Float = 0
    var low : Float = 0
    var volume : Float = 0
    var dealAmount : Float = 0
    var avg : Float = 0
    var tradeTime : NSDate = NSDate()
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        tickerId <- map["tickerId"]
        open <- (map["open"],USFloatTransForm())
        close <- (map["close"],USFloatTransForm())
        high <-  (map["high"],USFloatTransForm())
        low <- (map["low"],USFloatTransForm())
        volume <- (map["volume"],USFloatTransForm())
        dealAmount <-  (map["dealAmount"],USFloatTransForm())
        avg <- (map["avg"],USFloatTransForm())
        tradeTime <- (map["tradeTime"],USDateTransForm())
    }
    
}
