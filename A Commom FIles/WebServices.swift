//
//  WebServices.swift
//  Faveo Helpdesk Advance
//
//  Created by Mallikarjun on 05/01/19.
//  Copyright © 2019 Ladybird Web Solution. All rights reserved.
//


import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class webConstant:NSObject
{
    //    static let authenticate = "authenticate"
    //
    //    static let createTicket = "helpdesk/create"
    //    static let replyTicket = "helpdesk/reply"
}

public  func showAlert(title:String, message:String, vc: UIViewController) {
    
    let alertView1 = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertView1.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
    vc.present(alertView1,animated: true,completion: nil)
}

public func tokenRefreshMethod()
{
    let userDefaults = UserDefaults.standard
    
    var url:String = UserDefaults.standard.string(forKey: "baseURL") ?? ""
    url.append("api/v1/authenticate")
    
    let userName:String = UserDefaults.standard.string(forKey: "userNameValue") ?? ""
    let passWord:String = UserDefaults.standard.string(forKey: "passwordValue") ?? ""
    
    requestPOSTURL(url, params: ["username":userName as AnyObject,
                                 "password":passWord as AnyObject], success: { (data) in
                                    
                                    
                                    // print("JSON is: ",data)
                                    print("I am in Token Refresh Method in WebServices File")
                                    
                                    if data["error"].exists() {
                                        // failure case
                                        
                                        let msg = data["error"].stringValue
                                        print("Message is: ",msg)
                                        
                                        userDefaults.set(msg, forKey: "valueFromRefreshToken")
                                        
                                    }
                                        
                                    else if data["token"].exists() && data["user_id"].exists(){
                                        
                                        //success case
                                        let userIdValue = data["user_id"]["id"].intValue
                                        userDefaults.set(userIdValue, forKey: "userId")
                                        
                                        var firstName =  data["user_id"]["first_name"].stringValue
                                        let lastName  =  data["user_id"]["last_name"].stringValue
                                        firstName.append(" ")
                                        firstName.append(lastName)
                                        
                                        let email     =  data["user_id"]["email"].stringValue
                                        let profilePicture =  data["user_id"]["profile_pic"].stringValue
                                        let tokenValue = data["token"].stringValue
                                        
                                        userDefaults.set(firstName, forKey: "userFullName")
                                        userDefaults.set(email, forKey: "userEmail")
                                        userDefaults.set(profilePicture, forKey: "userProfilePic")
                                        userDefaults.set(tokenValue, forKey: "token")
                                        
                                        userDefaults.synchronize()
                                    } //end if case of success
                                    
    }) { (error) in
        print("Error From Token Refresh Method: \(error.localizedDescription)")
        //Example: After timeout error - The request timed out.
        SVProgressHUD.dismiss()
    }
    
}

public func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
    
    if Connectivity.isConnectedToInternet {
        
        // SVProgressHUD.show()
        Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { responseObject in
            
            
            // print(responseObject.request!)
            
            if responseObject.result.isSuccess {
                //  SVProgressHUD.dismiss()
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                //  SVProgressHUD.dismiss()
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }else{
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Hero Habit", message: "Please,check your internet connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
    }
}

public func requestGETURL(_ strURL: String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
    
    if Connectivity.isConnectedToInternet {
        // SVProgressHUD.show()
        
        
        Alamofire.request(strURL, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { (responseObject) -> Void in
            
            //  print(responseObject)
            
            if responseObject.result.isSuccess {
                //    SVProgressHUD.dismiss()
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                //    SVProgressHUD.dismiss()
                let error : Error = responseObject.result.error!
                failure(error)
                
            }
        }
    }else{
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Faveo Helpdesk", message: "Please check your internet connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
}

