//
//  USUserInfo.swift
//  NewUstock
//
//  Created by xw yin on 16/6/18.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

public class USUserInfo: BaseObjectModel {
    
    var avatarUrl = ""
    var birthYear:Int = 0
    var email = ""
    var industryId:Int = 0
    var nickName = ""
    var personalSignature = ""
    var phone = ""
    var regionId:Int = 0
    var sex:Int = 0
    
    required public init?(_ map: Map) {
        super.init(map)
    }
    
    override public func mapping(map: Map) {
        
        super.mapping(map)
        
        avatarUrl <- map["avatarUrl"]
        birthYear <- map["birthYear"]
        email <- map["email"]
        industryId <- map["industryId"]
        nickName <- map["nickName"]
        personalSignature <- map["nickName"]
        phone <- map["phone"]
        regionId <- map["regionId"]
        sex <- map["regionId"]
        
    }
    
}
