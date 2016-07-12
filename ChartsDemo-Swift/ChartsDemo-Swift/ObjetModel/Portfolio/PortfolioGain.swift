//
//  PortfolioGain.swift
//  NewUstock
//
//  Created by Kyle on 16/6/6.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class PortfolioGain: BaseObjectModel {
    
    var currencyId : Int = 0
    var name : String = ""
    var totalGain : String = ""
    var totalGainRatio : String = ""
    var dayGain : String = ""
    var dayGainRatio : String = ""
    var marketValue : String = ""
    var portfolioId : String = ""
    var tickerGainList : Array<TickerGain> = []
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)
        
        currencyId <- map["currencyId"]
        totalGain <- map["totalGain"]
        name <- map["name"]
        totalGainRatio <- map["totalGainRatio"]
        dayGain <- map["dayGain"]
        dayGainRatio <- map["dayGainRatio"]
        marketValue <- map["marketValue"]
        portfolioId <- map["portfolioId"]
        tickerGainList <- map["tickerGainList"]
        
    }


}
