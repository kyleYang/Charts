//
//  USConstant.swift
//  ChartsDemo-Swift
//
//  Created by Kyle on 16/7/12.
//  Copyright © 2016年 xiaoluuu. All rights reserved.
//

import UIKit

class USConstant: NSObject {

}

private let UStockErrorDomain = "webull"
//MARK: 错误种类
public enum USError: ErrorType {
    case Unknow
    case NetworkError(Int, String)
    case ResponseValidate(String, String)
}

public enum USErrorCode: Int {
    case Unknow = 0
    case NetworkError
    case ResponseValidate
}

public extension USError {
    
    var usError: NSError {
        switch self {
        case .ResponseValidate(_, let String):
            return NSError(domain: UStockErrorDomain, code: USErrorCode.ResponseValidate.rawValue, userInfo: ["msg": String])
        case .NetworkError(_, let String):
            return NSError(domain: UStockErrorDomain, code: USErrorCode.NetworkError.rawValue, userInfo: ["msg": String])
        default:
            return NSError(domain: UStockErrorDomain, code: USErrorCode.ResponseValidate.rawValue, userInfo: ["msg": "Unkown Error"])
        }
    }
    
}
