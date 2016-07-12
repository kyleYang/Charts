//
//  TickerMinuteModel.swift
//  NewUstock
//
//  Created by Kyle on 16/7/7.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class TickerMinuteModel: BaseObjectModel {
    var high : Float = 0
    var low : Float = 0
    var perClose : Float = 0
    var tickerMinuteList : Array <TickerMinute> = []
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        high <- (map["high"],USFloatTransForm())
        low <- (map["low"],USFloatTransForm())
        perClose <- (map["perClose"],USFloatTransForm())
        tickerMinuteList <- map["tickerMinutes"]
    }
}
