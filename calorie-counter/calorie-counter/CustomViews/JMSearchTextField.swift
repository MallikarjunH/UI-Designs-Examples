//
//  JMSearchTextField.swift
//  calorie-counter
//
//  Created by Sabin on 28/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import Foundation
import UIKit

class JMSearchTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0)
    let iconLeftPadding = 40
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupField()
    }
    
    // text padding
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
        layer.cornerRadius = frame.size.height/3
        layer.borderColor = Colors.grey.cgColor
        layer.borderWidth = 1.0
        tintColor = Colors.black
        autocorrectionType = .no
        clipsToBounds = true
        
        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: Colors.grey])
        
        leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "ic_search_black.png")
        imageView.image = image
        
        let viewPadding = UIView(frame: CGRect(x: 0, y: 0, width: iconLeftPadding , height: Int(frame.size.height)))
        
        imageView.center = viewPadding.center
        viewPadding.addSubview(imageView)
        
        leftView = viewPadding
        
    
    }
}
