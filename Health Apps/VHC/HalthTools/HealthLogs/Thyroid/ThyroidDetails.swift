//
//  ThyroidDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 22/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class ThyroidDetails: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.moveToLogDetailedView(notification:)), name: Notification.Name("selectedLogTabFromThyroid"), object: nil)
    }
    
    @objc func moveToLogDetailedView(notification: Notification) {
        
        GlobalVariables.sharedManager.fromVCNameInHealthBlogs = "viewMode"
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "ThyroidEditDetailsId") as? ThyroidEditDetails
        self.navigationController?.pushViewController(detailsVC!, animated: true)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("selectedLogTabFromThyroid"), object: nil)
    }
    
    //MARK: Naviagtion and Bottpm Buttons
    
    @IBAction func backButtonClicked(_ sender: Any) {
    
         self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func notificationButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let notificationVC = storyBoard.instantiateViewController(withIdentifier: "Notifications") as! Notifications
        if ((self.navigationController?.topViewController?.isKind(of: Notifications.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
   
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
    
    @IBAction func plusButtonClicked(_ sender: Any) {
   
        GlobalVariables.sharedManager.fromVCNameInHealthBlogs = "editMode"
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "ThyroidEditDetailsId") as? ThyroidEditDetails
        self.navigationController?.pushViewController(detailsVC!, animated: true)
    }
    
}
