//
//  DoctorsDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class DoctorsDetails: UIViewController {
    
    var specialistSlugValue:String = ""
    
    @IBOutlet weak var mainBGCardView: UIView!
    @IBOutlet weak var doctorsImageView: UIImageView!
    @IBOutlet weak var doctorsNameLabel: UILabel!
    @IBOutlet weak var doctorsSpecialityLabel: UILabel!
    @IBOutlet weak var doctorsEducatiionLabel: UILabel!
    
    
    @IBOutlet weak var experienceTitleLabel: UILabel!
    @IBOutlet weak var doctorsExperienceLabel: UILabel!
    @IBOutlet weak var consultationFeesForChatLabel: UILabel!
    @IBOutlet weak var consultationFeesForAudioLabel: UILabel!
    @IBOutlet weak var consultationFeesForVideoLabel: UILabel!
    
    
    @IBOutlet weak var consultationFeeLabel: UILabel!
    
    @IBOutlet weak var textImg: UIImageView!
    @IBOutlet weak var audioImg: UIImageView!
    @IBOutlet weak var videoImg: UIImageView!
    
    
    @IBOutlet weak var preveousDateSelectionImg: UIButton!
    @IBOutlet weak var nextDateSelectionImg: UIButton!
    
    @IBOutlet weak var appointmentSelectionDateLabel: UILabel!
    
    @IBOutlet weak var doctorsDetailsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var moreDetailsButton: UIButton!
    
    var isExpandded:Bool = false
    
    var weeksSlotsArray:[String] = []
    var weeksSlotsFinalArray:[String] = []
    
    var startTimeArray:[String] = []
    var endTimeArray:[String] = []
    
    var startAndEnTimeDictArray:[[String:Any]] = []
    var finalSlotsArray:[String] = []
    
    var finalSlotsArray2: [[String]] = []
    
    var isAfter12PMTime:Bool = false
    
    var currentDateIndex = 0
    var selectedDateIs = ""
    
    var rateForTextConsultaton = ""
    var rateForAudioConsultaton = ""
    var rateForVideoConsultaton = ""
    
    var doctorExperiecne = 0
    var doctorCurrentWorkingLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mainBGCardView.layer.cornerRadius = 5.0
        
        doctorsImageView.layer.cornerRadius = doctorsImageView.frame.height/2
        doctorsImageView.clipsToBounds = true
        
        doctorsDetailsViewHeight.constant = 158
        self.moreDetailsButton.isHidden = true
        
        self.preveousDateSelectionImg.setImage(UIImage(named: "BA_left_disable_arrow"), for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.naviagteToProfileSelectionVC(notification:)), name: Notification.Name("moveToUserProfileSelection"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.naviagteToProfileSelectionVC2(notification:)), name: Notification.Name("moveToProfileVC"), object: nil)
        
        self.updateDoctorsDetails()
        self.getAvailableSlotsData()
        self.getDoctorsDetailedInformation()
    }
    
    //MARK: Udpate doctor details
    func updateDoctorsDetails(){
        
        self.doctorsNameLabel.text = GlobalVariables.sharedManager.selectedDoctorsFullName
        self.doctorsSpecialityLabel.text = GlobalVariables.sharedManager.selectedDoctorsSpecialityType
        self.doctorsEducatiionLabel.text = GlobalVariables.sharedManager.selectedDoctorsQualification
        
        if GlobalVariables.sharedManager.selectedDoctorsPofilePicture != ""{
            AppUtilitiesSwift.getData(from: GlobalVariables.sharedManager.selectedDoctorsPofilePicture as String) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.doctorsImageView.image  = UIImage(data: data)
                }
            }
        }
        else{
            
            self.doctorsImageView.image = UIImage(named: "avatar_doc.png")
        }
        
    }
    
    //MARK: Get Doctors/Specialis detailed information - API Call
    // to get rate details which are required for Talk Now
    
    func getDoctorsDetailedInformation() {
        
        ProgressHUD.show("Loading...")
        APIRequesterHelper.getSpecialistDetailwithSlugId(specialistSlugValue, comingFromClinic: true, withCompletionHandler: { result, actualResult, error in
            if error == nil {
                //print("Actual Result is: \(actualResult)")
                if let doctorsDetailsDict = actualResult as? NSDictionary{
                    
                    if let consultationRuleDict = doctorsDetailsDict["consultation_rule"] as? NSDictionary {
                        
                        //Getting price for consultation
                        if let ruleDict = consultationRuleDict["rule"] as? NSDictionary{
                            
                            if let textConsultRateDict = ruleDict["text"] as? NSDictionary{
                                
                                let rate = textConsultRateDict["rate"] as? String ?? "0"
                                self.rateForTextConsultaton = "₹\(rate)"
                                
                            }
                            if let audioConsultRateDict = ruleDict["audio"] as? NSDictionary{
                                
                                let rate = audioConsultRateDict["rate"] as? String ?? "0"
                                self.rateForAudioConsultaton = "₹\(rate)"
                            }
                            if let videoConsultRateDict = ruleDict["video"] as? NSDictionary{
                                
                                let rate = videoConsultRateDict["rate"] as? String ?? "0"
                                self.rateForVideoConsultaton = "₹\(rate)"
                            }
                        }
                        else{
                            //ruleDict is not contains "rule" keyword
                        }
                    }
                    else{
                        //doctorsDetailsDict not contains "consultation_rule" key
                    }
                    
                    //Getting other details
                    
                    if let doctorsDetailsDataDict = doctorsDetailsDict["specialist_details"] as? NSDictionary {
                        
                        let experience = doctorsDetailsDataDict["experience"] as? Int ?? 0
                        let workingCity = doctorsDetailsDataDict["clinic_city"] as? String ?? "No Found"
                        
                        self.doctorExperiecne = experience
                        self.doctorCurrentWorkingLocation = workingCity
                    }else{
                        // "specialist_details" key is not present
                    }
                    
                    
                    //update rehsres data
                    self.updateTheDoctorsDetails()
                }
                else{
                    // actualResult is not dictionary
                }
            }else{
                //is error present
                showAlert(title: "Error", message: "Error while getting the doctors detaila", vc: self)
            }
            ProgressHUD.dismiss()
        })
    }
    
    //MARK: Update doctors details
    func updateTheDoctorsDetails() {
        
        DispatchQueue.main.async {
            
            self.doctorsExperienceLabel.text = "\(self.doctorExperiecne) years | Currently Consulting at \(self.doctorCurrentWorkingLocation)"
            self.consultationFeesForChatLabel.text = "Chat                  \(self.rateForTextConsultaton)"
            self.consultationFeesForAudioLabel.text = "Audio Call        \(self.rateForAudioConsultaton)"
            self.consultationFeesForVideoLabel.text = "Video Call        \(self.rateForVideoConsultaton)"
        }
    }
    
    
    //MARK: Get Available slots API Call
    func getAvailableSlotsData(){
        
        ProgressHUD.show("Loading...")
        
        let lParams: [AnyHashable : Any] = [:]
        
        let isFrom = GlobalVariables.sharedManager.isFromSeatchOrClinicVC
        // kGetScheduleDataAPIPath = api/specialist/
        var urlString = ""
        
        if isFrom == "clinicListVC"{
            
            // lParams["specialist_slug"] = specialistSlugValue
            // lParams["clinic_permalink"] = GlobalVariables.sharedManager.clinicPermalink
            
            urlString = "api/specialist/\(specialistSlugValue)/\(GlobalVariables.sharedManager.clinicPermalink)/date_schedule/"
        }
        else{ //isFrom = searchVC
            
            // lParams["specialist_slug"] = specialistSlugValue
            urlString = "api/specialist/\(specialistSlugValue)/date_schedule/"
        }
        
        //print(urlString)
        
        APIRequester_New.fireGetMethod(URLString: urlString , aParams: lParams as [AnyHashable : Any]) { response ,error in
            
            if let responseJSONData = response as NSDictionary?{
                
                if (responseJSONData.value(forKey: "SUCCESS") as? NSNumber)?.boolValue ?? false {
                    
                    if let dateSchedulesArray = responseJSONData.object(forKey: "date_schedules") as?  [[String:Any]] {
                        
                        if dateSchedulesArray.count > 0{
                            
                            self.weeksSlotsArray = []
                            // self.startTimeArray = []
                            // self.endTimeArray = []
                            self.startAndEnTimeDictArray = []
                            
                            for dateSchedulesDict:Dictionary<String,Any> in dateSchedulesArray{
                                
                                let dateValue:String = dateSchedulesDict["date"] as? String ?? "2019-12-02"
                                self.weeksSlotsArray.append(dateValue)
                                
                                if let timeBlocksArray = dateSchedulesDict["time_blocks"] as? [[String:Any]]{
                                    
                                    if timeBlocksArray.count > 0{
                                        
                                        for timeBlocksDict:Dictionary<String,Any> in timeBlocksArray{
                                            
                                            self.startAndEnTimeDictArray.append(timeBlocksDict)
                                        }
                                    }
                                    else{
                                        //timeBlocksArray is empty
                                    }
                                }
                                else{
                                    // time_blocks object is not found // or not an array
                                }
                                
                                
                            } // end of for dateSchedulesDict:Dictionary<String,Any> in dateSchedulesArray
                            
                            self.getAvailableDateAndTimeSlots()
                            ProgressHUD.dismiss()
                        }
                        else{
                            
                            //show alert msg // no slots available
                            showAlert(title: "Oops!", message: "No slots are available at this moment", vc: self)
                            ProgressHUD.dismiss()
                        }
                    }
                    else{
                        // date_schedules key is not present
                    }
                }
                else{
                    // SUCCESS = 0 //show alert// failed
                    showAlert(title: "Failed", message: "Something went wrong", vc: self)
                    ProgressHUD.dismiss()
                }
            }
            else{
                
                //result is not JSON
                showAlert(title: "Failed", message: "Something went wrong", vc: self)
                ProgressHUD.dismiss()
            }
        }
    }
    
    func updateSelectedDateUI(){
        
        DispatchQueue.main.async {
            
            self.appointmentSelectionDateLabel.text = self.selectedDateIs
            GlobalVariables.sharedManager.selectedDateForOnlineConsult = self.weeksSlotsArray[self.currentDateIndex]
            print(GlobalVariables.sharedManager.selectedDateForOnlineConsult)
        }
    }
    
    func getAvailableDateAndTimeSlots(){
        
        for dateValue in self.weeksSlotsArray {
            
            let time_slot = AppUtilitiesSwift.convertDateFormateFrom(fromFormate: "yyyy-MM-dd", toFormate: "MMMM d", dateSring: dateValue)
            self.weeksSlotsFinalArray.append(time_slot ?? "December 9")
        }
        //print(self.weeksSlotsFinalArray)
        self.selectedDateIs = self.weeksSlotsFinalArray.first ?? "December 1"
        print("By Default First Index Date is: \(self.selectedDateIs)") // Today Date
        
        self.updateSelectedDateUI()
        
        self.finalSlotsArray2 = []
        //startAndEnTimeDictArray - is Arrat of Dictionary - it contains 1 dict or more than 1 dict
        for slotsDict in self.startAndEnTimeDictArray {
            
            let startTime:String = slotsDict["start_time"] as? String ?? "7:00"
            let endTime:String = slotsDict["end_time"] as? String ?? "20:00"
            
            // print(startTime) print(endTime)
            slotsConvertionMethod(startTiming: startTime, endTiming: endTime)
            
        }
        // print(self.finalSlotsArray2) //prints array of array slots
        
        let getSlotsForSelectedDate = self.finalSlotsArray2[currentDateIndex]
        print("Date for \(selectedDateIs) : \(getSlotsForSelectedDate)")
        
        let slotDictData:[String:Any] = ["slots": getSlotsForSelectedDate]
        
        NotificationCenter.default.post(name: Notification.Name("nextDateClicked"), object: nil, userInfo: slotDictData)
    }
    
    func slotsConvertionMethod(startTiming:String, endTiming:String) {
        
        let startValue = startTiming.replacingOccurrences(of: ":", with: ".")
        let endValue = endTiming.replacingOccurrences(of: ":", with: ".")
        
        let startTime = Double(startValue) //eg = 7.0
        let endTime = Double(endValue) // 20.0
        
        let interval = 0.25
        let endTime1 = endTime! + 0.25
        
        self.finalSlotsArray = []
        
        self.isAfter12PMTime = false
        
        for i in stride(from: startTime!, to: endTime1, by: interval) {
            
            var time1 = String(format: "%.2f", i)
            
            if time1.hasSuffix(".25") {
                time1 = time1.replacingOccurrences(of: ".25", with: ".15")
            }
            if time1.hasSuffix(".50") {
                time1 = time1.replacingOccurrences(of: ".50", with: ".30")
            }
            if time1.hasSuffix(".75") {
                time1 = time1.replacingOccurrences(of: ".75", with: ".45")
            }
            // print(tim1)
            var timeInDouble:Double = Double(time1)!
            if timeInDouble > 12.45 {
                timeInDouble =  timeInDouble - 12.0
            }else{
                
            }
            // print(Double(round(1000*timeInDouble)/1000))
            
            var finalTimeSlot = String(Double(round(1000*timeInDouble)/1000))
            
            if finalTimeSlot.hasSuffix("5"){
            }else{
                finalTimeSlot = "\(finalTimeSlot)0"
            }
            // print(finalTimeSlot)
            
            if finalTimeSlot == "12.00" {
                self.isAfter12PMTime = true
            }
            
            if isAfter12PMTime{
                
                finalTimeSlot = "\(finalTimeSlot) pm"
            }
            else{
                finalTimeSlot = "\(finalTimeSlot) am"
            }
            self.finalSlotsArray.append(finalTimeSlot)
            
        }
        self.finalSlotsArray2.append(self.finalSlotsArray)
        
    }
    
    @IBAction func moreDetailsButtonClicked(_ sender: Any) {
        
        if !isExpandded {
            isExpandded = true
            print("Exapanded")
            self.updateViewHeight1()
        }else{
            isExpandded = false
            print("Not Exapanded")
            self.updateViewHeight2()
        }
    }
    
    func updateViewHeight1(){
        
        DispatchQueue.main.async {
            self.doctorsDetailsViewHeight.constant = CGFloat(80)
            self.moreDetailsButton.setTitle("Show details",for: .normal)
            
            // self.experienceTitleLabel.isHidden = true
            // self.doctorsExperienceLabel.isHidden = true
            
            self.consultationFeeLabel.isHidden = true
            self.textImg.isHidden = true
            self.audioImg.isHidden = true
            self.videoImg.isHidden = true
            
            self.consultationFeesForChatLabel.isHidden = true
            self.consultationFeesForAudioLabel.isHidden = true
            self.consultationFeesForVideoLabel.isHidden = true
        }
    }
    
    func updateViewHeight2(){
        
        DispatchQueue.main.async {
            self.doctorsDetailsViewHeight.constant = CGFloat(180)
            self.moreDetailsButton.setTitle("Show less",for: .normal)
            
            //  self.experienceTitleLabel.isHidden = false
            //  self.doctorsExperienceLabel.isHidden = false
            
            self.consultationFeeLabel.isHidden = false
            self.textImg.isHidden = false
            self.audioImg.isHidden = false
            self.videoImg.isHidden = false
            
            self.consultationFeesForChatLabel.isHidden = false
            self.consultationFeesForAudioLabel.isHidden = false
            self.consultationFeesForVideoLabel.isHidden = false
            
            
        }
    }
    
    //MARK: Date Selections
    
    @IBAction func preveousDateClicked(_ sender: Any) {
        
        if currentDateIndex == 0 {
            
            DispatchQueue.main.async {
                
                self.preveousDateSelectionImg.setImage(UIImage(named: "BA_left_disable_arrow"), for: .normal)
                self.nextDateSelectionImg.setImage(UIImage(named: "OC_right_arrow"), for: .normal)
            }
            
        }else{
            currentDateIndex = currentDateIndex - 1
            DispatchQueue.main.async {
                
                self.preveousDateSelectionImg.setImage(UIImage(named: "OC_left_arrow"), for: .normal)
                self.nextDateSelectionImg.setImage(UIImage(named: "OC_right_arrow"), for: .normal)
            }
        }
        // print("Date index: \(currentDateIndex)")
        
        self.selectedDateIs = self.weeksSlotsFinalArray[currentDateIndex]
        //  print("Selected Date : \(self.selectedDateIs)")
        
        self.updateSelectedDateUI() // update date label
        
        let getSlotsForSelectedDate = self.finalSlotsArray2[currentDateIndex]
        print("Date for \(selectedDateIs) : \(getSlotsForSelectedDate)")
        
        let slotDictData:[String:Any] = ["slots": getSlotsForSelectedDate]
        
        NotificationCenter.default.post(name: Notification.Name("preveousDateClicked"), object: nil, userInfo: slotDictData)
    }
    
    
    @IBAction func nextDateClicked(_ sender: Any) {
        
        if currentDateIndex == 6 {
            
            DispatchQueue.main.async {
                
                self.nextDateSelectionImg.setImage(UIImage(named: "BA_right_disable_arrow"), for: .normal)
                self.preveousDateSelectionImg.setImage(UIImage(named: "OC_left_arrow"), for: .normal)
            }
            
        }else{
            currentDateIndex = currentDateIndex + 1
            
            DispatchQueue.main.async {
                
                self.nextDateSelectionImg.setImage(UIImage(named: "OC_right_arrow"), for: .normal)
                self.preveousDateSelectionImg.setImage(UIImage(named: "OC_left_arrow"), for: .normal)
            }
            
        }
        // print("Next Date index: \(currentDateIndex)")
        
        self.selectedDateIs = self.weeksSlotsFinalArray[currentDateIndex]
        // print("Selected Date : \(self.selectedDateIs)")
        
        self.updateSelectedDateUI() // update date label
        
        let getSlotsForSelectedDate:Array = self.finalSlotsArray2[currentDateIndex]
        print("Date for \(selectedDateIs) : \(getSlotsForSelectedDate)")
        
        let slotDictData:[String:Any] = ["slots": getSlotsForSelectedDate]
        
        NotificationCenter.default.post(name: Notification.Name("nextDateClicked"), object: nil, userInfo: slotDictData)
    }
    
    //MARK: Naviagte to Profile Selection VC
    
    @objc func naviagteToProfileSelectionVC(notification: Notification) { // from slot selction - Audio and Video
        
        var patientSlugValue = ""
        let lPatient = AppUtilities.getCurrentSelectedPatientInMyFamily()
        
        if lPatient!.patient_slug != nil {
            patientSlugValue = lPatient!.patient_slug!
        } else {
            patientSlugValue = ""
        }
        
        if GlobalVariables.sharedManager.consultationType == "audioConsult"{
            
            GlobalVariables.sharedManager.onlineConsultationFees = rateForAudioConsultaton
        }
        else if GlobalVariables.sharedManager.consultationType == "textConsult"{
            GlobalVariables.sharedManager.onlineConsultationFees = rateForTextConsultaton
            
            let params = [
                "ConsultationFee" : rateForTextConsultaton,
                "UserSlug" : patientSlugValue
            ]
            AppsFlyerHelper.shared().trackAppsFlyerEvent(withEventName: "ConsultationtypeAudio", andEventParams: params)
        }
        else if GlobalVariables.sharedManager.consultationType == "videoConsult"{
            GlobalVariables.sharedManager.onlineConsultationFees = rateForVideoConsultaton
            
            let params = [
                "ConsultationFee" : rateForVideoConsultaton,
                "UserSlug" : patientSlugValue
            ]
            AppsFlyerHelper.shared().trackAppsFlyerEvent(withEventName: "ConsultationtypeVedio", andEventParams: params)
        }else{
            // GlobalVariables.sharedManager.onlineConsultationFees = ""
        }
        
        let storyBoard = UIStoryboard.init(name: "BookAppointment", bundle: nil)
        let BA_View = storyBoard.instantiateViewController(withIdentifier: "BA_Patient_Self_Or_Other_View") as! BA_Patient_Self_Or_Other_View
        if ((self.navigationController?.topViewController?.isKind(of: BA_Patient_Self_Or_Other_View.classForCoder()))!) {
            return
        } else {
            
            self.navigationController?.pushViewController(BA_View, animated: true)
        }
    }
    
    @objc func naviagteToProfileSelectionVC2(notification: Notification){
        
        GlobalVariables.sharedManager.appointmentForOpdOrOnline = "OnlineConsult"
        GlobalVariables.sharedManager.consultationType = "textConsult"
        GlobalVariables.sharedManager.isCameForTalkNowOptionInOnlineConsult = "n"
        GlobalVariables.sharedManager.onlineConsultationFees = self.rateForTextConsultaton
        
        //To save in AppsFlyerHelper
        var patientSlugValue = ""
        let lPatient = AppUtilities.getCurrentSelectedPatientInMyFamily()
        
        if lPatient!.patient_slug != nil {
            patientSlugValue = lPatient!.patient_slug!
        } else {
            patientSlugValue = ""
        }
        
        let params = [
            "ConsultationFee" : self.rateForTextConsultaton,
            "UserSlug" : patientSlugValue
        ]
        AppsFlyerHelper.shared().trackAppsFlyerEvent(withEventName: "ConsultationtypeText", andEventParams: params)
        
        
        let storyBoard = UIStoryboard.init(name: "BookAppointment", bundle: nil)
        let BA_View = storyBoard.instantiateViewController(withIdentifier: "BA_Patient_Self_Or_Other_View") as! BA_Patient_Self_Or_Other_View
        if ((self.navigationController?.topViewController?.isKind(of: BA_Patient_Self_Or_Other_View.classForCoder()))!) {
            return
        } else {
            
            self.navigationController?.pushViewController(BA_View, animated: true)
        }
    }
    
    //MARK: Removeb observer
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("moveToUserProfileSelection"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("moveToProfileVC"), object: nil)
    }
    
    //MARK: Navigationa and Bottom Buttons
    
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
    
    @IBAction func emergrncyCallButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(emergencyVC, animated: true)
        }
        
    }
    
    
}
