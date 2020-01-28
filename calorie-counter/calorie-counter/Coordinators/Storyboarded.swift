//
//  Storyboarded.swift
//  calorie-counter
//
//  Created by Sabin on 22/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import Foundation
import UIKit

///**
// *  use for using ViewControllers from a Storyboard
// *  storyboard id = class name
// */
//protocol Storyboarded {
//    static func instantiate(storyboardName: String) -> Self
//}
//
//// ex: storyboardName = "Auth", "Main"
//extension Storyboarded where Self: UIViewController {
//    static func instantiate(storyboardName: String) -> Self {
//        let id = String(describing: self)
//        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
//        return storyboard.instantiateViewController(withIdentifier: id) as! Self
//    }
//}

protocol Storyboarded {
    static var storyboardName: String { get }
    static func instantiate() -> Self
}
extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
