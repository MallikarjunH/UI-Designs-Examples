//
//  UIColorHex.swift
//  calorie-counter
//
//  Created by Sabin on 21/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
    
    convenience init(hex hexString: String) {
        var string = hexString
        if hexString.first == "#" {
            string = hexString.substring(from: 1, lenght: hexString.count - 1) ?? ""
        }
        guard
            string.count == 6,
            let hexInt = Int(string, radix: 16)
            else {
                self.init(hex: 0xFFFFFF)
                return
        }
        self.init(hex: hexInt)
    }
}
