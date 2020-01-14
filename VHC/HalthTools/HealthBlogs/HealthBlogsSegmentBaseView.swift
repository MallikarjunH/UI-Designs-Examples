//
//  HealthBlogsSegmentBaseView.swift
//  VidalHealth
//
//  Created by swathi.nandy on 24/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit



class HealthBlogsSegmentBaseView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         NotificationCenter.default.addObserver(self, selector: #selector(self.moveToFeedDetailedView(notification:)), name: Notification.Name("selectedFeedFromFeedTab"), object: nil)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonAction(sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func emergencyButtonAction(sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(emergencyVC, animated: true)
        }
    }
    
    @IBAction func notificationButtonAction(sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let notificationVC = storyBoard.instantiateViewController(withIdentifier: "Notifications") as! Notifications
        if ((self.navigationController?.topViewController?.isKind(of: Notifications.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
    }
    @IBAction func searchButtonAction(sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let searchVC: SearchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        if ((self.navigationController?.topViewController?.isKind(of: SearchViewController.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    @objc func moveToFeedDetailedView(notification: Notification) {
        
        let storyBoard = UIStoryboard.init(name: "HealthBlogs", bundle: nil)
        let healthBlog = storyBoard.instantiateViewController(withIdentifier: "Feed_Detailed_ViewController") as! Feed_Detailed_ViewController
        if ((self.navigationController?.topViewController?.isKind(of: Feed_Detailed_ViewController.classForCoder()))!) {
            return
        }
        else
        {
            self.navigationController?.pushViewController(healthBlog, animated: true)
        }
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("selectedFeedFromFeedTab"), object: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
