//
//  ImageSignSelectionCell.swift
//  AddSign_3Modes
//
//  Created by EOO61 on 30/01/22.
//

import UIKit

class ImageSignSelectionCell: UITableViewCell {

    @IBOutlet weak var sampleBGView: UILabel!
    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var radioImageOutlet: UIImageView!
    @IBOutlet weak var signImageOutlet: UIImageView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sampleBGView.layer.cornerRadius = 3.0
        mainBGView.layer.cornerRadius = 5.0
        mainBGView.layer.borderWidth = 0.5
        mainBGView.layer.borderColor = UIColor.gray.cgColor
        mainBGView.clipsToBounds = true
        sampleBGView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
