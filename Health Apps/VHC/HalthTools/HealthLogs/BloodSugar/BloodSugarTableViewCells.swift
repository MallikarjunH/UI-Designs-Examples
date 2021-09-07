//
//  BloodSugarTableViewCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 22/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Charts

class BloodSugarViewAndEditCell1: UITableViewCell {
    
    @IBOutlet weak var firstCellsLabel: UILabel!
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

class BloodSugarViewAndEditCell2: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var fastingPriorityBGView: UIView!
    @IBOutlet weak var fastingPriorityColorView: UIView!
    @IBOutlet weak var fastingPriorityLabel: UILabel!
    @IBOutlet weak var fastingTextField: UITextField!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fastingTextField.tag = 5
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class BloodSugarViewAndEditCell3: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var randomPriorityBGView: UIView!
    @IBOutlet weak var randomPriorityColorView: UIView!
    @IBOutlet weak var randomPriorityLabel: UILabel!
    @IBOutlet weak var randomTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        randomTextField.tag = 6
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class BloodSugarViewAndEditCell4: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var postPrandialPriorityBGView: UIView!
    @IBOutlet weak var postPrandialPriorityColorView: UIView!
    @IBOutlet weak var postPrandialPriorityLabel: UILabel!
    @IBOutlet weak var postPrandialTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        postPrandialTextField.tag = 7
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class BloodSugarViewAndEditCell5: UITableViewCell,UITextFieldDelegate {
    
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

class BloodSugarViewAndEditCell6: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var addReminderTextField: UITextField!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addReminderTextField.tag = 8
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class BloodSugarLogsCell: UITableViewCell {

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


class BloodSugarReportsCell1: UITableViewCell,ChartViewDelegate{
    
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

class BloodSugarReportsCell2: UITableViewCell{
    
    @IBOutlet weak var fastingButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var postPrandialButotton: UIButton!
 //   @IBOutlet weak var hba1cButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        fastingButton.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        fastingButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        fastingButton.layer.cornerRadius = 3
        fastingButton.layer.borderWidth = 1
        
        randomButton.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        randomButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        randomButton.layer.cornerRadius = 3
        randomButton.layer.borderWidth = 1
        
        postPrandialButotton.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        postPrandialButotton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        postPrandialButotton.layer.cornerRadius = 3
        postPrandialButotton.layer.borderWidth = 1
        
      //  hba1cButton.layer.borderColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
      //  hba1cButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
       // hba1cButton.layer.cornerRadius = 3
      //  hba1cButton.layer.borderWidth = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

class BloodSugarReportsCell3: UITableViewCell{
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
