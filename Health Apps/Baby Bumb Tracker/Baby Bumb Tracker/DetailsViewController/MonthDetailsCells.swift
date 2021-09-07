//
//  MonthDetailsCells.swift
//  Baby Bumb Tracker
//
//  Created by mallikarjun on 04/07/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class MonthDetailsCell1: UITableViewCell {

    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var demoImageView: UIImageView!
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class MonthDetailsCell2: UITableViewCell {
    
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        headingLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
