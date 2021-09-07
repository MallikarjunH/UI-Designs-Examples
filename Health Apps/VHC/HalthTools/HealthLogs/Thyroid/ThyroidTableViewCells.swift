//
//  ThyroidTableViewCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 22/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Charts

class ThyroidViewAndEditCell1: UITableViewCell {

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

class ThyroidViewAndEditCell2: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var serumThyroxinePriorityBGView: UIView!
    @IBOutlet weak var serumThyroxinePriorityColorView: UIView!
    @IBOutlet weak var serumThyroxinePriorityLabel: UILabel!
    @IBOutlet weak var serumThyroxineTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        serumThyroxineTextField.tag = 9
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class ThyroidViewAndEditCell3: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var serumTriiodothyroninePriorityBGView: UIView!
    @IBOutlet weak var serumTriiodothyroninePriorityColorView: UIView!
    @IBOutlet weak var serumTriiodothyroninePriorityLabel: UILabel!
    @IBOutlet weak var serumTriiodothyronineTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        serumTriiodothyronineTextField.tag = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class ThyroidViewAndEditCell4: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var serumThyrotropinPriorityBGView: UIView!
    @IBOutlet weak var serumThyrotropinPriorityColorView: UIView!
    @IBOutlet weak var serumThyrotropinPriorityLabel: UILabel!
    @IBOutlet weak var serumThyrotropinTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        serumThyrotropinTextField.tag = 11
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class ThyroidViewAndEditCell5: UITableViewCell {
    
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

class ThyroidViewAndEditCell6: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var addReminderTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addReminderTextField.tag = 12
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class ThyroidLogsCell: UITableViewCell {
    
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

class ThyroidReportsCell1: UITableViewCell,ChartViewDelegate {
 
    
    @IBOutlet weak var unitsView: UIView!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var chartViewOutlet: LineChartView!
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


class ThyroidReportsCell2: UITableViewCell {
    
    @IBOutlet weak var serumThyroxine: UIButton!
    @IBOutlet weak var serumThyrotropin: UIButton!
    @IBOutlet weak var serumTriiodothyronine: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        serumThyroxine.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        serumThyroxine.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        serumThyroxine.layer.cornerRadius = 3
        serumThyroxine.layer.borderWidth = 1
        
        serumThyrotropin.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        serumThyrotropin.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        serumThyrotropin.layer.cornerRadius = 3
        serumThyrotropin.layer.borderWidth = 1
        
        serumTriiodothyronine.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        serumTriiodothyronine.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        serumTriiodothyronine.layer.cornerRadius = 3
        serumTriiodothyronine.layer.borderWidth = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class ThyroidReportsCell3: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
