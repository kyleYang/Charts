//
//  USProtfolioAPI.swift
//  NewUstock
//
//  Created by Kyle on 16/6/22.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

public enum USPortfolioAPI {

	// MARK: 指数
	case UPdateIndex
	// MARK: portfolio check
	case CheckPortfolio(version: Int)
	// MARK: Portfolio realtime
	case TickerRealTimes(tickers: [Int])
	case TickerBaseQuotes(ticker: Int)
	// MARK: portfolio sync
	// MARK: ticker sync
	case CreateTicker(portfolioId: String, tickerObjectId: String, ticerID: Int, holdings: String, sortOrder: Int, operationTime: String)
	case DeleteTicker(portfolioID: String, tickerId: Int)
	case UpdateTicker(portfolioId: String, tickerObjectId: String, ticerID: Int, holdings: String, sortOrder: Int, operationTime: String)
	case MoveTicker(tickerObjectId: String, ticerID: Int, sourcePortfolioId: String, targetPortfolioId: String, sortOrder: Int, operationTime: String)
	// MARK: 更新指数
	case UpdateWatchelist(operateTime: String, tickers: Array<Int>)

	// MARK: All Grain
	case TotalGain
	case PortfolioGain(portfolioId: String)
    case PortfolioDayGainRatio(portfolioId : String)
	case TickerPageInfo(portfolioId: String, tickerId: Int)
	case TickerTrading(portfolioId: String, tickerId: Int)

	case DeleteTickerHolding(portfolioId: String, tickerId: Int)
	// MARK: Create trade
	case DeleteTrading(portfolioId: String, tickerId: Int, tradingId: String)

}

extension USPortfolioAPI: TargetType {

	public var baseURL: NSURL {
		return NSURL(string: kHost)!
	}

	public var path: String {

		switch self {
		case .UPdateIndex:
			return urlIndexUpdate
			// MARK:portfolio check
		case .CheckPortfolio(_):
			return urlPortfolioCheck
		case .TickerRealTimes(_):
			return urlRealTimeTicke
		case .TickerBaseQuotes(let tickerId):
			return urlBaseQuotesTicker + "/\(tickerId)"
			// MARK: portfolio
			// MARK: tikcer
		case CreateTicker(let portfolioID, _, _, _, _, _):
			return String(format: urlTickerCreate, portfolioID)
		case .DeleteTicker(let portfolioID, let tickerId):
			return urlTickerDelete + "\(portfolioID)/tickers/\(tickerId)"
		case .UpdateTicker(let portfolioID, _, let tickerId, _, _, _):
			return urlTickerUpdate + "\(portfolioID)/tickers/\(tickerId)"
		case .MoveTicker(_, _, _, _, _, _):
			return urlTickerMove

		case .UpdateWatchelist(_, _):
			return urlWatchlistUpdate

			//
		case .TotalGain:
			return urlGainTotal
		case .PortfolioGain(let portfolioId):
			return urlGainPortfolio + "/\(portfolioId)/totalGain"
        case .PortfolioDayGainRatio(let portfolioId):
            return urlGainHistoryPortfolio + "/\(portfolioId)/historyGain"
		case .TickerPageInfo(let portfolioId, let tickerId):
			return urlPageinfoTicker + "/\(portfolioId)/tickers/\(tickerId)/getStockPageInfo"
		case .TickerTrading(let portfolioId, let tickerid):
			return urlTradingTicker + "/\(portfolioId)/tickers/\(tickerid)/tradings"

		case .DeleteTickerHolding(let portfolioId, let tickerId):
			return urlHoldingTickerDelete + "/\(portfolioId)tickers/\(tickerId)/tradings"
		case .DeleteTrading(let portfolioId, let tickerId, let tradingId):
			return urlTradingDelete + "/\(portfolioId)/tickers/\(tickerId)/tradings" + "/\(tradingId)"

		}
	}

	public var method: Moya.Method {

		switch self {



		case .CreateTicker(_, _, _, _, _, _):
			return .POST
		case .DeleteTicker(_, _):
			return .DELETE
		case .UpdateTicker(_, _, _, _, _, _):
			return .PUT
		case .MoveTicker(_, _, _, _, _, _):
			return .POST
		case .UpdateWatchelist(_, _):
			return .POST
		case .DeleteTickerHolding(_, _):
			return .DELETE
		case .DeleteTrading(_, _, _):
			return .DELETE
		default:
			return .GET
		}
	}

	public var parameters: [String: AnyObject]? {
		switch self {

		case .CheckPortfolio(let version):
			return ["version": version]

		case .TickerRealTimes(let tickers):
			if tickers.count != 0 {
				var values = "\(tickers[0])"
				for i in 1..<tickers.count {
					values += ","
					values += "\(tickers[i])"
				}
				return ["tickerIds": values]
			}
			return nil

		case .CreateTicker(let portfolioId, let tickerObjectId, let ticerID, let holdings, let sortOrder, let operationTime):
			return ["portfolioId": portfolioId, "id": tickerObjectId, "tickerId": ticerID, "holdings": holdings, "sortOrder": sortOrder, "operationTime": operationTime]
		case .UpdateTicker(let portfolioId, let tickerObjectId, let ticerID, let holdings, let sortOrder, let operationTime):
			return ["portfolioId": portfolioId, "id": tickerObjectId, "tickerId": ticerID, "holdings": holdings, "sortOrder": sortOrder, "operationTime": operationTime]
		case .MoveTicker(let tickerObjectId, let ticerID, let sourcePortfolioId, let targetPortfolioId, let sortOrder, let operationTime):
			return ["targetId": tickerObjectId, "tickerId": ticerID, "sourcePortfolioId": sourcePortfolioId, "targetPortfolioId": targetPortfolioId, "sortOrder": sortOrder, "operationTime": operationTime]

		case .UpdateWatchelist(let operateTime, let tickers):
			var parameters: [String: AnyObject] = [:]
			parameters["operationTime"] = operateTime
			var tickerObj: Array<Dictionary<String, Int>> = Array()
			for (_, element) in tickers.enumerate() {
				tickerObj.append(["tickerId": element])
			}
			parameters["tickers"] = tickerObj
			return parameters

		default:

			return nil
		}

	}

	public var sampleData: NSData {
		return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
	}

}