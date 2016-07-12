//
//  USStructTarget.swift
//  NewUstock
//
//  Created by Kyle on 16/6/23.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

public struct USTargetRequest {
    public var baseURL:NSURL                   = NSURL(string: kHost)!
    public var path:String                     = ""
    public var method:Moya.Method              = .GET
    public var parameters:[String: AnyObject]? = nil
    public var sampleData:NSData               = NSData()

    init(
        path:String                     = "",
        method:Moya.Method              = .GET,
        parameters:[String: AnyObject]? = nil,
        sampleData:NSData               = NSData(),
        baseURL:NSURL                   = NSURL(string: kHost)!
        ) {
        self.path       = path
        self.method     = method
        self.parameters = parameters
        self.sampleData = sampleData
        self.baseURL    = baseURL
    }
}

public protocol USTargetRequestable: TargetType {

    var request:USTargetRequest { get }

}



public class USStructTarget: TargetType {

    private(set) var api:TargetType

    public init(_ api: USPortfolioAPI) {
        self.api = api
    }
    public init(_ api: USRequestAPI) {
        self.api = api
    }
    public init(_ api: USMarketAPI) {
        self.api = api
    }
    public init(_ api: USNewsAPI) {
        self.api = api
    }
    public init(_ api: USUserAPI) {
        self.api = api
    }
    public init(_ api: USTickerAPI) {
        self.api = api
    }
    public init(_ api: USFundAPI) {
        self.api = api
    }
    
    public var path: String {
        return self.api.path
    }
    
    public var baseURL: NSURL {
        return self.api.baseURL
    }
    
    public var method: Moya.Method {
        return self.api.method
    }
    
    public var parameters: [String: AnyObject]? {
        return self.api.parameters
    }
    
    public var sampleData: NSData {
        return self.api.sampleData
    }
    
}
