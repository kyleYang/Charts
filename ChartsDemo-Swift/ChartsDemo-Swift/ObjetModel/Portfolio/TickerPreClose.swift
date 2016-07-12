//
//  TickerPreClose.swift
//  NewUstock
//  Ticker 前一天结束时候的信息
//  Created by Kyle on 16/6/17.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class TickerPreClose: BaseObjectModel {

    var limitDown : String = "0"
    var limitUp : String = "0"
    var preChange : String = "0"
    var preChangeRate : String = "0"
    var preClose : String = "0"
    var tickerId : Int = 0
    var tradeDate : NSDate = NSDate()
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)
        limitDown <- map["limitDown"]
        limitUp <- map["limitUp"]
        preChange <- map["preChange"]
        preChangeRate <- map["preChangeRate"]
        preClose <- map["preClose"]
        tickerId <- map["tickerId"]
        tradeDate <- (map["tradeDate"],USDateTransForm())
    }

    
}
