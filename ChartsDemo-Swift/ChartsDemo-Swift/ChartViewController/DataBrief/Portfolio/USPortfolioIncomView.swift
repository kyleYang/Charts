//
//  USPortfolioIncomView.swift
//  USChartView
//  组合收益图
//  Created by Kyle on 16/7/5.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import HMSegmentedControl
import SnapKit
import SwiftDate
import RxSwift


public enum USPortfolioIncomFilterType : Int{
    case ThreeMonth = 0
    case OneYear = 1
    case ThisYear = 2
    case AllTime = 3
}

public class USPortfolioIncomView: UIView {
    
    public var portfolioID : String = ""{
        didSet{
            if portfolioID != oldValue {
                self.queryDayGain()
            }
        }
    }
    private var _type : USPortfolioIncomFilterType = .ThreeMonth
    private var type : USPortfolioIncomFilterType {
        get{
            return _type
        }set{
            if _type != newValue {
                _type = newValue
                self.reloadData()
            }
        }
    }
    
    
    
    var segmentControl : HMSegmentedControl = HMSegmentedControl(frame: CGRectZero)
    var chartView : LineChartView = LineChartView()
    
    var dataArray : Array<USDayGain> = []
    var filterArray : Array<USDayGain> = []
    
    var minDate : NSDate! = NSDate()
    var maxDate : NSDate! = NSDate()
    var minValue : CGFloat!
    var maxValue : CGFloat!
    
    //config
    private var ySeparate : Int = 6
    private var xSeparate : Int = 4
    
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
        let titles : [AnyObject] = ["3个月","近1年","今年以来","全部"]
        self.segmentControl.sectionTitles = titles;
        self.segmentControl.indexChangeBlock = {(index) in
            
            self.type = USPortfolioIncomFilterType(rawValue: index)!
            
        }
  
        ({(view : HMSegmentedControl) in
            self.addSubview(view)
        }(self.segmentControl))
        
        ({(view : LineChartView) in
            view.delegate = self
            view.dragEnabled = false
            view.setScaleEnabled(false)
            view.pinchZoomEnabled = false
            view.drawGridBackgroundEnabled = true
            view.rightAxis.enabled = false;
            self.addSubview(view)
            }(self.chartView))

        
        
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

    }
    

}

//MARK: network
extension USPortfolioIncomView {
    
    func queryDayGain() {
        let result : Observable<[USDayGain]> = USProvider.requestArrayMapper(USStructTarget(.PortfolioDayGainRatio(portfolioId:portfolioID)))
        result.subscribe {[unowned self] (event) in
            switch event {
            case .Next(let elements) :
                self.dataArray.appendContentsOf(elements)
                self.reloadData()
            default:
                break
            }
        }.addDisposableTo(rx_disposeBag)
    }
    
}


//MARK: ChartViewDelegate
extension USPortfolioIncomView : ChartViewDelegate {
    
}


//MARK: private method
extension USPortfolioIncomView {
    
    
    private func reloadData(){
        
        if self.dataArray.count == 0 {
            return
        }
  
        switch self.type {
         case .ThreeMonth:
            self.minDate = NSDate.addMonths(months: -3)
            self.maxDate = 1.days.fromNow().endOf(.Day)
        case .OneYear:
            self.minDate = NSDate.addYears(years: -1)
            self.maxDate = 1.days.fromNow().endOf(.Day)
        case .ThisYear:
            self.minDate = NSDate.thisYear()
            self.maxDate = 1.days.fromNow().endOf(.Day)
        case .AllTime:
            break
        default:
            break
        }
        
        
        self.filterData()
        self.updateYAxis()
        self.setData()
        
    }
    
    //获取筛选的数据
    private func filterData() {
        
        var _max : Float = 0
        var _min : Float = 0
        
        self.filterArray.removeAll()
        
        for (_ , element) in self.dataArray.enumerate() {
            
            if element.date >= minDate && element.date <= maxDate {
                
                self.filterArray.append(element)
                _max = max(_max, element.gainRatio)
                _min = min(_min, element.gainRatio)
            }
        }
        
        let separate : Float = (_max*100 - _min*100)/Float(ySeparate) //百分比
        _max = round(_max*100 + separate)
        _min = floor(_min*100 - separate)
        
        
        maxValue = CGFloat(_max/100)
        minValue = CGFloat(_min/100)
    
    }
    
    
    //更新纵轴
    private func updateYAxis(){
        
//        let yAxis = chartView.leftAxis
//        yAxis.removeAllLimitLines()
//        
//        yAxis.axisMaxValue = Double(maxValue)
//        yAxis.axisMinValue = Double(minValue)
        
    
    }
    
    private func setData(){
        
        var xVals : Array<String?> = []
        
        for(var date = self.minDate ; date < self.maxDate; date = 1.days.fromDate(date)){

            if date.day == 1 {
                xVals.append("\(date.month)月")
            }else{
                xVals.append(nil)
            }
        }
        
        var yVals : Array<ChartDataEntry> = []
        
        for (index,element) in self.filterArray.enumerate() {
            
            let days = NSDate.between(self.minDate, secondDate: element.date)
            
            let data = ChartDataEntry(value: Double(element.gainRatio), xIndex: days)
            yVals.append(data)
        }
        
        let set = LineChartDataSet(yVals: yVals, label: nil)
        set.lineWidth = 1
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
        chartView.data = date
        
    }
    
    
}

