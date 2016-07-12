//
//  USMarketFund.swift
//  NewUstock
//
//  Created by Eason Lee on 16/7/7.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Foundation
import ObjectMapper

/// 基金行情
class USMarketFund: BaseObjectModel {
    var label: String?
    var name: String?
    var symbol: String?
    var tag: String?
    var tickerId: Int?
    var change: Double?
    var changeRatio: Double?
    var changeRatioType: Int?
    var feeDescription: String?
    var feeInPercent: String?
    var netValue: Double?
    var price: String?
    var ratingValue: Double?
    var region: String?
    var regionIsoCode: String?
    var saleStatus: Int?
    var secType: String?
    var status: Int?
    var subscribeExpireDate: String?
    var subscribeStartDate: String?
    var subscriptionMinimumPrice: String?

    var ratingAgencyName: String?

    override func mapping(map: Map) {
        super.mapping(map)
        label <- map["label"]
        name <- map["name"]
        symbol <- map["symbol"]
        tag <- map["tag"]
        tickerId <- map["tickerId"]
        change <- map["change"]
        changeRatio <- map["changeRatio"]
        changeRatioType <- map["changeRatioType"]
        feeDescription <- map["feeDescription"]
        feeInPercent <- map["feeInPercent"]
        netValue <- map["netValue"]
        price <- map["price"]
        ratingValue <- map["ratingValue"]
        region <- map["region"]
        regionIsoCode <- map["regionIsoCode"]
        saleStatus <- map["saleStatus"]
        secType <- map["secType"]
        status <- map["status"]
        subscribeExpireDate <- map["subscribeExpireDate"]
        subscribeStartDate <- map["subscribeStartDate"]
        subscriptionMinimumPrice <- map["subscriptionMinimumPrice"]

        ratingAgencyName <- map["ratingAgencyName"]
    }
}
