//
//  BodyFatCalculatorResultCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 19/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class BodyFatCalculatorResultCell1: UITableViewCell {

    
    @IBOutlet weak var mainCardView: UIView!
    
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var fitnessResultLabel: UILabel!
    @IBOutlet weak var fitnessResultImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainCardView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class BodyFatCalculatorResultCell2: UITableViewCell {

    @IBOutlet weak var resultDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        resultDescriptionLabel.lineBreakMode = .byWordWrapping
        
     /*   let attributedString = NSMutableAttributedString(string: "Your text")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0.3
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString */
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class BodyFatCalculatorResultCell3: UITableViewCell {
    
    
    @IBOutlet weak var test: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class BodyFatCalculatorResultCell4: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}


