//
//  USMarketAPI.swift
//  NewUstock
//
//  Created by Kyle on 16/6/22.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

public enum USMarketAPI: USTargetRequestable {

	// MARK: Market
	case GetStocksInfo(regionIds: String, tabId: String)
	case GetSectorList(regionIds: String, pageIndex: NSInteger, pageSize: NSInteger)
	case GetSectorDetail(sectorId: Int)
	case GetCardsDetail(regionIds: String, cardId: Int)
	case GetMarketIndices(regionIds: String)
	case GetMarketRegions()
	case UpdateMarketIndices(indexIds: Array<Int>)
	case GetCurrencyInfo(regionId: NSInteger, tabId: NSInteger)
	case GetCommodityInfo(regionId: NSInteger, tabId: NSInteger)
	case GetCommodityList(groupsId: NSInteger)
	case None

	/// 请求的URL分别写在API内部
	private struct requestURL {
		// MARK: Market
		static let urlMarketBase = "/api/app/market/tabs"
		static let urlStocks = "/stocks"
		static let urlListSector = "/marketSectors"
		static let urlDetailSector = urlMarketBase + "/selectors"
		static let urlSelectedIndices = urlMarketBase + "/userIndices"
		static let urlMarketRegions = "/api/app/regions/supportedMarketRegions"
		static let urlPutIndices = urlMarketBase + "/userIndices"
		static let urlCurrency = "/foreignExchanges"
		static let urlCommodity = "/futures"
		static let urlDetailCards = "/cards"
	}

	/// 只要实现这个方法即可
	public var request: USTargetRequest {
		get {
			switch self {
			case .GetStocksInfo(let regionIds, let tabId):
				return USTargetRequest(
					path: requestURL.urlMarketBase + "/\(regionIds)" + urlStocks + "/\(tabId)",
					method: .GET
				)

			case .GetSectorList(let regionIds, _, _):
				return USTargetRequest(
					path: requestURL.urlMarketBase + "/\(regionIds)" + urlListSector,
					method: .GET
				)

			case .GetSectorDetail(let sectorId):
				return USTargetRequest(
					path: requestURL.urlDetailSector + "/\(sectorId)",
					method: .GET
				)

			case .GetMarketRegions():
				return USTargetRequest(
					path: requestURL.urlMarketRegions,
					method: .GET
				)

			case .GetMarketIndices(let regionIds):
				return USTargetRequest(
					path: requestURL.urlSelectedIndices + "/\(regionIds)",
					method: .GET
				)

			case .UpdateMarketIndices(let indexIds):
                var idsString : String = ""
                for (index,element) in indexIds.enumerate() {
                    if index == 0 {
                        idsString += "\(element)"
                    }else{
                        idsString += ",\(element)"
                    }
                }
				return USTargetRequest(
					path: requestURL.urlPutIndices + "/\(idsString)",
					method: .PUT
				)

			case .GetCurrencyInfo(let regionId, let tabId):
				return USTargetRequest(
					path: requestURL.urlMarketBase + "/\(tabId)" + urlCurrency + "/\(regionId)",
					method: .GET
				)

			case .GetCommodityInfo(let regionId, let tabId):
				return USTargetRequest(
					path: requestURL.urlMarketBase + "/\(tabId)" + urlCommodity + "/\(regionId)",
					method: .GET
				)

			case .GetCommodityList(let groupsId):
				return USTargetRequest(
					path: requestURL.urlMarketBase + urlCommodity + "/\(groupsId)",
					method: .GET
				)

			case .GetCardsDetail(let regionIds, let cardId):
				return USTargetRequest(
					path: requestURL.urlMarketBase + "/\(regionIds)" + urlDetailCards + "/\(cardId)",
					method: .GET
				)

			default:
				return USTargetRequest()
			}
		}
	}

	public var baseURL: NSURL {
		get {
			return self.request.baseURL
		}
	}

	public var path: String {
		get {
			return request.path
		}
	}

	public var method: Moya.Method {

		get {
			return request.method
		}
	}

	public var parameters: [String: AnyObject]? {
		get {
			switch self {
			case .GetSectorList(_, let pageIndex, let pageSize):
				var parameters: [String: AnyObject] = [:]
				parameters["pageIndex"] = pageIndex
				parameters["pageSize"] = pageSize

				return parameters
			default:

				return nil
			}
		}
	}

	public var sampleData: NSData {
		get {
			return request.sampleData
		}
	}

}
