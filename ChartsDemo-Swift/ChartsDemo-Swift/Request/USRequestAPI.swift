//
//  USRequestAPI.swift
//  NewUstock
//
//  Created by Kyle on 16/5/17.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

//{
//    "amount": 0,
//    "commission": 0,
//    "commissionRatio": 0,
//    "date": "2016-05-07T19:45:29+0800",
//    "operationTime": "2016-05-07T19:45:29+0800",
//    "portfolioId": "string",
//    "price": 0,
//    "tickerId": 0,
//    "tradingId": "string",
//    "type": 0,
//    "updateTime": "2016-05-07T19:45:29+0800"
//}

public enum USRequestAPI {


    // MARK: Currency
    case UpdateCurrencies
    case GetForeignExchangeRate
    
	// MARK: News  Interest
	case getInterestNews(regionIds: String, currentNewsId: String, pageSize: String)
	case SearchTikcer(type: String, keyword: String, hasNumber: Int?, pageNumber: Int?)
}

extension USRequestAPI: TargetType {

	public var baseURL: NSURL {
		return NSURL(string: kHost)!
	}

	public var path: String {

		switch self {
			// MARK MARKET
        // MARK: Currency
        case .UpdateCurrencies:
            return urlUpdateCurrencies
        case .GetForeignExchangeRate:
            return urlGetForeignExchangeRate
        case .SearchTikcer(_, let keyword, _, _):
            keyword
            return urlTickerSearch

		default:
			return kPortfolioHomeURL
		}

	}

	public var method: Moya.Method {

		switch self {
		default:
			return .GET
		}
	}

	public var parameters: [String: AnyObject]? {
		switch self {
			// MARK: Search
		case .SearchTikcer(let type, let key, let hasNumber, let pageNumber):

			var parameters: [String: AnyObject] = [:]
			parameters["keys"] = key
			parameters["tickerType"] = type

			if let number = hasNumber {
				parameters["hasNumber"] = number

			}
			if let number = pageNumber {
				parameters["queryNumber"] = number

			}
			return parameters

			// MARK: UserCenter
		default:

			return nil
		}

	}

	public var sampleData: NSData {
		return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
	}

}
