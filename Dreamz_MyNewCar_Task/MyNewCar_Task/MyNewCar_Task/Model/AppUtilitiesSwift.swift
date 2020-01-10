//
//  AppUtilitiesSwift.swift
//  MyNewCar_Task
//
//  Created by mallikarjun on 10/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import Foundation
import UIKit

class AppUtilitiesSwift: NSObject {
    
   
 
    
    static let sharedUtilityInstance: AppUtilitiesSwift? = {
        var instance = AppUtilitiesSwift()
        return instance
    }()
    
    class func sharedUtility() -> AppUtilitiesSwift? {
        return sharedUtilityInstance
    }
    
    
    class func getData(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        let imageURL:String = url // valid
        
        let imgURL = URL(string: imageURL)
        
        URLSession.shared.dataTask(with: imgURL!, completionHandler: completion).resume()
    }
  
}


extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Roboto", size: 14)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
