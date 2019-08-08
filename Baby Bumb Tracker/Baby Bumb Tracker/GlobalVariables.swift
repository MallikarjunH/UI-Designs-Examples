//
//  GlobalVariables.swift
//  Baby Bumb Tracker
//
//  Created by mallikarjun on 08/08/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import Foundation

class GlobalVariables {
    
    //BBT
    var babyMonth:String?
    var babyMonth1Img:String?

    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
}
