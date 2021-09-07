//
//  LipidProfileTableViewCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 23/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Charts

class LipidProfileViewAndEditCell1: UITableViewCell {
    
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

class LipidProfileViewAndEditCell2: UITableViewCell {
    
    @IBOutlet weak var totalCholesterolPriorityBGView: UIView!
    @IBOutlet weak var totalCholesterolPriorityColorView: UIView!
    @IBOutlet weak var totalCholesterolPriorityLabel: UILabel!
    @IBOutlet weak var totalCholesterolTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        totalCholesterolTextField.tag = 13
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class LipidProfileViewAndEditCell3: UITableViewCell {
    
    @IBOutlet weak var hdlPriorityBGView: UIView!
    @IBOutlet weak var hdlPriorityColorView: UIView!
    @IBOutlet weak var hdlPriorityLabel: UILabel!
    @IBOutlet weak var hdlTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hdlTextField.tag = 14
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class LipidProfileViewAndEditCell4: UITableViewCell {
    
    @IBOutlet weak var ldlPriorityBGView: UIView!
    @IBOutlet weak var ldlPriorityColorView: UIView!
    @IBOutlet weak var ldlPriorityLabel: UILabel!
    @IBOutlet weak var ldlTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ldlTextField.tag = 15
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class LipidProfileViewAndEditCell5: UITableViewCell {
    
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

class LipidProfileViewAndEditCell6: UITableViewCell {
    
    @IBOutlet weak var addReminderTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addReminderTextField.tag = 16
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class LipidProfileLogsCell: UITableViewCell {
    
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

class LipidProfileReportsCell1: UITableViewCell,ChartViewDelegate {
    
    @IBOutlet weak var unitView: UIView!
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

class LipidProfileReportsCell2: UITableViewCell {
    
    @IBOutlet weak var totalCholestrolButton: UIButton!
    @IBOutlet weak var hdlButton: UIButton!
    @IBOutlet weak var ldlButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        totalCholestrolButton.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        totalCholestrolButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        totalCholestrolButton.layer.cornerRadius = 3
        totalCholestrolButton.layer.borderWidth = 1
        
        hdlButton.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        hdlButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        hdlButton.layer.cornerRadius = 3
        hdlButton.layer.borderWidth = 1
        
        ldlButton.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        ldlButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        ldlButton.layer.cornerRadius = 3
        ldlButton.layer.borderWidth = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class LipidProfileReportsCell3: UITableViewCell {
    
    @IBOutlet weak var categoryValueLabel: UILabel!
    @IBOutlet weak var lowValueLabel: UILabel!
    @IBOutlet weak var normalValueLabel: UILabel!
    @IBOutlet weak var highValueLabel: UILabel!
    @IBOutlet weak var veryHighValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
