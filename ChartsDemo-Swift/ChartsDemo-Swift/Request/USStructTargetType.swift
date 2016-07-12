//
//  USStructTargetType.swift
//  NewUstock
//
//  Created by Kyle on 16/6/23.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

class USStructTargetType: NSObject {

}



public enum StructTarget: TargetType {
    case Struct(TargetType)
    
    public init(_ target: TargetType) {
        self = StructTarget.Struct(target)
    }
    
    public var path: String {
        return target.path
    }
    
    public var baseURL: NSURL {
        return target.baseURL
    }
    
    public var method: Moya.Method {
        return target.method
    }
    
    public var parameters: [String: AnyObject]? {
        return target.parameters
    }
    
    public var sampleData: NSData {
        return target.sampleData
    }
    
    public var target: TargetType {
        switch self {
        case .Struct(let t): return t
        }
    }
}