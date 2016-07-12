//
//  USTickerKChartBriefView.swift
//  NewUstock
//
//  Created by Kyle on 16/7/6.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit
import RxSwift
import HMSegmentedControl
import SwiftDate
import SnapKit

public class USTickerKChartBriefView: UIView {

    public var tickerId : Int = 0{
        didSet{
            if tickerId != oldValue {
                self.queryData()
            }
        }
    }
    
    private var _type : USTickerKChartBriefType = .Hour
    private var type : USTickerKChartBriefType {
        get{
            return _type
        }set{
            if _type == newValue {
              
            }else{
                _type = newValue
                self.queryData()
            }
        }
    }
    
    private var minuteDataModel : TickerMinuteModel?{
        didSet{
            self.upateView()
        }
    }
    private var kDatasModel : TickerKDatasModel? {
        didSet{
            self.upateView()
        }
    }
    
    var minDate : NSDate! = NSDate()
    var maxDate : NSDate! = NSDate()
    
    private var segmentControl : HMSegmentedControl = HMSegmentedControl(frame: CGRectZero)
    private var chartView : LineChartView  = LineChartView()
    private var candleView : CandleStickChartView = CandleStickChartView()
    
    convenience init(){
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    
    //
    private func setup(){
        
        let titles : [AnyObject] = ["分时","5日","日K","周K","月K","分钟"]
        self.segmentControl.sectionTitles = titles;
        self.segmentControl.indexChangeBlock = {(index) in
            if index == 0 {
                self.type = .Hour
            }else if index == 1{
                self.type = .FiveDay
            }else if index == 2 {
                self.type = .Days
            }else if index == 3 {
                self.type = .Week
            }else if index == 4 {
                self.type = .Month
            }else {
                self.type = .Minutes(type : .One)
            }
        }
        
        ({(view : HMSegmentedControl) in
            self.addSubview(view)
            }(self.segmentControl))
        
        ({(view : BarLineChartViewBase) in
            view.delegate = self
            view.dragEnabled = false
            view.setScaleEnabled(false)
            view.pinchZoomEnabled = false
            view.drawGridBackgroundEnabled = true
            view.rightAxis.enabled = false;
            self.addSubview(view)
            }(self.chartView))
        
        ({(view : BarLineChartViewBase) in
            view.delegate = self
            view.dragEnabled = false
            view.setScaleEnabled(false)
            view.pinchZoomEnabled = false
            view.drawGridBackgroundEnabled = true
            view.rightAxis.enabled = false;
            view.hidden = true
            self.addSubview(view)
            }(self.candleView))

        self.segmentControl.snp_makeConstraints { (make) in
            make.leading.equalTo(self.snp_leading).offset(10)
            make.trailing.equalTo(self.snp_trailing).offset(-10)
            make.bottom.equalTo(self.snp_bottom).offset(0)
            make.height.equalTo(30)
        }
        
        self.chartView.snp_makeConstraints { (make) in
            make.leading.equalTo(self.segmentControl.snp_leading)
            make.trailing.equalTo(self.segmentControl.snp_trailing)
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.segmentControl.snp_top).offset(4)
        }
        
        self.candleView.snp_makeConstraints { (make) in
            make.leading.equalTo(self.chartView.snp_leading)
            make.trailing.equalTo(self.chartView.snp_trailing)
            make.top.equalTo(self.chartView.snp_top)
            make.bottom.equalTo(self.chartView.snp_bottom)
        }
    }
}

extension USTickerKChartBriefView : ChartViewDelegate {
    
}


//MARK: UI update
extension USTickerKChartBriefView {
    
    private func upateView(){
        cleanOldView()
        updateYAxis()
        
        switch self.type {
        case .Hour:
            self.chartView.hidden = false
            self.candleView.hidden = true
            self.setMinuteData()
        case .FiveDay:
            self.chartView.hidden = false
            self.candleView.hidden = true
            self.setMinuteData()
        default:
            self.chartView.hidden = true
            self.candleView.hidden = false
            self.setKDatas()
        }
    }
    
    
    private func cleanOldView() {
        
        
    }
    
    
    private func updateYAxis() {
        
        if let _ = self.minuteDataModel {
            
            let yAxis = chartView.leftAxis
            yAxis.labelPosition = .InsideChart
        }
        
    }
    
    private func setMinuteData(){
        
        let xVals = USChartUtil.getXAxis(regionId: .CN, chartType: .Brief, dataType: self.type)
        var yVals : Array<ChartDataEntry> = []
        for (index,element) in self.minuteDataModel!.tickerMinuteList.enumerate() {
            let data = ChartDataEntry(value: Double(element.close), xIndex: index)
            yVals.append(data)
        }
        
        let set = LineChartDataSet(yVals: yVals, label: nil)
        set.lineWidth = 1
        set.drawValuesEnabled = false
        set.setColor(UIColor.blackColor())
        set.circleRadius = 0
        
        let gradientColors = [ChartColorTemplates.colorFromString("#00000055").CGColor,ChartColorTemplates.colorFromString("#00000000").CGColor]
        let gradient = CGGradientCreateWithColors(nil, gradientColors, nil)
        
        
        set.fillAlpha = 1.0;
        set.fill = ChartFill.fillWithLinearGradient(gradient!, angle: 90)
        set.drawFilledEnabled = true;
        
        
        if chartView.data?.dataSets.count > 0 {
            chartView.data = nil
        }
        
        let date = LineChartData(xVals: xVals, dataSets:[set])
        chartView.xAxis.setLabelsToSkip(0)
        chartView.xAxis.drawGirdOnlyLabel = true
        chartView.xAxis.labelPosition = .BottomInside
        chartView.data = date
    
        
    }
    
    private func setKDatas(){
        
        var xVals : Array<String?> = []
        var yVals : Array<ChartDataEntry> = []
        
        for (index,element) in self.kDatasModel!.tickerKDataList.enumerate() {
            if element.tradeTime.minute == 0 || element.tradeTime.minute == 30 {
                xVals.append(element.tradeTime.hourMinuteFormat())
            }else{
                xVals.append(nil)
            }
            let data = CandleChartDataEntry(xIndex: index, shadowH: Double(element.noneKData.high), shadowL:  Double(element.noneKData.low), open: Double(element.noneKData.open), close: Double(element.noneKData.close))
            yVals.append(data)
            
        }
        
        let set = CandleChartDataSet(yVals: yVals, label: nil)
        set.shadowWidth = 0.7
        set.drawValuesEnabled = false
        set.decreasingColor = UIColor.redColor()
        set.decreasingFilled = true
        set.increasingColor = UIColor.greenColor()
        set.increasingFilled = true
        set.setColor(UIColor.blackColor())
        
        
        if chartView.data?.dataSets.count > 0 {
            chartView.data = nil
        }
        
        let date = CandleChartData(xVals: xVals, dataSets:[set])
        candleView.data = date

        
        
    }

    
    
}

//MARK: network
extension USTickerKChartBriefView {
    
    private func queryData(){
        switch self.type {
        case .Hour:
            self.queryTickerMinutes()
        case .FiveDay:
            self.queryTickerMinutes()
        default:
            self.queryTickerKDatas()
        }
    }
    
    //查询分时图
    private func queryTickerMinutes() {
        var minutesType : TickerMinutesType = .Day
        var endTime : NSDate? = nil
        switch self.type {
        case .FiveDay:
            minutesType = .DayFive
//            endTime = 5.days.agoFromDate(NSDate()).startOf(.Day)
        default:
            break
        }
        
        let result : Observable<TickerMinuteModel>  = USProvider.requestObjectMapper(USStructTarget(USTickerAPI.TickerMinutes(tickerID: self.tickerId, minuteType: minutesType, startTime: nil, endTime: endTime)))
        result.subscribe {[unowned self] (event) in
            switch event {
            case .Next(let model) :
                self.minuteDataModel = model
            default:
                break
            }
        }.addDisposableTo(rx_disposeBag)
    }
    
    //查询K线数据
    private func queryTickerKDatas() {
        var dataType : TickerKDataType = .Day
        var endTime : NSDate? = nil
        switch self.type {
        case .Days :
            dataType = .Day
        case .Week:
            dataType = .Week
        case .Month:
            dataType = .Month
        case .Minutes(let minute):
            switch minute {
            case .One:
                dataType = .MinuteOne
            case .Five:
                dataType = .MinuteFive
            case .Fifteen:
                dataType = .MinuteFifteen
            case .Thirty:
                dataType = .MinuteThirty
            case .Sixty :
                dataType = .MinuteSixty
            default:
                dataType = .MinuteOne
            }
        default:
            dataType = .Day
            break
        }
        
        let result : Observable<TickerKDatasModel>  = USProvider.requestObjectMapper(USStructTarget(USTickerAPI.TickerKDatas(tickerID: self.tickerId, dataType: dataType, time: nil, count: nil)))
        result.subscribe {[unowned self] (event) in
            switch event {
            case .Next(let model) :
                self.kDatasModel = model
            default:
                break
            }
            }.addDisposableTo(rx_disposeBag)
    }
    
    
    
}


