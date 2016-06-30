//
//  MKDChartViewController.swift
//  MapKitDemo
//
//  Created by Robin Sun on 29/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import UIKit
import Charts

class MKDChartViewController: UIViewController {
    
    @IBOutlet weak var chartView: HorizontalBarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Charts"
        setupChartAxis()
        setupData()
    }
    
    // setup chart axis
    func setupChartAxis() {
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        chartView.maxVisibleValueCount = 60
        chartView.userInteractionEnabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .BottomInside
        xAxis.labelFont = UIFont.systemFontOfSize(10.0)
        xAxis.drawGridLinesEnabled = false
        xAxis.spaceBetweenLabels = 2
        
        let leftAxis = chartView.leftAxis
        leftAxis.enabled = false
        
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = UIFont.systemFontOfSize(10.0)
        rightAxis.labelCount = 4
        rightAxis.valueFormatter = NSNumberFormatter()
        rightAxis.valueFormatter?.maximumFractionDigits = 1
        rightAxis.valueFormatter?.negativeSuffix = "%"
        rightAxis.valueFormatter?.positiveSuffix = "%"
        rightAxis.labelPosition = .OutsideChart;
        //        rightAxis.spaceTop = 0.15;
        rightAxis.axisMinValue = 0.0; // this replaces startAtZero = YES
        
        chartView.legend.position = .BelowChartLeft
        chartView.legend.form = .Square
        chartView.legend.formSize = 9.0
        if let font = UIFont(name:"HelveticaNeue-Light", size: 11.0) {
            chartView.legend.font = font
        }
        chartView.legend.xEntrySpace = 4.0
    }
    
    // setup data (birth rate and death rate)
    func setupData() {
        let watchlist = MKDDataManager.sharedInstance.watchlist.allObjects
        let xVals = watchlist.flatMap { ($0 as? MKDCountryModel)?.name ?? ""}
        var birthRateYVals = [ChartDataEntry]()
        var deathRateYVals = [ChartDataEntry]()
        
        if watchlist.count > 0 {
            for i in 0...watchlist.count-1 {
                if let country = watchlist[i] as? MKDCountryModel {
                    birthRateYVals.append(BarChartDataEntry(value:country.birthrate ?? 0.0, xIndex:i))
                    deathRateYVals.append(BarChartDataEntry(value:country.deathrate ?? 0.0, xIndex:i))
                }
            }
            
            var birthRateSet:BarChartDataSet?
            var deathRateSet:BarChartDataSet?
            if chartView.data?.dataSetCount > 0 {
                birthRateSet = chartView.data?.dataSets[0] as? BarChartDataSet
                birthRateSet?.yVals = birthRateYVals
                
                deathRateSet = chartView.data?.dataSets[1] as? BarChartDataSet
                deathRateSet?.yVals = deathRateYVals
                
                chartView.data?.xValsObjc = xVals
                chartView.notifyDataSetChanged()
            } else {
                birthRateSet = BarChartDataSet(yVals: birthRateYVals, label: "Birth Rate")
//                birthRateSet?.barSpace = 0.35
                birthRateSet?.colors = [PRIMARY_COLOR]
                
                deathRateSet = BarChartDataSet(yVals: deathRateYVals, label: "Death Rate")
//                deathRateSet?.barSpace = 0.35
                deathRateSet?.colors = [NSUIColor.lightGrayColor()]
                var dataSets = [BarChartDataSet]()
                dataSets.append(birthRateSet!)
                dataSets.append(deathRateSet!)
                let data = BarChartData(xVals: xVals, dataSets: dataSets)
                data.setValueFont(UIFont(name:"HelveticaNeue-Light", size: 10.0))
                chartView.data = data
            }
        }
        
        self.chartView.animate(yAxisDuration: 1.0)
    }

}











