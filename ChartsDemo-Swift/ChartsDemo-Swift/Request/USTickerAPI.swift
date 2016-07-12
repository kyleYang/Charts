//
//  USTickerAPI.swift
//  NewUstock
//
//  Created by Kyle on 16/6/22.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

let USTickerAPIRequestPageSize = 20


public enum TickerMinutesType : String {
    case Day = "m1"
    case DayFive = "m5"
}

public enum TickerKDataType : String {
    case Day = "d"
    case Week = "w"
    case Month = "m"
    case MinuteOne = "m1"
    case MinuteFive = "m5"
    case MinuteFifteen = "m15"
    case MinuteThirty = "m30"
    case MinuteSixty  = "m60"
}

public enum USTickerAPI: USTargetRequestable {

    /// 实时行情
    case Realtime(tickerID: Int)
    case TickerMinutes(tickerID:Int,minuteType : TickerMinutesType,startTime : NSDate?,endTime : NSDate?)
    case TickerKDatas(tickerID:Int,dataType : TickerKDataType,time : NSDate?,count : Int?) //K线事实行情
    case Info(tickerID: Int)
    case Favor(tickerID: Int, operation: String)

    case BoardNews(tickerID: Int, lastID: String)
    case BoardBulletin(tickerID: Int, lastID: String)
    case BoardCapital(tickerID: Int)
    case BoardSummary(tickerID: Int)
    case BoardMemo(tickerID: Int)
    case BoardFinance(tickerID: Int)

    case MemoUpdate(tickerID: Int, content: String)
    

    case None //占位置

    /// 请求的URL分别写在API内部
    private struct requestURL {
        static let realtime      = "/api/data/tickerRealTimes/%d"
        static let tickerMinutes = "/api/data/tickerMinutes/%d"
        static let tickerKDatas  = "/api/data/tickerKDatas/%d"
        static let info          = "/api/app/ticker/%d"
        static let favor         = "/api/app/ticker/%d/trend"
        static let boardNews     = "/api/app/ticker/%d/news"
        static let boardBulletin = "/api/app/ticker/%d/bulletins"
        static let boardCapital  = "/api/data/tickerCapitals/%d"
        static let boardSummary  = "/api/app/stock/%d/brief"
        static let boardMemo     = "/api/user/memos/all"
        static let boardFinance  = "/api/app/stock/%d/statements"

        static let memoUpdate    = "/api/user/memos"
    }

    /// 只要实现这个方法即可
    public var request: USTargetRequest {
        get {
            switch self {
            case .Realtime(let tickerID):
                return USTargetRequest(
                    path: String(format: requestURL.realtime, tickerID)
                )
            case .TickerMinutes(let tickerID, let minuteType, let startTime, let endTime):
                var parameters : Dictionary<String,AnyObject> = [:]
                parameters["minuteType"] = minuteType.rawValue
                if let _ = startTime {
                    parameters["startTimestamp"] = round(startTime!.timeIntervalSince1970) //不需要到毫秒
                }
                if let _ =  endTime {
                    parameters["endTimestamp"] = round(endTime!.timeIntervalSince1970)
                }
                return USTargetRequest(
                    path: String(format: requestURL.tickerMinutes, tickerID),
                    parameters : parameters
                )
            case .TickerKDatas(let tickerID, let dataType, let time,let count):
                var parameters : Dictionary<String,AnyObject> = [:]
                parameters["kDataType"] = dataType.rawValue
                if let _ = time {
                   parameters["timestamp"] = round(time!.timeIntervalSince1970)
                    //不需要到毫秒
                }
                if let _ = count {
                    parameters["count"] = count
                }
                
                return USTargetRequest(
                    path: String(format: requestURL.tickerKDatas, tickerID),
                    parameters : parameters
                )

            case .Info(let tickerID):
                return USTargetRequest(
                    path: String(format: requestURL.info, tickerID)
                )
            case .Favor(let tickerID, let operation):
                return USTargetRequest(
                    path: String(format: requestURL.favor, tickerID),
                    parameters: [
                        "id" : String(tickerID),
                        "operation" : operation
                    ]
                )
            case .BoardNews(let tickerID, let lastID):
                return USTargetRequest(
                    path: String(format: requestURL.boardNews, tickerID),
                    parameters: [
                        "currentNewsId" : lastID,
                        "pageSize" : USTickerAPIRequestPageSize
                    ]
                )
            case .BoardBulletin(let tickerID, let lastID):
                return USTargetRequest(
                    path: String(format: requestURL.boardBulletin, tickerID),
                    parameters: [
                        "currentBulletinId" : lastID,
                        "bulletinNumber" : USTickerAPIRequestPageSize
                    ]
                )
            case .BoardCapital(let tickerID):
                return USTargetRequest(
                    path: String(format: requestURL.boardCapital, tickerID)
                )
            case .BoardSummary(let tickerID):
                return USTargetRequest(
                    path: String(format: requestURL.boardSummary, tickerID)
                ) 
            case .BoardMemo(let tickerID):
                return USTargetRequest(
                    path: String(format: requestURL.boardMemo),
                    parameters: [
                        "tickerId" : tickerID
                    ]
                )
            case .BoardFinance(let tickerID):
                return USTargetRequest(
                    path: String(format: requestURL.boardFinance, tickerID)
                )
            case .MemoUpdate(let tickerID, let content):
                return USTargetRequest(
                    path: String(format: requestURL.memoUpdate),
                    parameters: [
                        "tickerId" : tickerID,
                        "content" : content
                    ],
                    method: .POST
                )
            default:
                return USTargetRequest()
            }
        }
    }

    public var baseURL:NSURL {
        get {
            return self.request.baseURL
        }
    }

    public var path:String {
        get {
            return request.path
        }
    }

    public var method:Moya.Method {
        get {
            return request.method
        }
    }

    public var parameters:[String: AnyObject]? {

        get {
            return request.parameters
        }
    }

    public var sampleData:NSData {

        get {
            return request.sampleData
        }
    }
}
