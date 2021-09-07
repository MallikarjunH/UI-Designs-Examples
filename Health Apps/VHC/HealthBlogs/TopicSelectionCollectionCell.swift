//
//  TopicSelectionCollectionCell.swift
//  VidalHealth
//
//  Created by swathi.nandy on 21/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class TopicSelectionCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var topicButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        topicButton.backgroundColor = .white
        topicButton.layer.cornerRadius = 8
        topicButton.layer.borderWidth = 2
       
        
        
       
    }
    
    
}


class FeedDetailedFirstCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


class FeedDetailedSecondCell: UITableViewCell {
    
    @IBOutlet weak var dataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


class FeedCommentsCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentsDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
