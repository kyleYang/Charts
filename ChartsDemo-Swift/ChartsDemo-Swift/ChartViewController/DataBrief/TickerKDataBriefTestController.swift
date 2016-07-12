//
//  TickerKDataBriefTestController.swift
//  NewUstock
//
//  Created by Kyle on 16/7/7.
//  Copyright © 2016年 ustock. All rights reserved.
//

import UIKit
import SnapKit

class TickerKDataBriefTestController: UIViewController {

    let chartView = USTickerKChartBriefView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()

        // Do any additional setup after loading the view.
    }
    
    func buildUI() {
       
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        ({ (view : USTickerKChartBriefView) in
            self.view.addSubview(view)
        }(self.chartView))
        
        self.chartView.snp_makeConstraints { (make) in
            make.leading.equalTo(self.view.snp_leading).offset(0)
            make.trailing.equalTo(self.view.snp_trailing).offset(0)
            make.top.equalTo(self.view.snp_top).offset(80)
            make.height.equalTo(300)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.chartView.tickerId = 2553
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
