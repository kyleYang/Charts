//
//  Index.swift
//  NewUstock
//  指数
//  Created by Kyle on 16/6/18.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class Index: BaseObjectModel {
    
    var name : String = ""
    var marketIndexList : Array<IndexTicker> = []
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        name <- map["name"]
        marketIndexList <- map["marketIndexList"]
    }
}

