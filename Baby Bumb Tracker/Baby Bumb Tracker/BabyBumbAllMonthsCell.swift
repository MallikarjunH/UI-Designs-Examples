//
//  BabyBumbAllMonthsCell.swift
//  Baby Bumb Tracker
//
//  Created by mallikarjun on 03/07/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class BabyBumbAllMonthsCell: UICollectionViewCell {
    
    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var frontImgLadyIcon: UIImageView!

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       mainBGView.layer.cornerRadius = 2
    
      //Gradient View UI Setup
        
//        gradientView.clipsToBounds = true
//        let gradientLayer0 = CAGradientLayer()
//        gradientLayer0.frame = gradientView.bounds
//        gradientLayer0.colors = [UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1).cgColor, UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.82).cgColor, UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1).cgColor]
//        gradientLayer0.locations = [1, 1, 0]
//        gradientView.layer.addSublayer(gradientLayer0)
//        gradientView.alpha = 0.38
        
    }
}
