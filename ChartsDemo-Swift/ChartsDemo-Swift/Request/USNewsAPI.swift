//
//  USNewsAPI.swift
//  NewUstock
//
//  Created by Kyle on 16/6/22.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

public enum USNewsAPI {

	// MARK: News  Interest
    case NewsPage(newsID: Int)
	case RecommendNews(regionIds: String) // 推荐
	case OptionalNews(tickerIds: String) // 自选
	case NewsLabel(newsLabelId: Int) // 标签
	case FinanceNews(regionIds: String, dateStr: String) /// 某时段财经事件
	case FinanceSomeDayNews(regionIds: String, dateStr: String) /// 某天的财经新闻
	case None
}

extension USNewsAPI: TargetType {

	public var baseURL: NSURL {
		return NSURL(string: kHost)!
	}

	public var path: String {

		switch self {
			// MARK MARKET
        case .NewsPage(let newsID):
            return urlNewsPage + "/\(newsID)"
		case .RecommendNews(let regionIds):
			return urlNewsRecommend + "/\(regionIds)"
		case .OptionalNews(_):
			return urlNewsOptional
        case .NewsLabel(let newsLabelId):
            return urlNewsLabel + "/\(newsLabelId)"
		case .FinanceNews(let regionIds, let dateStr):
			return urlNewsBase + "/" + regionIds + urlNewsFinance + "/" + dateStr
		case .FinanceSomeDayNews(let regionIds, let dateStr):
			return urlNewsBase + "/" + regionIds + urlNewsFinanceSomeday + "/" + dateStr
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
        case .OptionalNews(let tickerIds):
            var parameters: [String: AnyObject] = [:]
            parameters["tickerIds"] = tickerIds
            
            return parameters
		default:

			return nil
		}

	}

	public var sampleData: NSData {
		return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
	}

}
