//
//  JMAuthTextField.swift
//  calorie-counter
//
//  Created by Sabin on 21/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import Foundation
import UIKit

class JMAuthTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupField()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func setupField() {
        borderStyle = .roundedRect
        layer.cornerRadius = frame.size.height/2
        layer.borderColor = Colors.grey.cgColor
        layer.borderWidth = 1.0
        tintColor = Colors.black
        autocorrectionType = .no
        clipsToBounds = true
        
        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: Colors.grey])
    }
}
