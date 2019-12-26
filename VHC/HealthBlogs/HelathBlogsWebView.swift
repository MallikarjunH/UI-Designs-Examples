//
//  HelathBlogsWebView.swift
//  VidalHealth
//
//  Created by mallikarjun on 19/08/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import WebKit

class HelathBlogsWebView: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButtonView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         backButtonView.isHidden = true
         webView.backgroundColor = UIColor.white
        
        if DBHandler.appDelegateShared().isConnectedToNetwork().rawValue != 0
        {
            ProgressHUD.show("Loading...")
            loadBlogs()
        }else{
            //showAlert(title: "No Internet Connection", message: "Make sure that Wi-Fi or mobile data is turned on, then try again.", vc: self)
            // ProgressHUD.dismiss()
        }
        
    }
    

    func loadBlogs(){
        //let url = URL (string: "http://10.1.7.94:8000/vidal-web-app")  
        let url = URL (string: "https://vidalhealth.com/blog/")
        let myRequest = URLRequest(url: url!)
        webView.load(myRequest)
        //ProgressHUD.dismiss()
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            self.backButtonView.isHidden = false
            ProgressHUD.dismiss()
        }
    }
    
    
    @IBAction func backButtonToMainBlogsPage(_ sender: Any) {
        
        ProgressHUD.show("Loading...")
        let url = URL (string: "https://vidalhealth.com/blog/")
        let myRequest = URLRequest(url: url!)
        webView.load(myRequest)
        
        ProgressHUD.dismiss()
    }
    
    //MARK: Navigation Button Actions
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let searchVC: SearchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        if ((self.navigationController?.topViewController?.isKind(of: SearchViewController.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    @IBAction func notifficationButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let notificationVC = storyBoard.instantiateViewController(withIdentifier: "Notifications") as! Notifications
        if ((self.navigationController?.topViewController?.isKind(of: Notifications.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
    }

    
    @IBAction func emergencyCallButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(emergencyVC, animated: true)
        }
    }
    
}
