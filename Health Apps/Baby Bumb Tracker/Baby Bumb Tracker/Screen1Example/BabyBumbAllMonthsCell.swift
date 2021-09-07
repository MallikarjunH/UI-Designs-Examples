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
    

        
    }
}
