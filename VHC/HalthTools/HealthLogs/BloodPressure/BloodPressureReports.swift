//
//  BloodPressureReports.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Charts

class BloodPressureReports: UIViewController, UITableViewDataSource, UITableViewDelegate, ChartViewDelegate,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var dataEntries: [ChartDataEntry] = []
   // var months = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
   // var unitsSold = [24.0,43.0,56.0,23.0,111.0,68.0,48.0,120.0,355.0,34.0,55.9,12.0]
   
    var months = [String]()
    var unitsSold = [Double]()
    
    var selectedOption = ""
    var upperLimitValue = 0.0
    var lowerLimitValue = 0.0
    var axisMinValue = 0.0
    var axixMaxvalue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedOption = "systolicBP"
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadLogRecords(notification:)), name: Notification.Name("refreshChartDataValues"), object: nil) 
    
        // Do any additional setup after loading the view.
    }

    //MARK: TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureReportCell1Id", for: indexPath) as! BloodPressureReportCell1
        // setChart(dataPoints: months, values: unitsSold)
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            
            unitsSold = []
            
            if selectedOption == "systolicBP"{
                if GlobalVariables.sharedManager.systolicBpArray != nil{
                    unitsSold = GlobalVariables.sharedManager.systolicBpArray!
                    cell.unitsLabel.text = "Units - mg/dL"
                   // print(GlobalVariables.sharedManager.systolicBpArray!)
                }
            }
            else if selectedOption == "diastolicBP"{
                if GlobalVariables.sharedManager.diastolicBpArray != nil{
                    unitsSold = GlobalVariables.sharedManager.diastolicBpArray!
                    cell.unitsLabel.text = "Units - mg/dL"
                   // print(GlobalVariables.sharedManager.diastolicBpArray!)
                }
            }
            else if selectedOption == "heartRate"{
                if GlobalVariables.sharedManager.heartRateArray != nil{
                    unitsSold = GlobalVariables.sharedManager.heartRateArray!
                    cell.unitsLabel.text = "Units - bpm"
                   // print(GlobalVariables.sharedManager.heartRateArray!)
                }
            }
            
            
        if unitsSold.count < 1{
            
             cell.chartViewOutlet.noDataText = "No data available!"
             cell.unitsView.isHidden = true
        }
        else{
            
            cell.unitsView.isHidden = false
            
            dataEntries = []
            for i in 0 ..< unitsSold.count {
                let dataEntry = ChartDataEntry(x: Double(i), y: unitsSold[i]) // here we set the X and Y status in a data chart entry
                dataEntries.append(dataEntry) // here we add it to the data set
            }
            
            let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Consumed")
            
         /*   lineChartDataSet.setCircleColor(UIColor.clear) // hide the outer circle color
            lineChartDataSet.circleRadius = 0.0
            lineChartDataSet.lineWidth = 2.0 //1.0
            lineChartDataSet.valueTextColor = UIColor.clear //hide the values on the curve line */
            
            lineChartDataSet.setCircleColor(UIColor.black) //setCircleColor(UIColor.clear) // hide the outer circle color
            lineChartDataSet.circleRadius = 3.0 //circleRadius = 0.0
            lineChartDataSet.lineWidth = 1.0 //1.0
            lineChartDataSet.valueTextColor = UIColor.black //hide the values on the curve line
            
            // to show line (curve line)
            lineChartDataSet.colors = [NSUIColor.blue] //Sets the line colour to blue
            lineChartDataSet.mode = .cubicBezier
            lineChartDataSet.cubicIntensity = 0.2
            
            var dataSets = [LineChartDataSet]() //This is the object that will be added to the chart
            dataSets.append(lineChartDataSet)  //Adds the line to the dataSet
            
            let lineChartData = LineChartData(dataSets: dataSets)
            cell.chartViewOutlet.data = lineChartData //finally - it adds the chart data to the chart and causes an update
            
            cell.chartViewOutlet.chartDescription?.text = "" //hide descriptionn label
            
            cell.chartViewOutlet.xAxis.enabled = true //show x axis
            cell.chartViewOutlet.leftAxis.enabled = true //show/hide left axix (Y axis)
            cell.chartViewOutlet.rightAxis.enabled = false //show/hide right axis (Y axis)
            cell.chartViewOutlet.animate(xAxisDuration: 1.5) //show animation
            cell.chartViewOutlet.drawGridBackgroundEnabled = true //show or hide background color
            //set in storyboard = #F3F4F8 or UIColor(red: 0.243, green: 0.244, blue: 0.248, alpha: 1)
            

            
            cell.chartViewOutlet.xAxis.drawGridLinesEnabled = true //it will show/hide grid background (Verticles lines - Y - form x axix)
            cell.chartViewOutlet.xAxis.drawAxisLineEnabled = true //show x axis line
            cell.chartViewOutlet.xAxis.labelPosition = .bottom // values/labels of x axis - position
            cell.chartViewOutlet.xAxis.drawLabelsEnabled = true //show/hide values/labels in x axis
            
            //right and left axis - optional/not required
            // chartViewOutlet.leftAxis.drawAxisLineEnabled = true //show lines of left x axis
            cell.chartViewOutlet.leftAxis.drawGridLinesEnabled = true //hide/show x axis grid lines - horizontal lines ( X axis - from Y)
            //  chartViewOutlet.rightAxis.drawAxisLineEnabled = false
            // chartViewOutlet.rightAxis.drawGridLinesEnabled = false
            
            cell.chartViewOutlet.legend.enabled = false //show.hide legend - below graph
            
            // swift 4.0 and lower versions
            let customFormater = CustomFormatter1()
            customFormater.labels =  months
            cell.chartViewOutlet.xAxis.valueFormatter = customFormater
            
            cell.chartViewOutlet.xAxis.labelRotationAngle = -45  // fixed label merging into others
            // this availabele after swift 4.2 or 5.0
            // chartViewOutlet.xAxis.valueFormatter = IndexAxisValueFormatter(values: months) //enable/show months label at x axis
            
            
            // Showing Limits and Showing dashed lines
            
            // x-axis limit line
            let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
            llXAxis.lineWidth = 1.5
            llXAxis.lineDashLengths = [10, 10, 0]
            llXAxis.labelPosition = .rightBottom
            llXAxis.valueFont = .systemFont(ofSize: 10)
            
            cell.chartViewOutlet.xAxis.gridLineDashLengths = [4, 4] // verticle line - dash lines
            cell.chartViewOutlet.xAxis.gridLineDashPhase = 0
            
            
            if selectedOption == "systolicBP"{
                upperLimitValue = 140.0
                lowerLimitValue = 90.0
                axisMinValue = 50.0
                axixMaxvalue = 300.0
            }
            else if selectedOption == "diastolicBP"{
                upperLimitValue = 80.0
                lowerLimitValue = 60.0
                axisMinValue = 30.0
                axixMaxvalue = 150.0
            }
            else if selectedOption == "heartRate"{
                upperLimitValue = 100.0
                lowerLimitValue = 60.0
                axisMinValue = 40.0
                axixMaxvalue = 200.0
            }
            
            let ll1 = ChartLimitLine(limit: upperLimitValue, label: "High") // limit the upper line
            ll1.lineWidth = 1.5
            ll1.lineColor = UIColor.red
            ll1.lineDashLengths = [4, 4]
            ll1.labelPosition = .rightTop
            ll1.valueFont = .systemFont(ofSize: 10)
            
            let ll2 = ChartLimitLine(limit: lowerLimitValue, label: "Low") // limit the lower line
            ll2.lineWidth = 1.5
            ll2.lineColor = UIColor.green
            ll2.lineDashLengths = [4,4]
            ll2.labelPosition = .rightBottom
            ll2.valueFont = .systemFont(ofSize: 10)
            
            let leftAxis = cell.chartViewOutlet.leftAxis
            leftAxis.removeAllLimitLines()
            leftAxis.addLimitLine(ll1)
            leftAxis.addLimitLine(ll2)
            leftAxis.axisMaximum = axixMaxvalue  //300 //highest values to show grph - y axis
            leftAxis.axisMinimum = axisMinValue //50// lowest values where graph has to start
            
            leftAxis.gridLineDashLengths = [5, 5] //horizontal line - dash lines
            leftAxis.drawLimitLinesBehindDataEnabled = true
        }
        
         return cell
        }
        else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureReportCell2Id", for: indexPath) as! BloodPressureReportCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            cell.systolicButton.addTarget(self, action: #selector(systolicButtonAction(sender:)), for: .touchUpInside)
            cell.diastolicButton.addTarget(self, action: #selector(diastolicButtonAction(sender:)), for: .touchUpInside)
            cell.heartRateButton.addTarget(self, action: #selector(heartRateButtonAction(sender:)), for: .touchUpInside)
            
            if selectedOption == "systolicBP"{
                
               cell.systolicButton.setTitleColor(.white, for: .normal)
               cell.diastolicButton.setTitleColor(.black, for: .normal)
               cell.heartRateButton.setTitleColor(.black, for: .normal)
               cell.systolicButton.backgroundColor = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
               cell.diastolicButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
               cell.heartRateButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
            }
            else if selectedOption == "diastolicBP"{
                
                cell.diastolicButton.setTitleColor(.white, for: .normal)
                cell.systolicButton.setTitleColor(.black, for: .normal)
                cell.heartRateButton.setTitleColor(.black, for: .normal)
                cell.diastolicButton.backgroundColor = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
                cell.systolicButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
                cell.heartRateButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
            }
            else if selectedOption == "heartRate"{
                
                cell.heartRateButton.setTitleColor(.white, for: .normal)
                cell.diastolicButton.setTitleColor(.black, for: .normal)
                cell.systolicButton.setTitleColor(.black, for: .normal)
                cell.heartRateButton.backgroundColor = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
                cell.diastolicButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
                cell.systolicButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
            }
            else{
                cell.heartRateButton.setTitleColor(.black, for: .normal)
                cell.diastolicButton.setTitleColor(.black, for: .normal)
                cell.systolicButton.setTitleColor(.black, for: .normal)
            }
            
            return cell
        }
        else if indexPath.section == 2{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureReportCell3Id", for: indexPath) as! BloodPressureReportCell3
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
       
                cell.tableTitleLabel.text = "Heart Rate Table"
                cell.categoryLabel.text = "Age"
                cell.categoryValue.text = "Heart rate"
                
                cell.firstRowFirstColumn.text = "Upto 1 month"
                cell.secondRowFirstColumn.text = "1-11 months"
                cell.thirdRowFirstColumn.text = "1-2 years"
                cell.fourthRowFirstColumn.text = "3-4 years"
                cell.fifthRowFirstColumn.text = "5-6 years"
                cell.sixthRowFirstColumn.text = "7-9 years"
                cell.sevenRowFirstColumn.text = "> 10 years"
                
                cell.firstRowSecondColumn.text = "70-190 bpm"
                cell.secondRowSecondColumn.text = "80-160 bpm"
                cell.thirdRowSecondColumn.text = "80-130 bpm"
                cell.fourthRowSecondColumn.text = "80-120 bpm"
                cell.fifthRowSecondColumn.text = "75-115 bpm"
                cell.sixthRowSecondColumn.text = "70-110 bpm"
                cell.sevenRowSecondColumn.text = "60-100 bpm"
                
                cell.noteLabel.isHidden = false
                cell.noteDescriptionLabel.isHidden = false
                cell.toolTipButton.isHidden = false
                
                cell.toolTipButton.addTarget(self, action: #selector(toolTipButtonClicked(sender:)), for: .touchUpInside)
            
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureReportCell4Id", for: indexPath) as! BloodPressureReportCell4
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
             return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedOption == "systolicBP" || selectedOption == "diastolicBP" {
            
            if indexPath.section == 0{
                
                return 335.0
            }
            else if indexPath.section == 1{
                
                return 55.0
            }
            else if indexPath.section == 2{
               
                 return 0.0
            }else{
                return 370.0
            }
        }
        else  {
            
            if indexPath.section == 0{
                
                return 335.0
            }
            else if indexPath.section == 1{
                
                return 55.0
            }
            else if indexPath.section == 2{
                if selectedOption == "heartRate"{
                    return 505.0
                }
                else{
                    return 400.0
                }
            }else{
                return 0.0
            }
        }
        
        
    }
    
    
    //MARK: Tool Tip Button Action
     @objc func toolTipButtonClicked(sender:UIButton){
    
        let storyBoard = UIStoryboard.init(name: "HealthTools", bundle: nil)
        let popOverVC = storyBoard.instantiateViewController(withIdentifier: "HeartRateInfoId") as! HeartRateInfo
        
        let indexPath = IndexPath(row: 0, section: 2)
        let cell2:BloodPressureReportCell3 = mainTableView.cellForRow(at: indexPath) as! BloodPressureReportCell3
        
        let popVC = ARSPopover.init()
        popVC.sourceView = cell2.toolTipButton
        popVC.sourceRect = CGRect(x:cell2.toolTipButton.bounds.midX, y: cell2.toolTipButton.bounds.maxY + 5, width: 0, height: 0)
        popVC.contentSize = CGSize(width: 400, height: 140)
        popVC.arrowDirection = UIPopoverArrowDirection.up
        
        popVC.addChildViewController(popOverVC)
       // let tempSize = CGSize(width: 180, height: 160)
        
        self.present(popVC, animated: true) {
            popVC.insertContent(intoPopover: { popupController, tempSize, popoverArrowHeight in
                popupController?.view.addSubview(popOverVC.view)
                
            })
        }
        
     }
    
    // MARK: Table Chart Selection Buttons
     @objc func systolicButtonAction(sender:UIButton){
        
        selectedOption = "systolicBP"
        updateBloodPressureStagesTable()
     }
    
    @objc func diastolicButtonAction(sender:UIButton){
        
        selectedOption = "diastolicBP"
         updateBloodPressureStagesTable()
     }
    
    @objc func heartRateButtonAction(sender:UIButton){
        
        selectedOption = "heartRate"
        updateBloodPressureStagesTable()
    }
    
    func updateBloodPressureStagesTable(){
    
        if selectedOption == "systolicBP"{
        
        }
        else if selectedOption == "diastolicBP"{
           
        }
        else if selectedOption == "heartRate"{
        
        }
        else{ }
        
        mainTableView.reloadData()
    }
    
    //MARK: Notification call
    @objc func reloadLogRecords(notification: Notification) {
        
        if GlobalVariables.sharedManager.dateForBPArray != nil{
            
            months = GlobalVariables.sharedManager.dateForBPArray!
            
        }
        mainTableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("refreshChartDataValues"), object: nil)
    }
    
}

//MARK: Custome Method to show x values on chart
final class CustomFormatter1: IAxisValueFormatter {
    
    var labels: [String] = []
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let count = self.labels.count
        
        guard let axis = axis, count > 0 else {
            return ""
        }
        
        let factor = axis.axisMaximum / Double(count)
        
        let index = Int((value / factor).rounded())
        
        if index >= 0 && index < count {
            return self.labels[index]
        }
        
        return ""
    }
}
