//
//  CollectionViewCell2.swift
//  Baby Bumb Tracker
//
//  Created by mallikarjun on 04/07/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class CollectionViewCell2: UICollectionViewCell {
    
    @IBOutlet weak var demoImage: UIImageView!
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var mainBGVIew: UIView!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainBGVIew.layer.cornerRadius = 2
        
    }
    
    
}
