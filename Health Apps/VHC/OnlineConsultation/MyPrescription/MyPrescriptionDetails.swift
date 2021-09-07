//
//  MyPrescriptionDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 23/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class MyPrescriptionDetails: UIViewController {
    
    
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var consultByTextLabel: UILabel!
    @IBOutlet weak var consultByDoctorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var complaintsLabel: UILabel!
    @IBOutlet weak var companintsDetailsLabel: UILabel!
    
    @IBOutlet weak var impressionLabel: UILabel!
    @IBOutlet weak var impressionDetailsLabel: UILabel!
    
    @IBOutlet weak var adviseLabel: UILabel!
    @IBOutlet weak var adviseDetailsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        patientNameLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
        consultByTextLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        consultByDoctorNameLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        dateLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        
        complaintsLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
        impressionLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
        adviseLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
        
        companintsDetailsLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        impressionDetailsLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        adviseDetailsLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        
        companintsDetailsLabel.lineBreakMode = .byWordWrapping
        impressionDetailsLabel.lineBreakMode = .byWordWrapping
        adviseDetailsLabel.lineBreakMode = .byWordWrapping
        
    }
    
    
    //MARK: Navigation and Bottom Buttons Actions
    
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
    
    @IBAction func notificationButtonClicked(_ sender: Any) {
        
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
