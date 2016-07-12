//
//  USUserAPI.swift
//  NewUstock
//
//  Created by Kyle on 16/6/22.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

public enum USUserAPI {
    
    // MARK: User Center
    case SearchRegisterableRegions
    case SendVerifyCode(account: String, accountType: Int, codeType: Int)
    case CheckVerifyCode(account: String, accountType: Int, verificationCode: String, codeType: Int)
    case RegisterAccount(account: String, avatarUrl: String, accountType: Int, pwd: String, nickName: String, verificationCode: String, deviceId: String, regionId: Int)
    case Login(account: String, accountType: Int, pwd: String, deviceId: String)
    case Logout(deviceId: String)
    case GetUserInfo
    case ResetPassword(account: String, accountType: Int, pwd: String, verificationCode: String)
    case MemoList
    case MemoDelete(memoID: Int)
    case None
}

extension USUserAPI: TargetType {
    
    public var baseURL: NSURL {
        return NSURL(string: kHost)!
    }
    
    public var path: String {
        
        switch self {
            
        case .SearchRegisterableRegions:
            return urlRegionsRegisterableSearch
            
        case .SendVerifyCode(_, _, _):
            return urlVerificationCodeSend
            
        case .CheckVerifyCode(_, _, _, _):
            return urlVerficationCodeCheck
            
        case .RegisterAccount(_, _, _, _, _, _, _, _):
            return urlAccountRegister
            
        case .Login(_, _, _, _):
            return urlLogin
            
        case .Logout(_):
            return urlLogout
            
        case .GetUserInfo:
            return urlUserInfoGet
            
        case .ResetPassword(_, _, _, _):
            return urlPasswordReset

        case .MemoList(_):
            return urlUserMemoList

        case .MemoDelete(let tickerID):
            return String(format: urlUserMemoDelete, tickerID)
            
        default:
            return kPortfolioHomeURL
        }
        
    }
    
    public var method: Moya.Method {
        
        switch self {
        case .RegisterAccount(_, _, _, _, _, _, _, _):
            return .POST
        case .ResetPassword(_, _, _, _):
            return .PUT
        case .MemoDelete(_):
            return .DELETE
        default:
            return .GET
        }
    }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        // MARK: UserCenter
        case .SendVerifyCode(let account, let accountType, let codeType):
            var parameters: [String: AnyObject] = [:]
            parameters["account"] = account
            parameters["accountType"] = accountType
            parameters["codeType"] = codeType
            
            return parameters
            
        case .CheckVerifyCode(let account, let accountType, let verificationCode, let codeType):
            var parameters: [String: AnyObject] = [:]
            parameters["account"] = account
            parameters["accountType"] = accountType
            parameters["verificationCode"] = verificationCode
            parameters["codeType"] = codeType
            
            return parameters
            
        case .RegisterAccount(let account, let avatarUrl, let accountType, let pwd, let nickName, let verificationCode, let deviceId, let regionId):
            
            var parameters: [String: AnyObject] = [:]
            parameters["account"] = account
            parameters["avatarUrl"] = avatarUrl
            parameters["accountType"] = accountType
            parameters["pwd"] = pwd
            parameters["nickName"] = nickName
            parameters["verificationCode"] = verificationCode
            parameters["deviceId"] = deviceId
            parameters["regionId"] = regionId
            
            return parameters
            
        case .Login(let account, let accountType, let pwd, let deviceId):
            var parameters: [String: AnyObject] = [:]
            parameters["account"] = account
            parameters["accountType"] = accountType
            parameters["pwd"] = pwd
            parameters["deviceId"] = deviceId
            
            return parameters
            
        case .Logout(let deviceId):
            var parameters: [String: AnyObject] = [:]
            parameters["deviceId"] = deviceId
            
            return parameters
            
        case .ResetPassword(let account, let accountType, let pwd, let verificationCode):
            var parameters: [String: AnyObject] = [:]
            parameters["account"] = account
            parameters["accountType"] = accountType
            parameters["pwd"] = pwd
            parameters["verificationCode"] = verificationCode
            
            return parameters

        case .MemoList:
            return nil
            
        default:
            
            return nil
        }
    }
    
    public var sampleData: NSData {
        return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
}
