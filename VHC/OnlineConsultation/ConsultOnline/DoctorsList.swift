//
//  DoctorsList.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class DoctorsList: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var doctorsNameArray:[String] = []
    var doctorsImgProfileArray:[String] = []
    var doctorSpecialistTypeArray:[String] = []
    var doctorQualificationArray:[String] = []
    //var doctorExperienceArray:[Int] = []
    var availableForText:[Int] = []
    var availableForAudio:[Int] = []
    var availableForVideo:[Int] = []
    // var nextApmentAvailbleTimeArray:[String] = []
    
    var specialistSlugValue:[String] = []
    var doctorsListArrayResult:[[String:Any]] = []
    
    var specialityType:String = ""
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var talkToDoctorInMinutesLabel: UILabel!
    @IBOutlet weak var belowAreTheLIstOfLabel: UILabel!
    @IBOutlet weak var spcialityTypeLabel: UILabel!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCardView.layer.cornerRadius = 5.0
        
        belowAreTheLIstOfLabel.textColor = UIColor(red: 0.69, green: 0.71, blue: 0.72, alpha: 1)
        spcialityTypeLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        spcialityTypeLabel.text = specialityType
        
        // Do any additional setup after loading the view.
        
        GlobalVariables.sharedManager.slotsAvailableForTextConsult = ""
        GlobalVariables.sharedManager.slotsAvailableForAudioConsult = ""
        GlobalVariables.sharedManager.slotsAvailableForVideoConsult = ""
        
        // print("Doctors List: \(doctorsListDictResult )")
        // let doctorsArrayOfDict:[[String:Any]] =  doctorsListDictResult
        
        ProgressHUD.show("Loading...")
        
        if doctorsListArrayResult.count > 0{
            
            self.doctorsNameArray = []
            self.doctorsImgProfileArray = []
            self.doctorSpecialistTypeArray = []
            self.doctorQualificationArray = []
            self.availableForText = []
            self.availableForAudio = []
            self.availableForVideo = []
            self.specialistSlugValue = []
            
            for doctorsData:Dictionary<String,Any> in doctorsListArrayResult{
                
                let doctorName:String = doctorsData["full_name"] as? String ?? ""
                let doctorImg:String = doctorsData["profile_pic_thumbnail"] as? String ?? ""
                let doctorSpecType:String = doctorsData["specialist_type"] as? String ?? ""
                let doctorQualification:String = doctorsData["qualifications"] as? String ?? ""
                let doctlorsSlug:String = doctorsData["user_slug_id"] as? String ?? ""
                
                let availableForText:Int = doctorsData["is_text"] as? Int ?? 2
                let availableForAudio:Int = doctorsData["is_call"] as? Int ?? 2
                let availableForVideo:Int = doctorsData["is_video"] as? Int ?? 2
                
                self.doctorsNameArray.append(doctorName)
                self.doctorsImgProfileArray.append(doctorImg)
                self.doctorSpecialistTypeArray.append(doctorSpecType)
                self.doctorQualificationArray.append(doctorQualification)
                self.availableForText.append(availableForText)
                self.availableForAudio.append(availableForAudio)
                self.availableForVideo.append(availableForVideo)
                self.specialistSlugValue.append(doctlorsSlug)
            }
            
        }
        else{
            //no doctors - empty doctors
        }
        
        ProgressHUD.dismiss()
        
    }
    
    //MARK: Talk Now Button Clicked
    @IBAction func talkNowButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
        let talkNowOptions = storyBoard.instantiateViewController(withIdentifier: "TalkNow_SelectOptionId") as? TalkNow_SelectOption
        
        if (navigationController?.topViewController is TalkNow_SelectOption) {
            return
        } else {
            navigationController?.pushViewController(talkNowOptions!, animated: true)
        }
    }
    
    //MARK: TableView Datasource and Delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return doctorsListArrayResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorsListCellId", for: indexPath) as! DoctorsListCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.doctorsNameLabel.text = self.doctorsNameArray[indexPath.row]
        cell.doctorsSpecialityLabel.text = self.doctorSpecialistTypeArray[indexPath.row]
        cell.doctorsEducationLabel.text = self.doctorQualificationArray[indexPath.row]
        
        cell.doctorsImage.layer.cornerRadius = cell.doctorsImage.frame.height/2
        cell.doctorsImage.clipsToBounds = true
        
        if self.doctorsImgProfileArray[indexPath.row] != ""{
            AppUtilitiesSwift.getData(from: self.doctorsImgProfileArray[indexPath.row] as String) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    cell.doctorsImage.image = UIImage(data: data)
                }
            }
        }
        else{
            cell.doctorsImage.image = UIImage(named: "avatar_doc.png")
        }
        
        cell.doctorsExperienceLabel.text = "0 Years"
        cell.doctorsAvailableTimeLabel.text = "Next Appointment available on 0 min"
        
        if availableForText[indexPath.row] == 1 && availableForAudio[indexPath.row] == 1 && availableForVideo[indexPath.row] == 1 {
            
            cell.availableForTextImgView.image = UIImage(named: "OC_Chat_Grey")
            cell.availableForCallImgView.image = UIImage(named: "OC_Call_Grey")
            cell.availableForVideoImgView.image = UIImage(named: "OC_Video_Grey")
        }
        else{
            
            
            if (availableForText[indexPath.row] == 0 && availableForAudio[indexPath.row] == 0) && availableForVideo[indexPath.row] == 1 {
                
                cell.availableForTextImgView.image = UIImage(named: "OC_Video_Grey")
                cell.availableForCallImgView.image =  UIImage(named: "OC_Call_White") //hide
                cell.availableForVideoImgView.image = UIImage(named: "OC_Call_White") //hide
            }
            else if (availableForText[indexPath.row] == 0 && availableForVideo[indexPath.row] == 0) && availableForAudio[indexPath.row] == 1 {
                
                cell.availableForTextImgView.image = UIImage(named: "OC_Call_Grey")
                cell.availableForCallImgView.image = UIImage(named: "OC_Call_White") //hide
                cell.availableForVideoImgView.image = UIImage(named: "OC_Call_White") //hide
            }
            else if (availableForAudio[indexPath.row] == 0 && availableForVideo[indexPath.row] == 0) && availableForText[indexPath.row] == 1 {
                
                cell.availableForTextImgView.image = UIImage(named: "OC_Chat_Grey")
                cell.availableForCallImgView.image = UIImage(named: "OC_Call_White") //hide
                cell.availableForVideoImgView.image = UIImage(named: "OC_Call_White") //hide
            }
            else if availableForText[indexPath.row] == 0 && (availableForAudio[indexPath.row] == 1 && availableForVideo[indexPath.row] == 1 ){
                
                cell.availableForTextImgView.image = UIImage(named: "OC_Call_Grey")
                cell.availableForCallImgView.image = UIImage(named: "OC_Video_Grey")
                cell.availableForVideoImgView.image = UIImage(named: "OC_Call_White") //hide
                
            }
            else if availableForAudio[indexPath.row] == 0 && (availableForText[indexPath.row] == 1 && availableForVideo[indexPath.row] == 1 ){
                
                cell.availableForTextImgView.image = UIImage(named: "OC_Chat_Grey")
                cell.availableForCallImgView.image = UIImage(named: "OC_Video_Grey")
                cell.availableForVideoImgView.image = UIImage(named: "OC_Call_White") //hide
                
            }
            else if availableForVideo[indexPath.row] == 0 && (availableForText[indexPath.row] == 1 && availableForAudio[indexPath.row] == 1 ){
                
                cell.availableForTextImgView.image =  UIImage(named: "OC_Chat_Grey")
                cell.availableForCallImgView.image = UIImage(named: "OC_Call_Grey")
                cell.availableForVideoImgView.image = UIImage(named: "OC_Call_White") //hide
                
            }
            else if availableForVideo[indexPath.row] == 0 && availableForText[indexPath.row] == 0 && availableForAudio[indexPath.row] == 0 {
                
                cell.availableForTextImgView.image = UIImage(named: "OC_Call_White") //hide
                cell.availableForCallImgView.image = UIImage(named: "OC_Call_White") //hide
                cell.availableForVideoImgView.image = UIImage(named: "OC_Call_White") //hide
                
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 178.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(indexPath.row)
        let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
        let doctorsDetails = storyBoard.instantiateViewController(withIdentifier: "DoctorsDetailsId") as? DoctorsDetails
        
        doctorsDetails?.specialistSlugValue = self.specialistSlugValue[indexPath.row]
        
        GlobalVariables.sharedManager.selectedDoctorsSpecialistSlugValue = self.specialistSlugValue[indexPath.row]
        GlobalVariables.sharedManager.selectedDoctorsFullName = self.doctorsNameArray[indexPath.row]
        GlobalVariables.sharedManager.selectedDoctorsQualification = self.doctorQualificationArray[indexPath.row]
        GlobalVariables.sharedManager.selectedDoctorsSpecialityType = self.doctorSpecialistTypeArray[indexPath.row]
        GlobalVariables.sharedManager.selectedDoctorsPofilePicture = self.doctorsImgProfileArray[indexPath.row]
        
        //to check that this doctor is available for which kind of consultant
        if availableForText[indexPath.row] == 1 && availableForAudio[indexPath.row] == 1 && availableForVideo[indexPath.row] == 1 {
            
            GlobalVariables.sharedManager.slotsAvailableForTextConsult = "y"
            GlobalVariables.sharedManager.slotsAvailableForAudioConsult = "y"
            GlobalVariables.sharedManager.slotsAvailableForVideoConsult = "y"
        }
        else{
            
            if (availableForText[indexPath.row] == 0 && availableForAudio[indexPath.row] == 0) && availableForVideo[indexPath.row] == 1 {
                
                GlobalVariables.sharedManager.slotsAvailableForTextConsult = "n"
                GlobalVariables.sharedManager.slotsAvailableForAudioConsult = "n"
                GlobalVariables.sharedManager.slotsAvailableForVideoConsult = "y"
            }
            else if (availableForText[indexPath.row] == 0 && availableForVideo[indexPath.row] == 0) && availableForAudio[indexPath.row] == 1 {
                
                GlobalVariables.sharedManager.slotsAvailableForTextConsult = "n"
                GlobalVariables.sharedManager.slotsAvailableForAudioConsult = "y"
                GlobalVariables.sharedManager.slotsAvailableForVideoConsult = "n"
            }
            else if (availableForAudio[indexPath.row] == 0 && availableForVideo[indexPath.row] == 0) && availableForText[indexPath.row] == 1 {
                
                GlobalVariables.sharedManager.slotsAvailableForTextConsult = "y"
                GlobalVariables.sharedManager.slotsAvailableForAudioConsult = "n"
                GlobalVariables.sharedManager.slotsAvailableForVideoConsult = "n"
            }
            else if availableForText[indexPath.row] == 0 && (availableForAudio[indexPath.row] == 1 && availableForVideo[indexPath.row] == 1 ){
                
                GlobalVariables.sharedManager.slotsAvailableForTextConsult = "n"
                GlobalVariables.sharedManager.slotsAvailableForAudioConsult = "y"
                GlobalVariables.sharedManager.slotsAvailableForVideoConsult = "y"
            }
            else if availableForAudio[indexPath.row] == 0 && (availableForText[indexPath.row] == 1 && availableForVideo[indexPath.row] == 1 ){
                
                GlobalVariables.sharedManager.slotsAvailableForTextConsult = "y"
                GlobalVariables.sharedManager.slotsAvailableForAudioConsult = "n"
                GlobalVariables.sharedManager.slotsAvailableForVideoConsult = "y"
            }
            else if availableForVideo[indexPath.row] == 0 && (availableForText[indexPath.row] == 1 && availableForAudio[indexPath.row] == 1 ){
                
                GlobalVariables.sharedManager.slotsAvailableForTextConsult = "y"
                GlobalVariables.sharedManager.slotsAvailableForAudioConsult = "y"
                GlobalVariables.sharedManager.slotsAvailableForVideoConsult = "n"
            }
            else if availableForVideo[indexPath.row] == 0 && availableForText[indexPath.row] == 0 && availableForAudio[indexPath.row] == 0 {
                
                GlobalVariables.sharedManager.slotsAvailableForTextConsult = "n"
                GlobalVariables.sharedManager.slotsAvailableForAudioConsult = "n"
                GlobalVariables.sharedManager.slotsAvailableForVideoConsult = "n"
            }
            
        }
        
        if (navigationController?.topViewController is DoctorsDetails) {
            return
        } else {
            navigationController?.pushViewController(doctorsDetails!, animated: true)
        }
    }
    
    
    //MARK: Navigation Buttons
    
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
