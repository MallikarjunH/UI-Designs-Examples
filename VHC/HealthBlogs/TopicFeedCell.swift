//
//  TopicFeedCell.swift
//  VidalHealth
//
//  Created by swathi.nandy on 24/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class TopicFeedCell: UITableViewCell {
 @IBOutlet weak var feedView: UIView!
@IBOutlet weak var feedImage: UIImageView!
    
 @IBOutlet weak var feedTitleLabel: UILabel!
 @IBOutlet weak var doctorNameLabel: UILabel!
 @IBOutlet weak var dateLabel: UILabel!
    
@IBOutlet weak var likeButton: UIButton!
@IBOutlet weak var likesCountLabel: UILabel!
@IBOutlet weak var dateButton: UIButton!
@IBOutlet weak var dateCountLabel: UILabel!
 
@IBOutlet weak var tagButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.feedView.backgroundColor = .white
        self.feedView.layer.cornerRadius = 8
        self.feedView.layer.borderWidth = 0
        //self.feedView.layer.borderColor = UIColor.white
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
