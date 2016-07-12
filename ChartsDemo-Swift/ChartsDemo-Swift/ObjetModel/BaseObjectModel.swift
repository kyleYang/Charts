//
//  BaseOjectModel.swift
//  NewUstock
//
//  Created by Kyle on 16/5/24.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

public class BaseObjectModel: NSObject, Mappable {
    
    override init() {
        super.init()
    }
    
    public required init?(_ map: Map){
        
    }
    
    public func mapping(map: Map) {
        
    }
    

}
