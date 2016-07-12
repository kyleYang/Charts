//
//  USIndex.swift
//  NewUstock

//  指数



//  Created by Kyle on 16/6/2.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit
import ObjectMapper

class USIndex: BaseObjectModel {

    var operationTime : NSDate = NSDate()
    var tickers : Array<Ticker> = []
    
    required init?(_ map: Map) {
        super.init(map)
        
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        tickers <- map["tickers"]
        operationTime <- (map["operationTime"],USDateTransForm())
    }

    
}
