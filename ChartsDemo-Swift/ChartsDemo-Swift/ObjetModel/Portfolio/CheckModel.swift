//
//  CheckObject.swift
//  NewUstock
//
/*

合并接口


*/
//  Created by Kyle on 16/6/2.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit
import ObjectMapper

class CheckModel: BaseObjectModel {

    var version : Int = 0
    var indexes : USIndex?
    var portfolioList : Array<Portfolio> = []
    
    required init?(_ map: Map) {
        super.init(map)
        
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        version <- map["version"]
        indexes <- map["indexes"]
        portfolioList <- map["portfolioList"]
    }
}


