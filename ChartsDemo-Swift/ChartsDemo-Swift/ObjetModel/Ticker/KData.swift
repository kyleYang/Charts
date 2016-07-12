//
//  KData.swift
//  NewUstock
//
//  Created by Kyle on 16/7/7.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class KData: BaseObjectModel {
    
    var close : Float    = 0
    var preClose : Float = 0
    var open : Float     = 0
    var high : Float     = 0
    var low : Float      = 0
    var ma5 : Float      = 0
    var ma10 : Float     = 0
    var ma30 : Float     = 0
    var ma60 : Float     = 0
    var ma120 : Float    = 0
    var vol5 : Float     = 0
    var vol10 : Float    = 0
    var vol20 : Float    = 0
    var vol30 : Float    = 0
    var vol60 : Float    = 0
    var vol120 : Float   = 0

    override init() {
        super.init()
    }
    
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        close <- (map["hasMoreData"],USFloatTransForm())
        preClose <- (map["preClose"],USFloatTransForm())
        high <- (map["high"],USFloatTransForm())
        low <- (map["low"],USFloatTransForm())
        ma5 <- (map["ma5"],USFloatTransForm())
        ma10 <- (map["ma10"],USFloatTransForm())
        ma30 <- (map["ma30"],USFloatTransForm())
        ma60 <- (map["ma60"],USFloatTransForm())
        ma120 <- (map["ma120"],USFloatTransForm())
        vol5 <- (map["vol5"],USFloatTransForm())
        vol10 <- (map["vol10"],USFloatTransForm())
        vol20 <- (map["vol20"],USFloatTransForm())
        vol30 <- (map["vol30"],USFloatTransForm())
        vol60 <- (map["vol60"],USFloatTransForm())
        vol120 <- (map["vol120"],USFloatTransForm())
    }

    
    
}
