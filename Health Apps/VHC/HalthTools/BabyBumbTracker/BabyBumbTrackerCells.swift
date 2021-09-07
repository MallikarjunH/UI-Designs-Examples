//
//  BabyBumbTrackerCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 04/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

//BabyBumbTrackerCells

class BabyBumbTrackerMainCell: UICollectionViewCell {
    
    @IBOutlet weak var mainBGView: UIView!
    
    @IBOutlet weak var sampleFrontImage: UIImageView!
    @IBOutlet weak var mainBackgroundImage: UIImageView!
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var gradientImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainBGView.layer.cornerRadius = 2
    }
    
}

class BabyBumbTrackerDetailsCell1: UITableViewCell{
    
    @IBOutlet weak var mainBackgroundImage: UIImageView!
    @IBOutlet weak var sampleFrontImage: UIImageView!
    
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var monthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class BabyBumbTrackerDetailsCell2: UITableViewCell{
    
 //   @IBOutlet weak var headingLabel: UILabel!
  //  @IBOutlet weak var descriptionLabel: UILabel!
    
    //Title 1
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title1Description: UILabel!
    
    //Title 2
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title2Description: UILabel!
    
    //Title 3
    @IBOutlet weak var title3: UILabel!
    
    @IBOutlet weak var title3SubTitle1: UILabel!
    @IBOutlet weak var title3SubTitle1Description: UILabel!
    
    @IBOutlet weak var title3SubTitle2: UILabel!
    @IBOutlet weak var title3SubTitle2Description: UILabel!
    
    @IBOutlet weak var title3SubTitle3: UILabel!
    @IBOutlet weak var title3SubTitle3Description: UILabel!
    
    //Title 4
    @IBOutlet weak var title4: UILabel!
    @IBOutlet weak var title4Description: UILabel!
    
    //Title 5
    @IBOutlet weak var title5: UILabel!
    @IBOutlet weak var title5Description: UILabel!
    
    
    //Title 6
    @IBOutlet weak var title6: UILabel!
    
    @IBOutlet weak var title6SubTitle1: UILabel!
    @IBOutlet weak var title6SubTitle1Description: UILabel!
    
    @IBOutlet weak var title6SubTitle2: UILabel!
    @IBOutlet weak var title6SubTitle2Description: UILabel!
    
    @IBOutlet weak var title6SubTitle3: UILabel!
    @IBOutlet weak var title6SubTitle3Description: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      /*  headingLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70) */
        
       // title1Description.lineBreakMode = .byWordWrapping
       // title2Description.lineBreakMode = .byWordWrapping
        
       // title3SubTitle1Description.lineBreakMode = .byWordWrapping
       // title3SubTitle2Description.lineBreakMode = .byWordWrapping
       // title3SubTitle3Description.lineBreakMode = .byWordWrapping
        
       // title4Description.lineBreakMode = .byWordWrapping
       // title5Description.lineBreakMode = .byWordWrapping
        
       // title6SubTitle1Description.lineBreakMode = .byWordWrapping
       // title6SubTitle2Description.lineBreakMode = .byWordWrapping
       // title6SubTitle3Description.lineBreakMode = .byWordWrapping
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
