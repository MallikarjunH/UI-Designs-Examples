//
//  GlobalVariables.swift
//  Faveo Helpdesk Community
//
//  Created by Mallikarjun on 06/01/19.
//  Copyright © 2019 Ladybird Web Solution. All rights reserved.
//

import Foundation

class GlobalVariables {
    
    var firstName:String?
    var lastName:String?

    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
}



