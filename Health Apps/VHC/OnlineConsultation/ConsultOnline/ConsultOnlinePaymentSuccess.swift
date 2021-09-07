//
//  ConsultOnlinePaymentSuccess.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/12/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

@objcMembers class ConsultOnlinePaymentSuccess: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // @objc var paymentStatus:String = ""
    @objc var amountValue:String = ""
    @objc var isPaySuccess:Bool = false
    @objc var dateValue:String = ""
    @objc var slotValue:String = ""
    @objc var patientName:String = ""
    @objc var patientMobileNumber:String = ""
    @objc var patientEmail:String = ""
    
    @objc var consultationType:String = "" // Phone,Video, Text
    @objc var specialityType:String = ""
    
    @objc var doctorName:String = ""
    @objc var doctorImage:String = ""
    @objc var doctorSpciality:String = "" //doubt - required are not - came from text-question-uppload-payment
    @objc var doctorEducation:String = ""
    
    @objc var consultationSlug:String = ""
    
    @objc var consultationMedium:String = "" //talkNowType, scheduledType/textConsultType
    
    @IBOutlet weak var cardBGView: UIView!
    @IBOutlet weak var cardViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var doctorImageProfile: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorSpecialityLabel: UILabel!
    @IBOutlet weak var slotLabel: UILabel!
    @IBOutlet weak var consultationTypeImg: UIImageView!
    
    @IBOutlet weak var consultatuonMediumLabel: UILabel! //for talknow and text
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mainTableView.tableFooterView = UIView()
        
        cardBGView.layer.cornerRadius = 5.0
        
        doctorImageProfile.layer.cornerRadius = doctorImageProfile.frame.height/2
        doctorImageProfile.clipsToBounds = true
        
        if isPaySuccess {
            
            //self.cardViewHeightConstraint.constant = 80
            self.updateDoctorDeatils()
        }
        else{
            mainTableView.separatorStyle = .none
            self.cardViewHeightConstraint.constant = 0
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.naviagteToHomeScreenVC(notification:)), name: Notification.Name("moveToHomeScreenVC"), object: nil)
    }
    
    
    func updateDoctorDeatils(){
        
        if consultationMedium == "talkNowType" {
            
            self.doctorNameLabel.isHidden = true
            self.doctorSpecialityLabel.isHidden = true
            self.slotLabel.isHidden = true
            self.doctorImageProfile.isHidden = true
            
            self.consultatuonMediumLabel.isHidden = false
            
            if consultationType == "Phone" || consultationType == "Video" {
                
                if consultationType == "Phone" {
                    
                    self.consultatuonMediumLabel.text = "Audio Consultation"
                }
                else if consultationType == "Video" {
                    self.consultatuonMediumLabel.text = "Video Consultation"
                }
            }
            else if consultationType == "Text" {
                self.consultatuonMediumLabel.text = "Text Consultation"
            }
        }
        else if consultationMedium == "scheduledType" {
            
            if consultationType == "Phone" || consultationType == "Video" {
                
                self.consultatuonMediumLabel.isHidden = true
                
                self.doctorNameLabel.isHidden = false
                self.doctorSpecialityLabel.isHidden = false
                self.slotLabel.isHidden = false
                self.doctorImageProfile.isHidden = false
                
                self.doctorNameLabel.text = self.doctorName
                self.doctorSpecialityLabel.text = self.specialityType
                
                if self.dateValue != ""{
                    let dateValue1 = AppUtilitiesSwift.convertDateFormateFrom(fromFormate: "yyyy-MM-dd", toFormate: "d MMM yyyy", dateSring: self.dateValue )
                    self.slotLabel.text = "\(dateValue1 ?? "15 Dec")  •  \(slotValue)"
                }
                else{ //TEST
                    let dateValue1 = AppUtilitiesSwift.convertDateFormateFrom(fromFormate: "yyyy-MM-dd", toFormate: "d MMM yyyy", dateSring: "2019-12-18" )
                    self.slotLabel.text = "\(dateValue1 ?? "15 Dec")  •  \(slotValue)"
                }
                
                if doctorImage != ""{
                    AppUtilitiesSwift.getData(from: doctorImage as String) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            self.doctorImageProfile.image  = UIImage(data: data)
                        }
                    }
                }
                else{
                    
                    self.doctorImageProfile.image = UIImage(named: "avatar_doc.png")
                }
            }
            else{
                self.consultatuonMediumLabel.isHidden = false
            }
            
        }
        else if consultationMedium == "textConsultType" {
            
            self.doctorNameLabel.isHidden = false
            self.doctorSpecialityLabel.isHidden = false
            self.slotLabel.isHidden = false
            self.doctorImageProfile.isHidden = false
            
            self.doctorNameLabel.text = self.doctorName
            self.doctorSpecialityLabel.text = self.specialityType
            
            
            if doctorImage != ""{
                AppUtilitiesSwift.getData(from: doctorImage as String) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() {
                        self.doctorImageProfile.image  = UIImage(data: data)
                    }
                }
            }
            else{
                
                self.doctorImageProfile.image = UIImage(named: "avatar_doc.png")
            }
            
            self.slotLabel.text = GlobalVariables.sharedManager.selectedDoctorsQualification //doctor education
            
            self.consultatuonMediumLabel.isHidden = true
            self.consultatuonMediumLabel.text = "Text Consultation"
            
            
        }
        
        
        
        //Left Image
        if consultationType == "Phone"{
            
            self.consultationTypeImg.image = UIImage(named: "OC_Call_White")
        }else if consultationType == "Video"{
            self.consultationTypeImg.image = UIImage(named: "OC_Video_White")
        }
        else{
            self.consultationTypeImg.image = UIImage(named: "OC_Chat_White")
        }
    }
    
    
    //MARK: TableView Datasource and delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultOnlinePaymentSuccessCell1Id", for: indexPath) as! ConsultOnlinePaymentSuccessCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if isPaySuccess {
                
                //  cell.messageDescriptionLabel.isHidden = false
                cell.consultationFeeTitleLabel.isHidden = false
                cell.payOnlineLabel.isHidden = false
                cell.consultationFeeLabel.isHidden = false
                cell.consultationFeeTitleLabel.isHidden = false
                cell.patientDetailsLabel.isHidden = false
                cell.patientNameLabel.isHidden = false
                cell.patientMobileNumber.isHidden = false
                cell.patientEmailLabel.isHidden = false
                
                cell.sucessOrFailureImg.image = UIImage(named: "rightIcon")
                cell.appointmentStatusLabel.text = "Appointment booked sucessfully"
                cell.consultationFeeLabel.text = amountValue
                cell.patientNameLabel.text = patientName
                cell.patientMobileNumber.text = patientMobileNumber
                cell.patientEmailLabel.text = patientEmail
                
                if consultationMedium == "scheduledType" {
                    
                    cell.messageDescriptionLabel.text = "You will receive a call from the doctor at \(slotValue) on \(dateValue), make sure you have a good mobile/internet connectivity."
                }
                else if consultationMedium == "talkNowType" {
                    cell.messageDescriptionLabel.text = "Assigning a Specialist. You will be notified once the specialist has been assigned."
                }
                else{ // text consult
                    cell.messageDescriptionLabel.text = "Dr. \(self.doctorName) will respond to you soon(typically within 6 working hours)."
                }
            }
            else{
                cell.sucessOrFailureImg.image = UIImage(named: "x_close")
                cell.appointmentStatusLabel.text = "Payment failed"
                cell.messageDescriptionLabel.text = "Your payment could not be completed. Please try again."
                //cell.messageDescriptionLabel.isHidden = true
                cell.consultationFeeTitleLabel.isHidden = true
                cell.payOnlineLabel.isHidden = true
                cell.consultationFeeLabel.isHidden = true
                cell.consultationFeeTitleLabel.isHidden = true
                cell.patientDetailsLabel.isHidden = true
                cell.patientNameLabel.isHidden = true
                cell.patientMobileNumber.isHidden = true
                cell.patientEmailLabel.isHidden = true
                
            }
            
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultOnlinePaymentSuccessCell2Id", for: indexPath) as! ConsultOnlinePaymentSuccessCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if isPaySuccess {
                
                if consultationMedium == "talkNowType" || consultationMedium == "textConsultType" {
                    
                    cell.answerQuestionLabel.isHidden = true
                    cell.skipButton.isHidden = true
                    cell.startButton.isHidden = true
                }
                else{ // Schedules - Video, Audio
                    
                    cell.answerQuestionLabel.isHidden = false
                    cell.skipButton.isHidden = false
                    cell.startButton.isHidden = false
                    
                    cell.skipButton.addTarget(self, action: #selector(skipButtonAction(sender:)), for: .touchUpInside)
                    cell.startButton.addTarget(self, action: #selector(startButtonAction(sender:)), for: .touchUpInside)
                }
                
            }else{
                cell.answerQuestionLabel.isHidden = true
                cell.skipButton.isHidden = true
                cell.startButton.isHidden = true
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            
            return 296.0
        }else{
            
            return 194.0
        }
    }
    
    //MARK: Skip and Start Button
    @objc func skipButtonAction(sender:UIButton){
        
        NotificationCenter.default.post(name: Notification.Name("moveToHomeScreenVC"), object: nil)
        // navigationController?.popToViewController(ofClass: NewHomeScreen.self)
    }
    
    @objc func startButtonAction(sender:UIButton){
        
        //navigate to the questionaries page
        /*  let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
         let testQueVC = storyBoard.instantiateViewController(withIdentifier: "TestQuesionsId") as? TestQuesions
         
         if (navigationController?.topViewController is TestQuesions) {
         return
         } else {
         navigationController?.pushViewController(testQueVC!, animated: true)
         } */
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let healthQuesVC = storyBoard.instantiateViewController(withIdentifier: "HealthInfoQuestion") as? HealthInfoQuestion
        
        healthQuesVC?.fromVC = "OC"
        
        if consultationType == "Phone"{
            
            healthQuesVC?.consultationTypeForOC = "audioConsult"
        }else if consultationType == "Video"{
            healthQuesVC?.consultationTypeForOC = "videoConsult"
        }
        
        healthQuesVC?.consultationModeForOC = "schedule"
        
        healthQuesVC?.clinicPermalinkForOC = GlobalVariables.sharedManager.clinicPermalink
        
        healthQuesVC?.doctorFullNameForOC = self.doctorName //GlobalVariables.sharedManager.selectedDoctorsFullName
        healthQuesVC?.doctorSpecialityForOC = self.specialityType //GlobalVariables.sharedManager.selectedDoctorsSpecialityType
        healthQuesVC?.doctorEducationForOC = GlobalVariables.sharedManager.selectedDoctorsQualification
        healthQuesVC?.doctorProfilePicForOC = self.doctorImage //GlobalVariables.sharedManager.selectedDoctorsPofilePicture
        healthQuesVC?.aConsultation_slug = self.consultationSlug
        
        if (navigationController?.topViewController is HealthInfoQuestion) {
            return
        } else {
            navigationController?.pushViewController(healthQuesVC!, animated: true)
        }
        
        
    }
    
    @objc func naviagteToHomeScreenVC(notification: Notification){
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeScreen.self) {
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    
    //MARK: Remove observer
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("moveToHomeScreenVC"), object: nil)
    }
    
    
    //MARK: Navigation button actions
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        if isPaySuccess {
            
            NotificationCenter.default.post(name: Notification.Name("moveToHomeScreenVC"), object: nil)
        }
        else{
            self.navigationController?.popViewController(animated: true) //card selection VC
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
    
    
    //TEST Purpose
    /*  @IBAction func continueButtonClicked(_ sender: Any) { // consultationSlug
     
     self.navigationController?.setNavigationBarHidden(false, animated: true)
     let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
     let consultationsDetailsVC = storyBoard.instantiateViewController(withIdentifier: "ConsultationDetail") as! ConsultationDetail
     if ((self.navigationController?.topViewController?.isKind(of: ConsultationDetail.classForCoder()))!) {
     return
     } else {
     consultationsDetailsVC.aConsultationDetailSlug = self.consultationSlug
     self.navigationController?.pushViewController(consultationsDetailsVC, animated: true)
     }
     
     } */
}


/* extension UINavigationController {
 func popToViewController(ofClass: AnyClass, animated: Bool = true) {
 if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
 popToViewController(vc, animated: animated)
 }
 }
 }
 
 //navigationController?.popToViewController(ofClass: SomeViewController.self) */
