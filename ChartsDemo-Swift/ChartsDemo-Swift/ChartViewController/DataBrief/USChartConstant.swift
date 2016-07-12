//
//  USChartConstant.swift
//  NewUstock
//
//  Created by Kyle on 16/7/11.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit

public enum USTickerChartRegion : Int {
    case CN = 1
    case HK = 2
    case CA = 3
    case UK = 4
    case JP = 5
    case US = 6
    case KR = 7
    case YI = 8
}

public enum USTickerChartType {
    case Brief
    case Detail
}


public enum USTickerKCartMinuteType {
    case One //default
    case Five
    case Fifteen
    case Thirty
    case Sixty
}

public enum USTickerKChartBriefType {
    case Hour
    case FiveDay
    case Days
    case Week
    case Month
    case Minutes(type : USTickerKCartMinuteType)
}

