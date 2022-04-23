//
//  chartsViewController.swift
//  Team-Bravo
//
//  Created by Ranjith Shaganti on 4/22/22.
//

import UIKit
import Charts

class chartsViewController: UIViewController {
    
    @IBOutlet weak var pieChart1: PieChartView!
    
    var ticketsbooked: Array<Int> = Array()
    var getListOfEvents: Array<String> = Array()
    
//    @IBOutlet weak var pieView: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPieChart()
        print("--------- ", ticketsbooked)
        print(getListOfEvents)
        // Do any additional setup after loading the view.
    }
    
    func setupPieChart(){
        pieChart1.chartDescription.enabled=false
        pieChart1.drawHoleEnabled=false
        pieChart1.rotationAngle=0
        pieChart1.rotationEnabled = false
        pieChart1.isUserInteractionEnabled = false
        
        //pieView.legend.enabled = false
        var entries: [PieChartDataEntry] = Array()
        for (i,j) in zip(ticketsbooked,getListOfEvents){
            print(i,j)
            entries.append(PieChartDataEntry(value: Double(i), label: String(format:"Booked: %@",j)))
            entries.append(PieChartDataEntry(value: (Double(100-Double(i))), label: String(format:"Not Booked: %@",j)))
        
            let dataSet = PieChartDataSet(entries: entries, label: "")
        
            let c1 = NSUIColor(hex: 0x3A015C)
            let c2 = NSUIColor(hex: 0x35012C)
        
            dataSet.colors = [c1,c2]
            dataSet.drawValuesEnabled = false
            pieChart1.data = PieChartData(dataSet: dataSet)
            
        }
        
    }

}
