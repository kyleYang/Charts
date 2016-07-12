//
//  TickerkDatasModel.swift
//  NewUstock
//
//  Created by Kyle on 16/7/6.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class TickerKDatasModel: BaseObjectModel {
    var hasMoreData : Bool = false
    var tickerKDataList : Array<TickerKDatas> = []
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        hasMoreData <- map["hasMoreData"]
        tickerKDataList <- map["tickerKDatas"]
    }

    
}
