//
//  USFundAPI.swift
//  NewUstock
//
//  Created by Eason Lee on 16/6/28.
//  Copyright © 2016年 ustock. All rights reserved.
//

import Moya

/**
 基金相关请求接口
 */
public enum USFundAPI {

    /**
     *  市场－基金 首页
     */
    case MarketFundHomePage(regionId: Int)

    /**
     *  首页新闻列表
     *
     *  @param String 区域id字符串： 1,2,3
     *  @param Int    当前最新的新闻id
     *  @param Int    每次拉去的新闻数量
     *
     *  @return None
     */
    case MarketFundNews(regionIds: String, currentNewsId: Int, pageSize: Int)

    // case HotThemeList(regionId: Int, pageIndex)

    /**
     *  单个基金专题详情
     *
     *  @param Int 专题ID
     *
     *  @return None
     */
    case TopicDetail(topicId: Int)

    /**
     *  基金专题列表
     *
     *  @param Int 地区ID
     *  @param Int 分页码
     *  @param Int 分页大小
     *
     *  @return None
     */
    case TopicList(regionId: Int, pageIndex: Int, pageSize: Int)

    /**
     *  根据地区id获取收益排行顶部tabl
     *
     *  @param Int 地区id
     *
     *  @return None
     */
    case IncomeRankTabs(regionId: Int)

    /**
     *  基金收益排行
     *
     *  @param Int regionId 区域ID
     *  @param Int fundType 基金类型
     *  @param Int changeRatioType 基金涨跌幅类型
     *  @param Int pageIndex 页码
     *  @param Int pageSize 每页数据量
     *
     *  @return None
     */
    case IncomeRank(
        regionId: Int,
        fundType: Int,
        changeRatioType: Int,
        pageIndex: Int,
        pageSize: Int)

    /// 基金筛选下拉数据
    case FundFilterSpiners

    /**
     *  基金筛选
     *
     *  @param Int regionId 区域ID
     *  @param Int fundType 基金类型
     *  @param Int earnningType 收益类型（涨跌幅类型）
     *  @param Int low  收益区间
     *  @param Int high 收益区间
     *  @param Int ratingAgenciesId  机构评级
     *  @param Int star  星级
     *  @param Int count  当前获取的数据量
     *  @param Int pageSize  页大小
     *
     *  @return None
     */
    case FundFilter(
        regionId: Int,
        fundType: Int,
        earnningType: Int,
        low: Float,
        high: Float,
        ratingAgenciesId: Int,
        star: Int,
        count: Int,
        pageSize: Int)

    /**
     *  热门主题列表
     *
     *  @param Int regionId
     *  @param Int pageIndex
     *  @param Int pageSize
     *
     *  @return None
     */
    case HotThemeList(regionId: Int, pageIndex: Int, pageSize: Int)

    /**
     *  热门主题详情
     *
     *  @param Int themeId 主题ID
     *  @param Int changeRatioType 涨跌幅类型
     *
     *  @return None
     */
    case HotThmeDetail(themeId: Int, changeRatioType: Int)

    /**
     *  新发基金列表
     *
     *  @param Int saleStatus 基金发售状态
     *
     *  基金发售状态: 1、即将发售,2、发售中,3、发售结束,4、所有类型
     *
     *  @return None
     */
    case NewIssue(saleStatus: Int)

    case None
}

extension USFundAPI: TargetType {

    public var baseURL: NSURL {
        return NSURL(string: kHost)!
    }

    public var path: String {

        switch self {

        case .MarketFundHomePage(let regionId):
            return urlMarketBase + "/2/funds/\(regionId)"

        case .MarketFundNews(let regionIds, _, _):
            return urlMarketBase + "/2/" + regionIds + "/news"

        case .TopicDetail(let topicId):
            return urlMarketBase + "/funds/featuredFundTopic/\(topicId)"

        case .TopicList(let regionId, _, _):
            return urlMarketBase + "/funds/featuredFundTopics/\(regionId)"

        case .IncomeRankTabs(let regionId):
            return urlMarketBase + "/funds/revenueRank/tab/\(regionId)"

        case .IncomeRank(_, _, _, _, _):
            return urlMarketBase + "/funds/revenueRank"

        case .FundFilterSpiners:
            return urlMarketBase + "/funds/spinners"

        case .FundFilter:
            return urlMarketBase + "/funds/selection"

        case .HotThemeList(let regionId, _, _):
            return urlMarketBase + "/funds/themes/\(regionId)"

        case .HotThmeDetail(let themeId, let changeRatioType):
            return urlMarketBase + "/funds/themeInfo/\(themeId)/\(changeRatioType)"

        case .NewIssue(let saleStatus):
            return urlMarketBase + "/funds/getMarketNewFundList/\(saleStatus)"
            
        default:
            return ""
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

        case .MarketFundNews(_, let id, let pageSize):
            var dict = ["pageSize": pageSize]
            if id > 0 { dict["currentNewsId"] = id }
            return dict

        case .IncomeRank(let regionId, let fundType, let changeRatioType, let pageIndex, let pageSize):
            let dict = ["regionId": regionId,
                        "fundType": fundType,
                        "changeRatioType": changeRatioType,
                        "pageIndex": pageIndex,
                        "pageSize": pageSize]
            return dict

        case .TopicList(_, let pageIndex, let pageSize):
            let dict = ["pageIndex": pageIndex,
                        "pageSize": pageSize]
            return dict

        case .FundFilter(let regionId, let fundType, let earnningType, let low, let high, let ratingAgenciesId, let star, let count, let pageSize):
            let dict: [String : AnyObject] = [
                "regionId": regionId,
//                "fundType": fundType,
//                        "earnningType": earnningType,
//                        "low": low,
//                        "high": high,
//                "ratingAgenciesId": ratingAgenciesId,
//                "star": star,
                "count": count,
                "pageSize": pageSize]
            return dict

        case .HotThemeList(_, let pageIndex, let pageSize):
            let dict = ["pageIndex": pageIndex,
                        "pageSize": pageSize]
            return dict

        default:
            return nil
        }

    }

    public var sampleData: NSData {
        return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
    }

}
