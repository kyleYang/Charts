//
//  IndexTicker.swift
//  NewUstock
//
//  Created by Kyle on 16/6/18.
//  Copyright © 2016年 ustock. All rights reserved.
//

import ObjectMapper

class IndexTicker: BaseObjectModel {

	var tickerId: Int = 0
	var symbol: String = ""
	var name: String! 
	var price: Float!
	var diffPrice: Float!
	var diffPricePercent: Float! 
	var countryISOCode: String = ""
	var changeRatio: String!
	var change: String!

	required init?(_ map: Map) {
		super.init(map)
	}

	override func mapping(map: Map) {
		super.mapping(map)
		tickerId <- map["tickerId"]
		symbol <- map["symbol"]
		name <- map["name"]
		price <- map["price"]
		diffPrice <- map["diffPrice"]
		diffPricePercent <- map["diffPricePercent"]
		changeRatio <- map["changeRatio"]
		change <- map["change"]
	}

}
