//
//  GlobalVariables.swift
//  FacilityBooking
//
//  Created by mallikarjun on 02/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import Foundation

class GlobalVariables {
    
   
    var selectedSlotsArrayForClub:[String] = []
    var selectedSlotsArrayForTennisCourt:[String] = []
    
    
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
    
  
    
  
    
}
