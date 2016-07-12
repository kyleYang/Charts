//
//  Ticker.swift
//  NewUstock
//
//  Created by Kyle on 16/5/24.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class Ticker: BaseObjectModel {
    
    var tickerId : Int = 0
    var tickerObjectId : String = ""
    var portfolioId : String = ""
    var name : String = ""
    var exchangeCode : String = ""
    var localExchangeCode : String  = ""
    var sortOrder : Int = 0
    var status : Int = 0
    var symbol : String = ""
    var operationTime : NSDate = NSDate()
    var updateTime : NSDate = NSDate()
    var type : Int = 0
    var holdings : Int?

    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)
        
        tickerId <- map["tickerId"]
        tickerObjectId <- map["id"]
        portfolioId <- map["portfolioId"]
        name <- map["name"]
        exchangeCode <- map["exchangeCode"]
        localExchangeCode <- map["localExchangeCode"]
        sortOrder <- map["sortOrder"]
        status <- map["status"]
        symbol <- map["symbol"]
        operationTime <- (map["operationTime"],USDateTransForm())
        updateTime <- (map["updateTime"],USDateTransForm())
        type <- map["type"]
        holdings <- map["holdings"]
        
    }
}
