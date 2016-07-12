//
//  TickerKDatas.swift
//  NewUstock
//
//  Created by Kyle on 16/7/6.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class TickerKDatas: BaseObjectModel {
    var tickerId : Int         = 0
    var dealAmount : Float     = 0
    var dealNum : Float        = 0
    var growthPe : Float       = 0
    var innerDisc : Float      = 0
    var marketValue : Float    = 0
    var negMarketValue : Float = 0
    var outerDisc : Float      = 0
    var pb : Float             = 0
    var pe : Float             = 0
    var turnoverRate : Float   = 0
    var volume : Float         = 0
    var tradeTime : NSDate     = NSDate()

    var forwardKData : KData   = KData()
    var noneKData : KData      = KData()
    var afterKData : KData     = KData()
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        tickerId <- map["tickerId"]
        dealAmount <- (map["dealAmount"],USFloatTransForm())
        dealNum <- (map["dealNum"],USFloatTransForm())
        growthPe <- (map["growthPe"],USFloatTransForm())
        innerDisc <- (map["innerDisc"],USFloatTransForm())
        marketValue <- (map["marketValue"],USFloatTransForm())
        negMarketValue <- (map["negMarketValue"],USFloatTransForm())
        outerDisc <- (map["outerDisc"],USFloatTransForm())
        pb <- (map["pb"],USFloatTransForm())
        pe <- (map["pe"],USFloatTransForm())
        turnoverRate <- (map["turnoverRate"],USFloatTransForm())
        volume <- (map["volume"],USFloatTransForm())
        tradeTime <- (map["tradeTime"],USDateTransForm())
        forwardKData <- map["forwardKData"]
        noneKData <- map["noneKData"]
        afterKData <- map["afterKData"]
    }

    
}
