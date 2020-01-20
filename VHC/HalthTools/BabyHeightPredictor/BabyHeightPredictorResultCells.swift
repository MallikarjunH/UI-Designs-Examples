//
//  BabyHeightPredictorResultCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 20/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class BabyHeightPredictorResultCell1: UITableViewCell {

    
    @IBOutlet weak var mainCardView: UIView!
   
    @IBOutlet weak var predictedHeightForYourChildLabel: UILabel!
    @IBOutlet weak var predictedHeightLabel: UILabel!
    @IBOutlet weak var predictedHeightDetailsLabel: UILabel!
    
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

class BabyHeightPredictorResultCell2: UITableViewCell {
    
    @IBOutlet weak var heightPredictorResultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        heightPredictorResultLabel.lineBreakMode = .byWordWrapping
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


