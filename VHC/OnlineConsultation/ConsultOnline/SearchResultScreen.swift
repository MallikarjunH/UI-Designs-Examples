//
//  SearchResultScreen.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit


class SearchResultScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    var getClinicSlugID = ""
    var getNavigationTitle = ""
    var getFilterType = ""
    var scheduleConsultationClinicSlug = ""
    
    var pageTitleValue = ""
    var doctorsListArrayToSend:[[String:Any]] = []
    
    var conditionOneArray:[String] = []
    var conditionTwoArray:[String] = []
    var conditionThreeArray:[String] = []
    var specialityTypeArray:[String] = []
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchMainBGView: UIView!
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var recomndedSpecialityLabel: UILabel!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageTitleLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
        recomndedSpecialityLabel.textColor = UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 1)
        
        self.mainTableView!.tableFooterView = UIView()
        
        if getFilterType == "clinic" {
            
            self.searchMainBGView.isHidden = true
        }else{
            self.searchMainBGView.isHidden = false
        }
        
        // Do any additional setup after loading the view.
        getSpecialistLists()
        updateTitleOfViews()
    }
    
    func updateTitleOfViews(){
        DispatchQueue.main.async {
            
            self.pageTitleLabel.text = self.pageTitleValue
            self.searchTextField.text = self.pageTitleValue
            
            if GlobalVariables.sharedManager.isFromSeatchOrClinicVC == "clinicListVC" {
                
            }else{
                GlobalVariables.sharedManager.clinicPermalink = self.pageTitleValue
            }
        }
    }
    
    //MARK: Get Get Specialist Lists
    func getSpecialistLists(){
        
        ProgressHUD.show("Loading...")
        
        if getClinicSlugID == "" {
            return
        }
        
        //kShowProgerssHUD("Loading...")
        var type = "clinic"
        if getFilterType != "" {
            type = getFilterType
        }
        let lParams = [
            "filter_type": type,
            "filter_value": getClinicSlugID
        ]
        
        if getFilterType == "clinic" {
            
            GlobalVariables.sharedManager.isFromSeatchOrClinicVC = "clinicListVC"
        }else{
            GlobalVariables.sharedManager.isFromSeatchOrClinicVC = "searchVC"
        }
        
        APIRequester_New.firePostMethod(URLString: "api/specialists/", aParams: lParams as [AnyHashable : Any]) { response ,error in
            
            if ((response as NSObject?)?.value(forKey: "SUCCESS") as? NSNumber)?.boolValue ?? false {
                
                // print(result!)
                // print("Actual Result: \(actualResult ?? "")") //print json
                
                if let responseDataDict = response as NSDictionary?{
                    
                    if let specialistsDetailsDict = responseDataDict.object(forKey: "specialists_details") as?  NSDictionary {
                        
                        // consultation_rules
                        if let consultationRulesArray = specialistsDetailsDict.object(forKey: "consultation_rules") as? [[String:Any]]{
                            
                            //print(consultationRulesArray)
                            if consultationRulesArray.count > 0{
                                
                                self.conditionOneArray = []
                                self.conditionTwoArray = []
                                self.conditionThreeArray = []
                                self.specialityTypeArray = []
                                
                                for rulesMainDict:Dictionary<String,Any> in consultationRulesArray{
                                    
                                    let condition1:String = rulesMainDict["conditions_1"] as? String ?? ""
                                    let condition2:String = rulesMainDict["conditions_2"] as? String ?? ""
                                    let condition3:String = rulesMainDict["conditions_3"] as? String ?? ""
                                    
                                    //  let description:String = rulesMainDict["description"] as? String ?? ""
                                    let specialityType:String = rulesMainDict["specialist_type"] as? String ?? ""
                                    
                                    self.conditionOneArray.append(condition1)
                                    self.conditionTwoArray.append(condition2)
                                    self.conditionThreeArray.append(condition3)
                                    self.specialityTypeArray.append(specialityType)
                                }
                                
                                let rulesMainDictForPrice = consultationRulesArray[0]
                                
                                if let rulesDictToGetPrice = rulesMainDictForPrice["rule"] as? NSDictionary{
                                    
                                    let textDict = rulesDictToGetPrice["text"] as? [String:Any]
                                    let audioDict = rulesDictToGetPrice["audio"] as? [String:Any]
                                    let videoDict = rulesDictToGetPrice["video"] as? [String:Any]
                                    
                                    let chatRate:String = textDict?["rate"] as? String ?? "0"
                                    let audioRate:String = audioDict?["rate"] as? String ?? "0"
                                    let videoRate:String = videoDict?["rate"] as? String ?? "0"
                                    
                                    let talkNowForAudio:Int = audioDict?["talk_now"] as? Int ?? 2
                                    let talkNowForVideo:Int = videoDict?["talk_now"] as? Int ?? 2
                                    
                                    GlobalVariables.sharedManager.talkNowAvailabilityForAudioConsult = talkNowForAudio
                                    GlobalVariables.sharedManager.talkNowAvailabilityForVideoConsult = talkNowForVideo
                                    
                                    GlobalVariables.sharedManager.talkNowOnlineConsultAudioRate = audioRate
                                    GlobalVariables.sharedManager.talkNowOnlineConsultVideoRate = videoRate
                                    GlobalVariables.sharedManager.talkNowOnlineConsultChatRate = chatRate
                                    
                                }else{
                                    // rule dict is not present /no money details
                                }
                                
                                
                            }else{
                                //consultationRulesArray is empty
                            }
                            
                        }
                        else{
                            //consultationRulesArray is not present (consultation_rules - key no prsent)
                        }
                        
                        //Page Title
                        if let pageTitle = specialistsDetailsDict.object(forKey: "page_title") as? String{
                            
                            self.pageTitleValue = pageTitle
                            //print("Page Title: \(pageTitle)")
                        }
                        else{
                            //pageTitle not found
                        }
                        
                        //specialist_list
                        if let doctorsList = specialistsDetailsDict.object(forKey: "specialist_list") as? [[String:Any]]{
                            // print("Doctors JSON: \(doctorsList)")
                            self.doctorsListArrayToSend = doctorsList
                        }
                        else{
                            //doctor dict not found
                            self.doctorsListArrayToSend = []
                        }
                        
                    }else{
                        
                        //specialists_details key/dict not present
                    }
                    
                    DispatchQueue.main.async {
                        self.updateTitleOfViews()
                        self.mainTableView.reloadData()
                        ProgressHUD.dismiss()
                    }
                }
                else{
                    //responseDataDict is not dict
                    ProgressHUD.dismiss()
                }
            } else {
                
                ProgressHUD.dismiss()
                let userDefaults = UserDefaults.standard
                
                AppUtilities.showAlertView(withTitle: "Not available!", withMessage: "No Specialists are available at this moment")
                
                let value = userDefaults.string(forKey: "forYoga")
                if value == "fromNotification"{
                    
                    userDefaults.set("", forKey: "forYoga")
                    
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: OnlineConsultationHome.self) {
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }
                }else{
                    
                    userDefaults.set("", forKey: "forYoga")
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            
        }
        
    }
    
    
    //MARK: TableView Datasource and Deleegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.specialityTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlineConsultSearchResultCellId", for: indexPath) as! OnlineConsultSearchResultCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        cell.specialistTypeLabel.text = self.specialityTypeArray[indexPath.row]
        
        cell.descriptionLabel1.text = self.conditionOneArray[indexPath.row]
        cell.descriptionLabel2.text = self.conditionTwoArray[indexPath.row]
        cell.descriptionLabel3.text = self.conditionThreeArray[indexPath.row]
        
        return cell
    }
    
    //MARK: TextField Delegate method
    private func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == self.searchTextField {
            return false; //do not show keyboard nor cursor
        }
        return true
    }
    
    @IBAction func searchTextFieldTouched(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
        let searchScreen = storyBoard.instantiateViewController(withIdentifier: "ConsultOnline_SearcScreenId") as? ConsultOnline_SearcScreen //searchFromVC
        
        searchScreen?.searchFromVC = "fromSearchResultVC"
        
        if (navigationController?.topViewController is ConsultOnline_SearcScreen) {
            return
        } else{
            navigationController?.pushViewController(searchScreen!, animated: true)
        }
    }
    
    //MARK: Naviagtion and Bottom Buttons
    
    
    @IBAction func viewSpecilistsButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
        let doctorsListVC = storyBoard.instantiateViewController(withIdentifier: "DoctorsListId") as? DoctorsList
        
        doctorsListVC?.doctorsListArrayResult = self.doctorsListArrayToSend
        
        if self.specialityTypeArray[0] != ""{
            doctorsListVC?.specialityType = self.specialityTypeArray[0]
            GlobalVariables.sharedManager.specialityTypeForOnlineConsult = self.specialityTypeArray[0]
        }else{
            doctorsListVC?.specialityType = self.pageTitleValue
            GlobalVariables.sharedManager.specialityTypeForOnlineConsult = self.pageTitleValue
        }
        
        if (navigationController?.topViewController is DoctorsList) {
            return
        }else {
            navigationController?.pushViewController(doctorsListVC!, animated: true)
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

