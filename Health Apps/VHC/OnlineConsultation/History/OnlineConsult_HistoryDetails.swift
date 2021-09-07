//
//  OnlineConsult_HistoryDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 25/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class OnlineConsult_HistoryDetails: UIViewController {
    
    var consultationSlug:String = ""
    var consultationType:String = ""
    
    var doctorName:String = ""
    var doctorProfilePic:String = ""
    var doctorQualification:String = ""
    var doctorSpeciality:String = ""
    var consultationTime:String = ""
    
    var patientName:String = ""
    var patientMobileNumber:String = ""
    var patientEmail:String = ""
    
    @IBOutlet weak var cardBGView: UIView!
    @IBOutlet weak var doctorsImageView: UIImageView!
    @IBOutlet weak var doctorsNameLabel: UILabel!
    @IBOutlet weak var doctorsSpecialityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var consultationTypeImage: UIImageView! //OC_Call_White,OC_Video_White,OC_Chat_White //Text Consultation //Video Consultation //Audio Consultation
    @IBOutlet weak var consultationTypeLabelForTalkNow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardBGView.layer.cornerRadius = 5.0
        doctorsImageView.layer.cornerRadius = doctorsImageView.frame.height/2
        doctorsImageView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        
        updateDoctorsDetails()
        getConsultationDetailsAPICall()
    }
    
    //MARK: Update Doctors UI
    func updateDoctorsDetails()
    {
        
        if self.doctorName == ""{
            self.consultationTypeLabelForTalkNow.isHidden = false
            self.doctorsImageView.isHidden = true
            self.doctorsNameLabel.isHidden = true
            self.doctorsSpecialityLabel.isHidden = true
            self.timeLabel.isHidden = true
        }
        else{
            self.consultationTypeLabelForTalkNow.isHidden = true
            self.doctorsImageView.isHidden = false
            self.doctorsNameLabel.isHidden = false
            self.doctorsSpecialityLabel.isHidden = false
            self.timeLabel.isHidden = false //show time or doctorQualification
            
            self.doctorsNameLabel.text = doctorName
            self.doctorsSpecialityLabel.text = doctorSpeciality
            self.timeLabel.text = doctorQualification //show time or doctorQualification
            
        }
        
        if consultationType == "Phone"{
            
            self.consultationTypeImage.image = UIImage(named: "OC_Call_White")
            self.consultationTypeLabelForTalkNow.text = "Audio Consultation"
            self.title = "Phone Consultation"
        }
        else if consultationType == "Video"{
            self.consultationTypeImage.image = UIImage(named: "OC_Video_White")
            self.consultationTypeLabelForTalkNow.text = "Video Consultation"
            self.title = "Video Consultation"
        }
        else{ //text
            self.consultationTypeImage.image = UIImage(named: "OC_Chat_White")
            self.consultationTypeLabelForTalkNow.text = "Text Consultation"
            self.title = "Text Consultation"
        }
        
        if self.doctorProfilePic != ""{
            AppUtilitiesSwift.getData(from: self.doctorProfilePic as String) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.doctorsImageView.image = UIImage(data: data)
                }
            }
        }
        else{
            self.doctorsImageView.image = UIImage(named: "avatar_doc.png")
        }
        
    }
    
    
    //MARK: Get Consultation Details API Call
    func getConsultationDetailsAPICall() {
        
        ProgressHUD.show("Loading...")
        
        let apiString = kGetTelemedConsultationDetails + "\(self.consultationSlug)"
        let params:[String:Any] = [:]
        
        APIRequester_New.fireGetMethod(URLString: apiString, aParams: params as [AnyHashable : Any]) { response ,error in
            
            if ((response as NSObject?)?.value(forKey: "SUCCESS") as? NSNumber)?.boolValue ?? false {
                
                //self.onlineConsultationListArray = []
                
                if let responseDataDict = (response as NSObject?)?.value(forKey: "consultation_list") as? [String:Any] {
                    
                    //Consultation Details
                    if let consultationDetailsDict:[String:Any] = responseDataDict["consultation_details"] as? [String:Any] {
                        
                        if let patientDataDict:[String:Any] = consultationDetailsDict["patient_id"] as? [String:Any] {
                            
                            let patientName:String = patientDataDict["full_name"] as? String ?? "No Name"
                           // let patientEmail:String = patientDataDict["email"] as? String ?? "No Email"
                           // let patientMobile:String = patientDataDict["mobile"] as? String ?? "No Mobile Number"
                            
                            self.patientName = patientName
                           // self.patientEmail = patientEmail
                           // self.patientMobileNumber = patientMobile
                        }
                        else{
                            //patient_id is not found
                        }
                        
                    }
                    else{
                        // not contains consultation_details key in responseDataDict
                    }
                    
                    //Patient Health Information
                    //if let patientHealthInformationDataArray:[[String:Any]] = responseDataDict["consultation_details"] as? [[String:Any]]
                    if let patientHealthInformationDataArray:[[String:Any]] = responseDataDict["patient_health_information"] as? [[String:Any]]{
                        
                        print("Patient Health Information Data -Present")
                        print("Patient Health Info: \(patientHealthInformationDataArray)")
                    }
                    else{
                        print("Patient Health Information Data - Not Present")
                    }
                    
                    //Patient Records
                    if let patientRecords:[[String:Any]] = responseDataDict["patient_records"] as? [[String:Any]] {
                        
                        print("Patient Records - Files - Present")
                        print("Patient Records: \(patientRecords)")
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "usersUploadedDocuments"), object: nil, userInfo: ["userData":patientRecords])
                        
                    }
                    else{
                         print("Patient Records - Files - Not Present")
                    }
                    
                    //Text Consultations Chat
                    if let textConsultationsChat:[[String:Any]] = responseDataDict["text_consultations_chat"] as? [[String:Any]] {
                        
                        print("Text Consultation chat - Present")
                        print("Text Consultation Chat Data: \(textConsultationsChat)")
                    }
                    else{
                        print("Text Consultation chat - Not Present")
                    }
                    
                    ProgressHUD.dismiss()
                }
                else{
                    // consultation_list key not present
                }
                
                ProgressHUD.dismiss()
            }
            else{
                //failure
                
                ProgressHUD.dismiss()
            }
            
        }
        
    }
    
    //MARK: Naviagtion Buttons actions
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func seachButtonClicked(_ sender: Any) {
        
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
