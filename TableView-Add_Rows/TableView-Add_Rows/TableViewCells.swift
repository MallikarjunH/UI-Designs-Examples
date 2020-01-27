//
//  TableViewCells.swift
//  TableView-Add_Rows
//
//  Created by mallikarjun on 27/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell1: UITableViewCell {
    
    @IBOutlet weak var fileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class TableViewCell2: UITableViewCell {
    

    @IBOutlet weak var addButton: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
