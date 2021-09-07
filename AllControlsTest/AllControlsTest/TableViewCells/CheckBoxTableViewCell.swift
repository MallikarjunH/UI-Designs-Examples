//
//  CheckBoxTableViewCell.swift
//  AllControlsTest
//
//  Created by EOO61 on 17/03/21.
//

import UIKit

class CheckBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxImg: UIImageView!
    
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
