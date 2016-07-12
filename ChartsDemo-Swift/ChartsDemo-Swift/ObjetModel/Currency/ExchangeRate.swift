//
//  ExchangeRate.swift
//  NewUstock
//
//  Created by Kyle on 16/6/27.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class ExchangeRate: BaseObjectModel {
    
    var sourceId : Int = 0
    var sourceName : String = ""
    var sourceCode : String = ""
    var targetId : Int = 0
    var targetName : String = ""
    var targetCode : String = ""
    var value : Double = 0

    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)
        sourceId <- map["sourceId"]
        sourceName <- map["sourceName"]
        sourceCode <- map["sourceCode"]
        targetId <- map["targetId"]
        targetName <- map["targetName"]
        targetCode <- map["targetCode"]
        value <- map["value"]
    }

}
