//
//  USAPI.swift
//  NewUstock
//
//  Created by Kyle on 16/5/17.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit

let kRequestTimeoutInterval = 10

// UStock Api Constant file
#if DEBUG

	 //远程测试环境
//    let kHost = "http://192.168.40.203:8000/webull-app-center" //本地测试环境

#else

	let kHost = "http://54.222.247.125:8000/webull-app-center"

#endif

let kPortfolioHomeURL = ""

let urlUpdateCurrencies = "api/app/base/currencies"
let urlGetForeignExchangeRate = "/api/app/market/tabs/foreignExchangeRate"

let urlIndexUpdate = "api/app/market/tabs/indices"

let urlPortfolioCheck = "/api/portfolios/check"

let urlRealTimeTicke = "/api/data/tickerRealTimes"
let urlBaseQuotesTicker = "/api/data/tickerBaseQuotes"

let urlPortfolioCreate = "/api/portfolios"
let urlPortfolioDelete = "/api/portfolios/"
let urlPortfolioUpdate = "/api/portfolios/"
let urlTradingCreate = "/api/portfolios"
let urlTradingDelete = "/api/portfolios"

let urlTickerCreate = "/api/portfolios/%@/tickers"
let urlTickerDelete = "/api/portfolios/"
let urlTickerUpdate = "/api/portfolios/"
let urlTickerMove = "/api/portfolios/moveTicker"
let urlTradingTicker = "/api/portfolios"
let urlHoldingTickerDelete = "/api/portfolios"

let urlWatchlistUpdate = "/api/watchlist/indices/batchUpdateIndex"

let urlGainTotal = "/api/portfolios/totalGain"
let urlGainPortfolio = "/api/portfolios"
let urlGainHistoryPortfolio = "/api/portfolios"
let urlPageinfoTicker = "/api/portfolios"

//MARK: Market
let urlMarketBase = "/api/app/market/tabs"
let urlStocks = "/stocks"
let urlListSector = "/marketSectors"
let urlDetailSector = urlMarketBase + "/selectors"
let urlCurrency = "/foreignExchanges"
let urlCommodity = "/futures"
let urlDetailCards = "/cards"

//MARK: News
let urlNewsPage = "/page/app/news"
let urlNewsBase = "/api/app/news"
let urlNewsRecommend = urlNewsBase + "/regionid"
let urlNewsLabel = urlNewsBase + "/newsLabel"
let urlNewsOptional = urlNewsBase + "/portfolio/all"
let urlNewsFinance = "/economicCalendars/dates"
let urlNewsFinanceSomeday = "/economicCalendars"

//MARK: Search
let urlTickerSearch = "/api/app/search/tickers"

//MARK: User Center
let urlRegionsRegisterableSearch = "/api/app/regions/registrableRegions"
let urlVerificationCodeSend      = "/api/verificationCode/sendCode"
let urlVerficationCodeCheck      = "/api/verificationCode/checkCode"
let urlAvatarUpload              = "/api/user/uploadAvatar"
let urlAccountRegister           = "/api/user/register/account"
let urlLogin                     = "/api/user/login/account"
let urlLogout                    = "/api/user/login/logout"
let urlUserInfoGet               = "/api/user"
let urlPasswordReset             = "/api/user/login/resetPwd"
let urlUserMemoList              = "/api/user/memos/all"
let urlUserMemoDelete            = "/api/user/memos/%d"
