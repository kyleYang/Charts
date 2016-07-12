//
//  Trading.swift
//  NewUstock
//
//  Created by Kyle on 16/6/8.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class Trading: BaseObjectModel {
    
    var amount : String = ""
    var commission : String = ""
    var commissionRatio : String = ""
    var date : NSDate = NSDate()
    var operationTime : NSDate = NSDate()
    var portfolioId : String = ""
    var price : String = ""
    var tickerId : Int = 0
    var tradingId : String = ""
    var type : Int = 0
    var updateTime : NSDate = NSDate()
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        amount <- map["amount"]
        commission <- map["commission"]
        commissionRatio <- map["commissionRatio"]
        date <- (map["date"],USDateTransForm())
        operationTime <- (map["operationTime"],USDateTransForm())
        portfolioId <- map["portfolioId"]
        price <- map["price"]
        tickerId <- map["tickerId"]
        tradingId <- map["tradingId"]
        type <- map["type"]
        updateTime <- (map["updateTime"],USDateTransForm())
       
    }
    
    

}
