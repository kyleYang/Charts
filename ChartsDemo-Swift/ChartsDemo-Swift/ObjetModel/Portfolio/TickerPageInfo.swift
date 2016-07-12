//
//  TickerPageInfo.swift
//  NewUstock
//
//  Created by Kyle on 16/6/29.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class TickerPageInfo: BaseObjectModel {

    var tickerGain : TickerGain?
    var tradingList : Array<Trading>?
    
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)
        
        tickerGain <- map["tickerGain"]
        tradingList <- map["tradingList"]
    }
    
}
