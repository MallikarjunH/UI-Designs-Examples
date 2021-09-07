//
//  OnlineConsult_HistoryList.swift
//  VidalHealth
//
//  Created by mallikarjun on 25/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class OnlineConsult_HistoryList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var consultationSlugArray:[String] = []
    var consultationTypeArray:[String] = []
    var consultationStatusArray:[String] = []
    var consultationCreatedAtArray:[String] = []
    var consultationStatusMsgArray:[String] = []
    var consultationFinalAmountArray:[Int] = []
    
    var doctorsNameArray:[String] = []
    var doctorsProfilePicArray:[String] = []
    var doctorsQualificationArray:[String] = []
    var doctorsSpecialityArray:[String] = []
    
    var onlineConsultationListArray:[[String:Any]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.getAllOnlineConsultationListsAPICall()
    }
    
    
    //MARK: Get All Online Consultations
    
    func getAllOnlineConsultationListsAPICall(){
        
        ProgressHUD.show("Loading...")
        
        let params:[String:Any] = [:]
        
        APIRequester_New.fireGetMethod(URLString: kGetAllTelemedConsultationsAPIPath, aParams: params as [AnyHashable : Any]) { response ,error in
            
            if ((response as NSObject?)?.value(forKey: "SUCCESS") as? NSNumber)?.boolValue ?? false {
                
                self.onlineConsultationListArray = []
                
                if let responseDataArray = (response as NSObject?)?.value(forKey: "consultation_list") as? [[String:Any]] {
                    
                    self.onlineConsultationListArray = responseDataArray
                    
                    if responseDataArray.count > 0{
                        
                        print("Array count is: \(responseDataArray.count)")
                        
                        self.consultationSlugArray = []
                        self.consultationTypeArray = []
                        self.consultationStatusArray = []
                        self.consultationCreatedAtArray = []
                        self.consultationStatusMsgArray = []
                        self.consultationFinalAmountArray = []
                        
                        self.doctorsNameArray = []
                        self.doctorsProfilePicArray = []
                        self.doctorsQualificationArray = []
                        self.doctorsSpecialityArray = []
                        
                        for keywordsDict:Dictionary<String,Any> in responseDataArray{
                            
                            let consultation_Slug:String = keywordsDict["consultation_slug"] as? String ?? ""
                            let consultation_Type:String = keywordsDict["consultation_type"] as? String ?? ""
                            let consultation_Status:String = keywordsDict["consultation_status"] as? String ?? ""
                            let consultation_Created_At:String = keywordsDict["created_at"] as? String ?? ""
                            let consultation_Status_Msg:String = keywordsDict["status_message"] as? String ?? ""
                            let consultation_Final_Amount:Int = keywordsDict["final_payment_amount"] as? Int ?? 0
                            
                            self.consultationSlugArray.append(consultation_Slug)
                            self.consultationTypeArray.append(consultation_Type)
                            self.consultationStatusArray.append(consultation_Status)
                            self.consultationCreatedAtArray.append(consultation_Created_At)
                            self.consultationStatusMsgArray.append(consultation_Status_Msg)
                            self.consultationFinalAmountArray.append(consultation_Final_Amount)
                            
                            if let doctorsDataDict = keywordsDict["specialist_id"] as? NSDictionary {
                                
                                let doctorName:String = doctorsDataDict["full_name"] as? String ?? ""
                                let doctorProfilePic:String = doctorsDataDict["profile_pic_thumbnail"] as? String ?? ""
                                let doctorsQualification:String = doctorsDataDict["qualifications"] as? String ?? ""
                                let doctorsSpciality:String = doctorsDataDict["specialist_type"] as? String ?? ""
                                
                                self.doctorsNameArray.append(doctorName)
                                self.doctorsProfilePicArray.append(doctorProfilePic)
                                self.doctorsQualificationArray.append(doctorsQualification)
                                self.doctorsSpecialityArray.append(doctorsSpciality)
                            }
                            else{ // specialist_id not found or specialist_id is not dictionary type
                                
                            }
                            // self.searchLabelsArray.append(searchValue)
                        }
                        
                    }
                    else{
                        print("Array is empty") //show no concusltaiton found
                    }
                    
                    DispatchQueue.main.async {
                        self.mainTableView.reloadData()
                    }
                }
                else{
                    // consultation_list key not found
                }
                ProgressHUD.dismiss()
            }
            else{
                //show alert bcoz SUCCESS == 0
                showAlert(title: "Error", message: "Something went wrong", vc: self)
                ProgressHUD.dismiss()
            }
            
        }
        
        // ProgressHUD.dismiss()
    }
    
    
    //MARK: TableView Datasource and Delegate mehtods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return 2
        return self.onlineConsultationListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "OnlineConsultHistoryListCellId", for: indexPath) as! OnlineConsultHistoryListCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        if self.doctorsNameArray[indexPath.row] != "" {
            cell.doctorNameLabel.text = self.doctorsNameArray[indexPath.row]
            cell.labelForTalkNow.text = ""
            cell.doctorImageView.isHidden = false
            cell.timeLabel.isHidden = false
        }
        else{
            cell.doctorNameLabel.text = ""
            cell.labelForTalkNow.text = "Assigning a Specialist. You will be notified once the specialist has been assigned."
            cell.doctorImageView.isHidden = true
            cell.timeLabel.isHidden = true
        }
        // cell.doctorNameLabel.text = self.doctorsNameArray[indexPath.row]
        
        cell.doctorsSpecialityLabel.text = self.doctorsSpecialityArray[indexPath.row]
        cell.timeLabel.text = self.consultationCreatedAtArray[indexPath.row]
        
        cell.feeLabel.text = "₹\(self.consultationFinalAmountArray[indexPath.row])"
        
        let consultationType = self.consultationTypeArray[indexPath.row]
        
        if consultationType == "Phone"{
            
            cell.consultationTypeImage.image = UIImage(named: "opt_phone_icon")
        }
        else if consultationType == "Video"{
            cell.consultationTypeImage.image = UIImage(named: "opt_video_icon")
        }
        else{ //text
            cell.consultationTypeImage.image = UIImage(named: "opt_text_icon")
        }
        
        if self.doctorsProfilePicArray[indexPath.row] != ""{
            AppUtilitiesSwift.getData(from: self.doctorsProfilePicArray[indexPath.row] as String) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    cell.doctorImageView.image = UIImage(data: data)
                }
            }
        }
        else{
            cell.doctorImageView.image = UIImage(named: "avatar_doc.png")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(indexPath.row)
        let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
        let historyDetails = storyBoard.instantiateViewController(withIdentifier: "OnlineConsult_HistoryDetailsId") as? OnlineConsult_HistoryDetails
        
        if (navigationController?.topViewController is OnlineConsult_HistoryDetails) {
            
            return
        }else {
            
            historyDetails?.consultationSlug =  self.consultationSlugArray[indexPath.row]
            historyDetails?.consultationType =  self.consultationTypeArray[indexPath.row]
            
            historyDetails?.doctorName =  self.doctorsNameArray[indexPath.row]
            historyDetails?.doctorProfilePic =  self.doctorsProfilePicArray[indexPath.row]
            historyDetails?.doctorSpeciality =  self.doctorsSpecialityArray[indexPath.row]
            historyDetails?.doctorQualification =  self.doctorsQualificationArray[indexPath.row]
            
            navigationController?.pushViewController(historyDetails!, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 145.0
    }
    
    //MARK: Navigation buttons actions
    
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
