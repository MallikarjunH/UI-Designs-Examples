//
//  BloodPressureTableViewCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 18/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Charts

class BloodPressureViewAndEditCell1: UITableViewCell {

    @IBOutlet weak var firstCellLabel: UILabel!
    @IBOutlet weak var firstCellImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class BloodPressureViewAndEditCell2: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var systolicBPPriorityBGView: UIView!
    @IBOutlet weak var systolicBPPriorityColorView: UIView!
    @IBOutlet weak var systolicBPPriorityLabel: UILabel!
    @IBOutlet weak var systolicBPTextField: UITextField!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        systolicBPTextField.tag = 1
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class BloodPressureViewAndEditCell3: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var diastolicBPPriorityBGView: UIView!
    @IBOutlet weak var diastolicBPPriorityColorView: UIView!
    @IBOutlet weak var diastolicBPPriorityLabel: UILabel!
    @IBOutlet weak var diastolicBPTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         diastolicBPTextField.tag = 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class BloodPressureViewAndEditCell4: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var heartRatePriorityBGView: UIView!
    @IBOutlet weak var heartRatePriorityColorView: UIView!
    @IBOutlet weak var heartRatePriorityLabel: UILabel!
    @IBOutlet weak var heartRateTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        heartRateTextField.tag = 3
    }
    
}

class BloodPressureViewAndEditCell5: UITableViewCell {
    
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var upArrowImg: UIImageView!
    @IBOutlet weak var cancelImage: UIImageView!
    @IBOutlet weak var cancelButtonHiddenButton: UIButton!

    @IBOutlet weak var selectedFileNameLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class BloodPressureViewAndEditCell6: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var addReminderTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addReminderTextField.tag = 4
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class BloodPressureLogsCell: UITableViewCell{
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var riskLevelImage: UIImageView!
    @IBOutlet weak var riskLevelLabel: UILabel!
    @IBOutlet weak var riskLevelDotColor: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var fileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      fileNameLabel.lineBreakMode = .byWordWrapping
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class BloodPressureReportCell1: UITableViewCell,ChartViewDelegate{

    @IBOutlet weak var chartViewOutlet: LineChartView!
    
    @IBOutlet weak var unitsView: UIView!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var lowRangeView: UIView!
    @IBOutlet weak var highRangeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lowRangeView.layer.cornerRadius = lowRangeView.frame.size.width/2
        lowRangeView.clipsToBounds = true
        
        highRangeView.layer.cornerRadius = highRangeView.frame.size.width/2
        highRangeView.clipsToBounds = true 
        highRangeView.backgroundColor = UIColor.red
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class BloodPressureReportCell2: UITableViewCell{
   
    @IBOutlet weak var systolicButton: UIButton!
    @IBOutlet weak var diastolicButton: UIButton!
    @IBOutlet weak var heartRateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        systolicButton.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        systolicButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        systolicButton.layer.cornerRadius = 3
        systolicButton.layer.borderWidth = 1
        
        diastolicButton.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        diastolicButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        diastolicButton.layer.cornerRadius = 3
        diastolicButton.layer.borderWidth = 1
        
        heartRateButton.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        heartRateButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        heartRateButton.layer.cornerRadius = 3
        heartRateButton.layer.borderWidth = 1
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class BloodPressureReportCell3: UITableViewCell{
    
    @IBOutlet weak var tableTitleLabel: UILabel!
    @IBOutlet weak var toolTipButton: UIButton!
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryValue: UILabel!
    
    @IBOutlet weak var firstRowFirstColumn: UILabel!
    @IBOutlet weak var secondRowFirstColumn: UILabel!
    @IBOutlet weak var thirdRowFirstColumn: UILabel!
    @IBOutlet weak var fourthRowFirstColumn: UILabel!
    @IBOutlet weak var fifthRowFirstColumn: UILabel!
    @IBOutlet weak var sixthRowFirstColumn: UILabel!
    @IBOutlet weak var sevenRowFirstColumn: UILabel!
    
    @IBOutlet weak var firstRowSecondColumn: UILabel!
    @IBOutlet weak var secondRowSecondColumn: UILabel!
    @IBOutlet weak var thirdRowSecondColumn: UILabel!
    @IBOutlet weak var fourthRowSecondColumn: UILabel!
    @IBOutlet weak var fifthRowSecondColumn: UILabel!
    @IBOutlet weak var sixthRowSecondColumn: UILabel!
    @IBOutlet weak var sevenRowSecondColumn: UILabel!
    
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}


class BloodPressureReportCell4: UITableViewCell{

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
