//
//  TickerGain.swift
//  NewUstock
//
//  Created by Kyle on 16/6/6.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class TickerGain: BaseObjectModel {
    
    var currencyId :Int = 0
    var totalGain : String = ""
    var totalGainRatio : String = ""
    var dayGain : String = ""
    var dayGainRatio : String = ""
    var name : String = ""
    var holdings : Float?
    var marketValue : String = ""
    var tickerId : Int = 0
    var totalCost : String = ""
    var symbol : String = ""
    var lastPrice : String = ""
    var costPrice : String = ""
    
    
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)
       
        currencyId <- map["currencyId"]
        totalGain <- map["totalGain"]
        totalGainRatio <- map["totalGainRatio"]
        name <- map["name"]
        dayGain <- map["dayGain"]
        dayGainRatio <- map["dayGainRatio"]
        marketValue <- map["marketValue"]
        holdings <- (map["holdings"],USFloatTransForm())
        tickerId <- map["tickerId"]
        symbol <- map["symbol"]
        lastPrice <- map["lastPrice"]
        totalCost <- map["totalCost"]
        costPrice <- map["costPrice"]
        
    }


}
