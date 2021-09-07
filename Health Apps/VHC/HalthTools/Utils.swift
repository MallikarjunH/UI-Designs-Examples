//
//  Utils.swift
//  VidalHealth
//
//  Created by mallikarjun on 22/08/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import Foundation


//MARK: Alert method with title and message
public  func showAlert(title:String, message:String, vc: UIViewController) {
    
    let alertView1 = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertView1.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
    vc.present(alertView1,animated: true,completion: nil)
}


public func getDataFromImage(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {

    let imgURL = URL(string: url)
    
    URLSession.shared.dataTask(with: imgURL!, completionHandler: completion).resume()
}


public func convertDateFormat(dobValue:String)-> String{ // cell.lblData.text = dateFormat(dobValue: dateOfBirth)
    
    var dateValue:String?
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    let date: Date? = format.date(from: dobValue)
    format.dateFormat = "dd/MM/yyyy"   // MMM dd,yyyy"
    if let date = date {
        dateValue = format.string(from: date)
    }
    return dateValue ?? ""
    
}

public func convertDateFormat2(dobValue:String)-> String{ // cell.lblData.text = convertDateFormat2(dobValue: dateOfBirth)
    
    var dateValue:String?
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    let date: Date? = format.date(from: dobValue)
    format.dateFormat = "MMM dd, yyyy"
    if let date = date {
        dateValue = format.string(from: date)
    }
    return dateValue ?? ""
    
}
