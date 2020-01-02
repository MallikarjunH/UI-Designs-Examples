//
//  AppUtilitiesSwift.swift
//  FacilityBooking
//
//  Created by mallikarjun on 02/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import UIKit

class AppUtilitiesSwift: NSObject {

    
    //MARK: - hexa colors
    static let BUTTON_GREEN_COLOR = "#72bf43"
    static let TEXT_GREY_COLOR = "#4a4a4a"
    static let BUTTON_GREY_COLOR = "#bcc0d0"
    static let RED_COLOR = "#ef2121"
    static let LIGHT_GREY_BACKGROUND_COLOR = "#f3f4f8"
    
    
    static let sharedUtilityInstance: AppUtilitiesSwift? = {
        var instance = AppUtilitiesSwift()
        return instance
    }()
    
    class func sharedUtility() -> AppUtilitiesSwift? {
        return sharedUtilityInstance
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor {
           var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
           
           if (cString.hasPrefix("#")) {
               cString.remove(at: cString.startIndex)
           }
           
           if ((cString.count) != 6) {
               return UIColor.gray
           }
           
           var rgbValue:UInt32 = 0
           Scanner(string: cString).scanHexInt32(&rgbValue)
           
           return UIColor(
               red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
               green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
               blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
               alpha: CGFloat(1.0)
           )
       }
    
    class  func showAlert(title:String, message:String, vc: UIViewController) {
        
        let alertView1 = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView1.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        vc.present(alertView1,animated: true,completion: nil)
    }
    

}
