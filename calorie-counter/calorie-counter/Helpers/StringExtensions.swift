//
//  StringExtensions.swift
//  calorie-counter
//
//  Created by Sabin on 22/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import Foundation

extension String {
    var isNumeric: Bool {
        return Int(self) != nil
    }
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func substring(from start: Int, lenght: Int) -> String? {
        guard
            start >= 0,
            start + lenght <= count
            else {
                return nil
        }
        
        let substringStartIndex = self.index((self.startIndex), offsetBy:start)
        let endIndex = self.index((self.startIndex), offsetBy:start + lenght)
        return String(self[substringStartIndex..<endIndex])
    }
    
    func contains(_ substring: String, caseSensitive: Bool = true) -> Bool {
        if caseSensitive {
            return self.range(of: substring) != nil
        } else {
            return self.range(of: substring, options: .caseInsensitive) != nil
        }
    }
    
}
