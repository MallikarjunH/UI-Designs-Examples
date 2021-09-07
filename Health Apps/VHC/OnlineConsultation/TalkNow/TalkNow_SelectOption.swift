//
//  TalkNow_SelectOption.swift
//  VidalHealth
//
//  Created by mallikarjun on 21/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class TalkNow_SelectOption: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var doctorCardBGVIew: UIView!
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorSpciality: UILabel!
    @IBOutlet weak var doctorEducation: UILabel!
    
    @IBOutlet weak var cardViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bookAppointmentButtonOutlet: UIButton!
    
    var chatRadioButtonSelected:Bool = false
    var audioRadioButtonSelected:Bool = false
    var videoRadioButtonSelected:Bool = false
    
    var talkNowAvailabilityForAudioConsult:String = ""
    var talkNowAvailabilityForVideoConsult:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        doctorCardBGVIew.layer.cornerRadius = 5.0
        cardViewHeightConstraint.constant = 0
        
        mainTableView.tableFooterView = UIView()
        mainTableView.isScrollEnabled = false
        
        self.talkNowAvailabilityForAudioConsult = "\(GlobalVariables.sharedManager.talkNowAvailabilityForAudioConsult)"
        self.talkNowAvailabilityForVideoConsult = "\(GlobalVariables.sharedManager.talkNowAvailabilityForVideoConsult)"
        
        bookAppointmentButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREY_COLOR)
        
    }
    
    //MARK: TableView Data source and delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2 //return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    /*    if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TalkeNowTextMsgCellId", for: indexPath) as! TalkeNowTextMsgCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            
            if chatRadioButtonSelected{
                cell.textMsgImg.image = UIImage(named: "Radiobutton_On")
            }else{
                cell.textMsgImg.image = UIImage(named: "Radiobutton_Off")
            }
            return cell
        }
        else */
      if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TalkeNowAudioCallCellId", for: indexPath) as! TalkeNowAudioCallCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            
            if audioRadioButtonSelected{
                cell.audioCallImg.image = UIImage(named: "Radiobutton_On")
            }else{
                cell.audioCallImg.image = UIImage(named: "Radiobutton_Off")
            }
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TalkeNowVideoCallCellId", for: indexPath) as! TalkeNowVideoCallCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none;
            
            if videoRadioButtonSelected{
                cell.videoCallImg.image = UIImage(named: "Radiobutton_On")
            }else{
                cell.videoCallImg.image = UIImage(named: "Radiobutton_Off")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       /* if indexPath.section == 0{
            print("chat")
            chatRadioButtonSelected = true
            audioRadioButtonSelected = false
            videoRadioButtonSelected = false
            reloadTableView()
        }
        else */
        if indexPath.section == 0{
            print("audio")
            
            if talkNowAvailabilityForAudioConsult == "1"{
                chatRadioButtonSelected = false
                audioRadioButtonSelected = true
                videoRadioButtonSelected = false
                reloadTableView()
            }
            else{
                showAlert(title: "Oops!", message: "No Specialists are available for Talk Now", vc: self)
            }
            
        }
        else{
            print("video")
            
            if talkNowAvailabilityForVideoConsult == "1" {
                chatRadioButtonSelected = false
                audioRadioButtonSelected = false
                videoRadioButtonSelected = true
                reloadTableView()
            }
            else{
                showAlert(title: "Oops!", message: "No Specialists are available for Talk Now", vc: self)
            }
        }
        
        if chatRadioButtonSelected || audioRadioButtonSelected || videoRadioButtonSelected {
            
            DispatchQueue.main.async {
                
                self.bookAppointmentButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREEN_COLOR)
            }
        }
    }
    
    func reloadTableView(){
        
        self.mainTableView.reloadData()
    }
    
    //MARK: Naviagtion and Botton buttons
    
    
    @IBAction func bookAppointmentButtonClicked(_ sender: Any) {
        
        print("Clicked on book appointment")
        if chatRadioButtonSelected || audioRadioButtonSelected || videoRadioButtonSelected {
            
            GlobalVariables.sharedManager.isCameForTalkNowOptionInOnlineConsult = "y"
            GlobalVariables.sharedManager.appointmentForOpdOrOnline = "OnlineConsult"
            
            if chatRadioButtonSelected { //Text
                GlobalVariables.sharedManager.consultationType = "textConsult"
                GlobalVariables.sharedManager.onlineConsultationFees = GlobalVariables.sharedManager.talkNowOnlineConsultChatRate
            }
            else if audioRadioButtonSelected { //Phone
                GlobalVariables.sharedManager.consultationType = "audioConsult"
                GlobalVariables.sharedManager.onlineConsultationFees = GlobalVariables.sharedManager.talkNowOnlineConsultAudioRate
            }
            else if videoRadioButtonSelected { //Video
                GlobalVariables.sharedManager.consultationType = "videoConsult"
                GlobalVariables.sharedManager.onlineConsultationFees = GlobalVariables.sharedManager.talkNowOnlineConsultVideoRate
            }else{
                
            }
            
            let storyBoard = UIStoryboard.init(name: "BookAppointment", bundle: nil)
            let BA_View = storyBoard.instantiateViewController(withIdentifier: "BA_Patient_Self_Or_Other_View") as! BA_Patient_Self_Or_Other_View
            if ((self.navigationController?.topViewController?.isKind(of: BA_Patient_Self_Or_Other_View.classForCoder()))!) {
                return
            } else {
                
                self.navigationController?.pushViewController(BA_View, animated: true)
            }
        }
        else{
            
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

