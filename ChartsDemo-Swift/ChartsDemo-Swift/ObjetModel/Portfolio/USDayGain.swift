//
//  USDayGain.swift
//  NewUstock
//
//  Created by Kyle on 16/7/5.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit
import ObjectMapper

class USDayGain: BaseObjectModel {

    var date : NSDate = NSDate()
    var gainRatio : Float = 0
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)
        date <- (map["date"],USDateTransForm())
        gainRatio <- (map["gainRatio"],USFloatTransForm())
    }

    
}
