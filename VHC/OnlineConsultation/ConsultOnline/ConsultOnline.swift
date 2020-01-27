//
//  ConsultOnline.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class ConsultOnline: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let titleNameArray = ["Consult Online","My Prescription","History"]
    let imageNameArray = ["consultOnline1","prescription1","history1"]
    
    
    @IBOutlet weak var upComingConsultationView: UIView!
    @IBOutlet weak var upComingConsultationViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateBannerViewHeight(notification:)), name: Notification.Name("updateBannerViewHeight"), object: nil)
        
        mainTableView.tableFooterView = UIView()
        
        upComingConsultationViewHeight.constant = 0
        
        //TODO:-unified
        let storyBoardBA: UIStoryboard = UIStoryboard.init(name: "BookAppointment", bundle: nil)
        let controller : MyTaskView = storyBoardBA.instantiateViewController(withIdentifier: "MyTaskView") as!
        MyTaskView
        controller.view.frame = CGRect(x:0, y:0, width:self.upComingConsultationView.frame.width, height:self.upComingConsultationView.frame.height)
        controller.callingFrom = kONLINECONSULTATION
        controller.updateUI()
        controller.willMove(toParentViewController: self)
        self.upComingConsultationView.addSubview(controller.view)
        self.addChildViewController(controller)
    }
    
    @objc func updateBannerViewHeight(notification: Notification)
    {
        if let dict = notification.userInfo as NSDictionary? {
            if let numberOfCells = dict["totalCellsInSegment"] as? String{
                if numberOfCells == "0"
                {
                    upComingConsultationViewHeight.constant = 0
                    upComingConsultationView.isHidden = true
                } else {
                    upComingConsultationViewHeight.constant = 150
                    upComingConsultationView.isHidden = false
                }
                
            }
        }
    }
    
    //MARK: TableView Data Source and Delegates methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultOnlineCell1Id", for: indexPath) as! ConsultOnlineCell1
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        cell.label.text = titleNameArray[indexPath.row]
        cell.image1.image = UIImage(named: imageNameArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 115.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // print(indexPath.row)
        
        if indexPath.row == 0{ // Consult Online
            
            let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
            let clinicListVC = storyBoard.instantiateViewController(withIdentifier: "ConsultOnlineClinicListsId") as? ConsultOnlineClinicLists
            GlobalVariables.sharedManager.clinicPermalink = ""
            
            if (navigationController?.topViewController is ConsultOnlineClinicLists) {
                return
            } else {
                navigationController?.pushViewController(clinicListVC!, animated: true)
            }
        }
        else if indexPath.row == 1{ // My Prescription
            
            let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
            let myPrescriptionsList = storyBoard.instantiateViewController(withIdentifier: "MyPrescriptionsListId") as? MyPrescriptionsList
            
            if (navigationController?.topViewController is MyPrescriptionsList) {
                
                return
            } else {
                navigationController?.pushViewController(myPrescriptionsList!, animated: true)
            }
            
        }
        else if indexPath.row == 2{ // History
            
            let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
            let historyList = storyBoard.instantiateViewController(withIdentifier: "OnlineConsult_HistoryListId") as? OnlineConsult_HistoryList
            
            if (navigationController?.topViewController is OnlineConsult_HistoryList) {
                
                return
            }else {
                navigationController?.pushViewController(historyList!, animated: true)
            }
        }
    }
    
    //MARK: Naviagtion Buttons
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
