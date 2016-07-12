//
//  USSearchFund.swift
//  NewUstock
//
//  Created by Kyle on 16/6/2.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit
import ObjectMapper

class USSearchFund: BaseObjectModel {
    
    var areaCode : String = ""
    var exchangeCode : String = ""
    var exchangeId : Int = 0
    var exchangeName : String = ""
    var regionAlias : String = ""
    var regionId : Int = 0
    var regionName : String = ""
    var tickerId : Int = 0
    var tickerName : String = ""
    var tickerSymbol : String = ""
    var tickerType : Int = 0
    
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)
        
        areaCode <- map["areaCode"]
        exchangeCode <- map["exchangeCode"]
        exchangeId <- map["exchangeId"]
        exchangeName <- map["exchangeName"]
        regionAlias <- map["regionAlias"]
        regionId <- map["regionId"]
        regionName <- map["regionName"]
        tickerId <- map["tickerId"]
        tickerName <- map["tickerName"]
        tickerSymbol <- map["tickerSymbol"]
        tickerType <- map["tickerType"]
    }


}
