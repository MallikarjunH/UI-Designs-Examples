//
//  BabyHeightPredictorFormCells.swift
//  Baby Height Predictor
//
//  Created by mallikarjun on 25/06/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class BabyHeightPredictorFormCell0: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class BabyHeightPredictorFormCell1: UITableViewCell {
    
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

class BabyHeightPredictorFormCell2: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var fatherHeightTextField: UITextField!
    @IBOutlet weak var motherHeightTextField: UITextField!
    
    var selectFatherHeightButton: UIButton!
    var selectMotherHeightButton: UIButton!
    
    //  @IBOutlet weak var calculateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectFatherHeightButton = UIButton(type: UIButton.ButtonType.system)
        let  TextFrame:CGRect = self.fatherHeightTextField.frame
        selectFatherHeightButton.frame = CGRect(x: TextFrame.origin.x, y: TextFrame.origin.y, width: TextFrame.size.width, height: TextFrame.size.height)
        selectFatherHeightButton.backgroundColor = .clear
        self.contentView.addSubview(selectFatherHeightButton)
        
        selectMotherHeightButton = UIButton(type: UIButton.ButtonType.system)
        let  TextFrame2:CGRect = self.motherHeightTextField.frame
        selectMotherHeightButton.frame = CGRect(x: TextFrame2.origin.x, y: TextFrame2.origin.y, width: TextFrame2.size.width, height: TextFrame2.size.height)
        selectMotherHeightButton.backgroundColor = .clear
        self.contentView.addSubview(selectMotherHeightButton)
        
        fatherHeightTextField.tag = 11
        motherHeightTextField.tag = 12
        
        fatherHeightTextField.text = ""
        motherHeightTextField.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class HeightSelectionPopUpCells: UITableViewCell {
    
    
    @IBOutlet weak var heightLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}


class HeightSelectionPopUpCell1: UITableViewCell {

    
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
