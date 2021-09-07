//
//  RadioButtonTableViewCell.swift
//  AllControlsTest
//
//  Created by EOO61 on 17/03/21.
//

import UIKit

class RadioButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var radioImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
