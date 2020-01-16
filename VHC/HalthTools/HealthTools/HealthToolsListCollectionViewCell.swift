//
//  HealthToolsListCollectionViewCell.swift
//  VidalHealth
//
//  Created by mallikarjun on 14/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class HealthToolsListCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var itemImages: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var cellBGView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBGView.layer.cornerRadius = 5.0
    }
    
}
