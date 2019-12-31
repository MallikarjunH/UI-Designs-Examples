//
//  HealthToolsCalculatorFormCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class HealthToolsCalculatorFormCell0: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
} //HeightSelectionPopUpVC

class HealthToolsCalculatorFormCell1: UITableViewCell {

    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        maleButton.layer.cornerRadius = 3
        maleButton.layer.borderWidth = 1
        maleButton.layer.borderColor = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        maleButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        
        femaleButton.layer.cornerRadius = 3
        femaleButton.layer.borderWidth = 1
        femaleButton.layer.borderColor = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1).cgColor
        femaleButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class HealthToolsCalculatorFormCell2: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var weightTextField: UITextField!
  //  @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var waistCircumferenceTextField: UITextField!
    @IBOutlet weak var wristCircumferenceTextField: UITextField!
    @IBOutlet weak var hipCircumferenceTextField: UITextField!
    @IBOutlet weak var forearmCircumferenceTextField: UITextField!
    
  //  var selectHeightButton: UIButton!
  //  @IBOutlet weak var calculateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
   /*     selectHeightButton = UIButton(type: UIButtonType.system)
        let  TextFrame:CGRect = self.heightTextField.frame
        selectHeightButton.frame = CGRect(x: TextFrame.origin.x, y: TextFrame.origin.y, width: TextFrame.size.width, height: TextFrame.size.height)
        selectHeightButton.backgroundColor = .clear
        self.contentView.addSubview(selectHeightButton) */
        
        weightTextField.tag = 11
    //    heightTextField.tag = 12
        waistCircumferenceTextField.tag = 13
        wristCircumferenceTextField.tag = 14
        hipCircumferenceTextField.tag = 15
        forearmCircumferenceTextField.tag = 16
        
        weightTextField.text = ""
     //   heightTextField.text = ""
        waistCircumferenceTextField.text = ""
        wristCircumferenceTextField.text = ""
        hipCircumferenceTextField.text = ""
        forearmCircumferenceTextField.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class HeightSelectionPopUpCell: UITableViewCell {
    
    
    @IBOutlet weak var heightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
} 
