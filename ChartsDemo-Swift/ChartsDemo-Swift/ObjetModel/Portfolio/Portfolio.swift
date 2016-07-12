//
//  Group.swift
//  NewUstock
//
//  Created by Kyle on 16/5/24.
//  Copyright © 2016年 ustock. All rights reserved.
//

//MARK: 组合结构体
import ObjectMapper

class Portfolio: BaseObjectModel{
    
    var portfolioId : String = ""
    var name : String = ""
    var currencyId : Int = 0
    var sortOrder : Int = 0
    var operationTime : NSDate = NSDate()
    var tickerList : Array<Ticker> = []

    required init?(_ map: Map) {
       super.init(map)
        
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        portfolioId <- map["portfolioId"]
        name <- map["name"]
        currencyId <- map["currencyId"]
        sortOrder <- map["sortOrder"]
        operationTime <- (map["operationTime"],USDateTransForm())
        tickerList <- map["tickerList"]
    }
}


extension Portfolio {
    
    func allTickerId() -> Array<String> {
        
        var tickerIds : Array<String> = []
        
        for (_,portfolio) in self.tickerList.enumerate(){
            tickerIds.append(portfolio.tickerObjectId)
        }
        return tickerIds
    }

}
