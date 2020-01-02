//
//  FacilityBookingCells.swift
//  FacilityBooking
//
//  Created by mallikarjun on 02/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import UIKit

class FacilityBookingTableViewCell: UITableViewCell {

    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var facilityImage: UIImageView!
    @IBOutlet weak var facilityNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainBGView.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class TimeSelectionCollectionCell: UICollectionViewCell{

    @IBOutlet weak var timeButton: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let greyColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.TEXT_GREY_COLOR)
        
        timeButton.layer.borderColor = greyColor.cgColor
        timeButton.layer.borderWidth = 2
        timeButton.titleLabel?.textColor = greyColor
        
    }


}
