//
//  HeathLogs_HealthRecords.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class HeathLogs_HealthRecords: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
     var recordsImgTypeArray = ["bloodPressure", "bloodSugar", "thyroid", "lipidProfile"]
     var recordsTitleArray = ["Blood Pressure", "Blood Sugar", "Thyroid", "Lipid Profile"]
     var recordsSubTitleArray = ["BP, Heartrate", "FBS, RBS, PPBS, HBA1C", "T3, TSH, T4", "LDL, HDL"]
    
    @IBOutlet weak var mainTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recordsTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "HealthRecordsListCellId", for: indexPath) as! HealthRecordsListCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        cell.healthRecordImg.image = UIImage(named: recordsImgTypeArray[indexPath.row])
        cell.healthRecordTitleLabel.text = recordsTitleArray[indexPath.row]
        cell.healthRecordSubTitleLabel.text = recordsSubTitleArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // print(indexPath.row)
        if indexPath.row == 0{ // Blood Pressure
           
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let detailsVC = storyBoard.instantiateViewController(withIdentifier: "BloodPressureDetailsId") as? BloodPressureDetails
            GlobalVariables.sharedManager.fromVCNameInHealthBlogs = ""
            self.navigationController?.pushViewController(detailsVC!, animated: true)

        }else if indexPath.row == 1{ // Blood Sugar
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let detailsVC = storyBoard.instantiateViewController(withIdentifier: "BloodSugarDetailsId") as? BloodSugarDetails
            GlobalVariables.sharedManager.fromVCNameInHealthBlogs = ""
            self.navigationController?.pushViewController(detailsVC!, animated: true)
            
        }else if indexPath.row == 2{ // Thyroid
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let detailsVC = storyBoard.instantiateViewController(withIdentifier: "ThyroidDetailsId") as? ThyroidDetails
            GlobalVariables.sharedManager.fromVCNameInHealthBlogs = ""
            self.navigationController?.pushViewController(detailsVC!, animated: true)
            
        }else{ // Lipid Profile
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let detailsVC = storyBoard.instantiateViewController(withIdentifier: "LipidProfileDetailsId") as? LipidProfileDetails
            GlobalVariables.sharedManager.fromVCNameInHealthBlogs = ""
            self.navigationController?.pushViewController(detailsVC!, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 115.0
    }
    
    //MARK: Navigation and Bottom Buttons
    
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
    
    
    @IBAction func emergencyButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(emergencyVC, animated: true)
        }
    }
    
}
