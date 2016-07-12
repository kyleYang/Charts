//
//  RealBrief.swift
//  NewUstock
//  实时行情简要
//  Created by Kyle on 16/6/12.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class RealBrief: BaseObjectModel {

    var change : String = "0"
    var changeRatio : String = "0"
    var close : String = "0" //最新行情
    var name  : String = ""
    var regionId : Int = 0
    var tickerId : Int = 0
    var turnoverRate : String = "0"
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)
        change <- map["change"]
        changeRatio <- map["changeRatio"]
        close <- map["close"]
        name <- map["name"]
        regionId <- map["regionId"]
        tickerId <- map["tickerId"]
        turnoverRate <- map["turnoverRate"]
    }
    
}
