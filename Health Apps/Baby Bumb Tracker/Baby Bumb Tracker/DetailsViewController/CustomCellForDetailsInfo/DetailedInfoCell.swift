//
//  DetailedInfoCell.swift
//  Baby Bumb Tracker
//
//  Created by mallikarjun on 08/08/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class DetailedInfoCell: UITableViewCell {

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
        
        title1Description.lineBreakMode = .byWordWrapping
        title2Description.lineBreakMode = .byWordWrapping
        
        title3SubTitle1Description.lineBreakMode = .byWordWrapping
        title3SubTitle2Description.lineBreakMode = .byWordWrapping
        title3SubTitle3Description.lineBreakMode = .byWordWrapping
        
        title4Description.lineBreakMode = .byWordWrapping
        title5Description.lineBreakMode = .byWordWrapping
        
        title6SubTitle1Description.lineBreakMode = .byWordWrapping
        title6SubTitle2Description.lineBreakMode = .byWordWrapping
        title6SubTitle3Description.lineBreakMode = .byWordWrapping
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
