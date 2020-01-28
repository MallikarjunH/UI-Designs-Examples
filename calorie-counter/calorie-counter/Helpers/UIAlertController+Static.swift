//
//  UIAlerController+Static.swift
//  divco
//
//  Created by Irina Butaru on 19/08/2019.
//  Copyright © 2019 Irina Butaru. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func simpleAlert(title: String,
                            message: String? = nil,
                            buttonTitle: String = "OK") -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle,
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        return alert
    }
}
