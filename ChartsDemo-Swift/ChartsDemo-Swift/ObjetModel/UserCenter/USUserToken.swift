//
//  USUserToken.swift
//  NewUstock
//
//  Created by xw yin on 16/6/18.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class USUserToken: BaseObjectModel {

    var accessToken = ""
    var uuid = ""
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        
        super.mapping(map)

        accessToken <- map["accessToken"]
        uuid <- map["uuid"]

    }
    
}