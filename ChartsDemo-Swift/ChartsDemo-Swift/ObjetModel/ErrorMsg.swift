//
//  ErrorMsg.swift
//  NewUstock
//
//  Created by Kyle on 16/6/1.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit
import ObjectMapper

public class ErrorMsg: BaseObjectModel {
    
    var code : String = ""
    var msg : String = ""

    required public init?(_ map: Map) {
        super.init(map)
        
    }
    
    override public func mapping(map: Map) {
        super.mapping(map)
        code <- map["code"]
        msg <- map["msg"]
    }
    
}


extension ErrorMsg : ErrorType {
    
    
    
}
