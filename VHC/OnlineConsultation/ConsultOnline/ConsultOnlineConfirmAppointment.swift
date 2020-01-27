//
//  ConsultOnlineConfirmAppointment.swift
//  VidalHealth
//
//  Created by mallikarjun on 05/12/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

@objcMembers class ConsultOnlineConfirmAppointment: UIViewController {
    
    
    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var maskViewImg: UIImageView!
    
    @objc var patientSlugValue:String = ""
    
    @objc var doctorName:String = ""
    @objc var doctorImage:String = ""
    @objc var doctorSpecility:String = ""
    @objc var doctorEducation:String = ""
    
    @objc var consultationTypeForOC:String = "" //audioConsult, videoConsult, textConsult
    @objc var consultationModeForOC:String = "" // talkNow , schedule , for text (schedule + textConsult )
    
    @objc var consultationReasonForOC:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainBGView.layer.cornerRadius = 5.0 //check
        maskViewImg.roundTop(radius: 5.0)
        
        // moneyLabel.text = GlobalVariables.sharedManager.onlineConsultationFees //"₹4000"
        // Do any additional setup after loading the view.
        
        self.updateConsultationFeesUI()
        
        // print("Consultation Type: \(GlobalVariables.sharedManager.consultationType)")
        // print("Is Talk Now : \(GlobalVariables.sharedManager.isCameForTalkNowOptionInOnlineConsult)")
        
    }
    
    func updateConsultationFeesUI(){
        
        moneyLabel.text = GlobalVariables.sharedManager.onlineConsultationFees
    }
    
    //MARK: Bottom and Navigation Buttons
    
    @IBAction func confirmAppointmentButtonClicked(_ sender: Any) {
        //naviagte to the payment page
        var consultationType = ""
        
        if  GlobalVariables.sharedManager.consultationType == "textConsult" {
            consultationType = "Text"
        }
        else if GlobalVariables.sharedManager.consultationType == "audioConsult" {
            consultationType = "Phone"
        }
        else if GlobalVariables.sharedManager.consultationType == "videoConsult" {
            consultationType = "Video"
        }
        
        var selectedScheduleForConsultation = "\(GlobalVariables.sharedManager.selectedDateForOnlineConsult) \(GlobalVariables.sharedManager.selectedTimeSlotForOnlineConsult)"
        if selectedScheduleForConsultation.hasSuffix(" pm"){
            selectedScheduleForConsultation = selectedScheduleForConsultation.replacingOccurrences(of: " pm", with: ":00")
        }
        else if selectedScheduleForConsultation.hasSuffix(" am"){
            selectedScheduleForConsultation = selectedScheduleForConsultation.replacingOccurrences(of: " am", with: ":00")
        }
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let payVC: PaymentScreen = storyBoard.instantiateViewController(withIdentifier: "PaymentScreen") as! PaymentScreen
        if ((self.navigationController?.topViewController?.isKind(of: PaymentScreen.classForCoder()))!) {
            return
        }
        else
        {
            /*  print("OLD Data")
             print("Is from talk now: \(GlobalVariables.sharedManager.isCameForTalkNowOptionInOnlineConsult )")
             //n - if came from schedule
             print("Consultation type: \(GlobalVariables.sharedManager.consultationType)")
             print("New Data")
             print("Consult mode: \(consultationModeForOC)")
             print("Consult Type: \(consultationTypeForOC)")
             print("Consult Reason: \(consultationReasonForOC)") */
            
            if GlobalVariables.sharedManager.onlineConsultationFees != "₹0"
            {
                payVC.request_from = Online_consultation
                payVC.scheduledDateForOnlineConsult = selectedScheduleForConsultation
                payVC.consultationTypeForOnlineConsult = consultationType // Text, Phone, Video
                payVC.specialistTypeForOnlineConsult = GlobalVariables.sharedManager.specialityTypeForOnlineConsult //Example: Dermitology
                payVC.patientSlugForOnlineConsult = self.patientSlugValue //"RftiOT8ufUpQtDuAWublMMDn" //pending //hard coding for temporarily
                payVC.specialistSlugForOnlineConsult = GlobalVariables.sharedManager.selectedDoctorsSpecialistSlugValue // Eg. wM1OPFLNp
                payVC.clinicSlugForOnlineConsult = GlobalVariables.sharedManager.clinicPermalink // Eg. GlobalVariables.sharedManager.clinicPermalink
                payVC.consultationAmountForOnlineConsult = GlobalVariables.sharedManager.onlineConsultationFees.replacingOccurrences(of: "₹", with: "")
                payVC.dateValueForOnlineConsult = GlobalVariables.sharedManager.selectedDateForOnlineConsult
                payVC.slotValueForOnlineConsult = GlobalVariables.sharedManager.selectedTimeSlotForOnlineConsult
                payVC.doctorNameForOC = doctorName
                payVC.doctorImageForOC = doctorImage // doctorSpecilityForOC doctorEducationForOC
                payVC.doctorSpecilityForOC = doctorSpecility
                payVC.doctorEducationForOC = doctorEducation
                
                if GlobalVariables.sharedManager.isCameForTalkNowOptionInOnlineConsult == "y"{
                    
                    payVC.bookingTypeForOnlineConsult = "talkNowType"
                }
                
                if GlobalVariables.sharedManager.isCameForTalkNowOptionInOnlineConsult == "n" && GlobalVariables.sharedManager.consultationType == "textConsult" {
                    
                    payVC.bookingTypeForOnlineConsult = "textConsultType"
                }
                
                if GlobalVariables.sharedManager.isCameForTalkNowOptionInOnlineConsult == "n" && (GlobalVariables.sharedManager.consultationType == "audioConsult" || GlobalVariables.sharedManager.consultationType == "videoConsult") {
                    payVC.bookingTypeForOnlineConsult = "scheduledType"
                }
                
                if GlobalVariables.sharedManager.isFromSeatchOrClinicVC == "clinicListVC"{
                    payVC.isFromSearchForOnlineConsult = "n"
                }else{
                    payVC.isFromSearchForOnlineConsult = "y"
                }
                
                payVC.consultationReasonForOC = consultationReasonForOC
                
                /* let defaultPatientData = AppUtilitiesSwift.getSelectedPatientDetails()!
                 
                 payVC.patient_slug = responseDic["patient_slug"] as! String
                 payVC.appoitnment_slug = responseDic["appointment_slug"] as! String
                 payVC.total_payable = NSNumber(value: self.amount)
                 payVC.request_from = OPD
                 payVC.first_name = defaultPatientData[AppUtilitiesSwift.K_PATIENT_FIRST_NAME_BA] as? String
                 payVC.email_id = defaultPatientData[AppUtilitiesSwift.K_PATIENT_EMAIL_BA] as? String
                 */
                
                self.navigationController?.pushViewController(payVC, animated: true)
            }
        }
    }
    
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
