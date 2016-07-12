//
//  USSearchFutures.swift
//  NewUstock
//
//  Created by Kyle on 16/6/2.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit
import ObjectMapper


class USSearchFutures: BaseObjectModel {
    
    var exchangeCode : String = ""
    var exchangeId : Int = 0
    var exchangeName : String = ""
    var tickerId : Int = 0
    var tickerName : String = ""
    var tickerSymbol : String = ""
    var tickerType : Int = 0
    
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)
        
        exchangeCode <- map["exchangeCode"]
        exchangeId <- map["exchangeId"]
        exchangeName <- map["exchangeName"]
        tickerId <- map["tickerId"]
        tickerName <- map["tickerName"]
        tickerSymbol <- map["tickerSymbol"]
        tickerType <- map["tickerType"]
    }

    
}
