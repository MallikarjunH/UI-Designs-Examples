//
//  BloodSugarLogs.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Alamofire

class BloodSugarLogs: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var mainTableView: UITableView!
   
    var dateArray = [String]()
    var imageUrlArray = [String]()
    var riskLevelArray = [String]()
    
    var fastingArray = [Double]()
    var randomBpArray = [Double]()
    var postPrandialArray = [Double]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadLogRecords(notification:)), name: Notification.Name("reloadsLogRecordsForBS"), object: nil)
        
        // Do any additional setup after loading the view.
        self.mainTableView.tableFooterView = UIView()
        getLogsForBloodSugar()
    }
    
    @objc func reloadLogRecords(notification: Notification) {
        getLogsForBloodSugar()
    }

    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BloodSugarLogsCellId", for: indexPath) as! BloodSugarLogsCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        cell.dateLabel.text = dateArray[indexPath.row]
       
        let riskLevelValue = riskLevelArray[indexPath.row]
        
        if riskLevelValue == "Healthy"{
            
            cell.riskLevelImage.image = UIImage(named: "Healthy")
            cell.riskLevelLabel.text = "Healthy"
            cell.riskLevelLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
            cell.riskLevelDotColor.backgroundColor =  UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
        }else{
            cell.riskLevelImage.image = UIImage(named: "Needs_Attention")
            cell.riskLevelLabel.text = "Needs Attention"
            cell.riskLevelLabel.textColor = UIColor.orange
            cell.riskLevelDotColor.backgroundColor =   UIColor.orange
        }
        
        if let url = URL(string: "http://someserver/\(imageUrlArray[indexPath.row])") {
            if url.lastPathComponent == "/" {
                cell.fileNameLabel.text = ""
                cell.view2.isHidden = true
            }else{
                cell.fileNameLabel.text = url.lastPathComponent //print(url.lastPathComponent)
                cell.view2.isHidden = false
            }
        }else{
            
            cell.fileNameLabel.text = ""
            cell.view2.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height:CGFloat = CGFloat()
        mainTableView.rowHeight = UITableViewAutomaticDimension
        height =  mainTableView.rowHeight
        
        return height //112.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        GlobalVariables.sharedManager.dateValue = dateArray[indexPath.row]
        GlobalVariables.sharedManager.logValue1 = "\(fastingArray[indexPath.row])"
        GlobalVariables.sharedManager.logValue2 = "\(randomBpArray[indexPath.row])"
        GlobalVariables.sharedManager.logValue3 = "\(postPrandialArray[indexPath.row])"
        
        NotificationCenter.default.post(name: Notification.Name("selectedLogTabFromBloodSugar"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("reloadsLogRecordsForBS"), object: nil)
    }
    
    //MARK: GET Logs API Call
    
    func getLogsForBloodSugar(){
        
        if DBHandler.appDelegateShared().isConnectedToNetwork().rawValue == 0
        {
            showAlert(title: "No Internet Connection", message: "Make sure that Wi-Fi or mobile data is turned on, then try again.", vc: self)
            ProgressHUD.dismiss()
            
        }else{
           
            let url = kStagingAPIBaseURLPath + kGetLogsForBloodSugarForHealthLogs
            //let csrfTokenValue = UserDefaults.standard.string(forKey: "csrftoken")
            var  csrfTokenValue = ""
            if (AppUtilities.getCSFRToken() != nil)
            {
                csrfTokenValue = AppUtilities.getCSFRToken()
            }
            
            var patientSlugValue = ""
            let lPatient = AppUtilities.getCurrentSelectedPatientInMyFamily()
            
            if lPatient!.patient_slug != nil {
                patientSlugValue = lPatient!.patient_slug!
            } else {
                patientSlugValue = ""
            }
            
            let params: [String: Any] = [
                "patient_slug": patientSlugValue
            ]
            
            
            let headers: HTTPHeaders = [
                "X-CSRFToken": csrfTokenValue,
                "Content-Type": "application/json"
            ]
            
            ProgressHUD.show("Loading...")
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(let JSON):
                    //debugPrint(JSON)
                    
                    if let responseDataDict = JSON as? NSDictionary{
                        
                        if let statusCode = responseDataDict.object(forKey: "status_code") as? NSNumber{
                            
                            if statusCode == 1{
                                
                                if let bloodPressureLogArray = responseDataDict.object(forKey: "patient_blood_sugar_details") as? [[String:Any]]{
                                    
                                    if bloodPressureLogArray.count > 0{
                                        
                                        self.dateArray = []
                                        self.fastingArray = []
                                        self.randomBpArray = []
                                        self.postPrandialArray = []
                                        self.riskLevelArray = []
                                        self.imageUrlArray = []
                                        
                                        for logsData:Dictionary<String,Any> in bloodPressureLogArray{
                                            
                                            let uploadedDate:String = logsData["uploaded_date"] as? String ?? "2019-08-20"
                                            let riskLevel:String = logsData["risk_level"] as? String ?? ""
                                            let fastingValue:Int = logsData["fasting"] as? Int ?? 0
                                            let randomValue:Int = logsData["random"] as? Int ?? 0
                                            let post_prandiaValue:Int = logsData["post_prandial"] as? Int ?? 0
                                            let imageUrl:String = logsData["upload_bs_data"] as? String ?? ""                                        // imageURL = String(imageURL.dropFirst())  //removing first character
                                            
                                            // print("\(uploadedDate) \(riskLevel) \(systolicBp) \(diastolicBp) \(heartRate)")
                                            
                                            self.dateArray.append(convertDateFormat2(dobValue: uploadedDate) )
                                            self.fastingArray.append(Double(fastingValue))
                                            self.randomBpArray.append(Double(randomValue))
                                            self.postPrandialArray.append(Double(post_prandiaValue))
                                            self.riskLevelArray.append(riskLevel)
                                            self.imageUrlArray.append(imageUrl)
                                        }
                                        
                                        GlobalVariables.sharedManager.dateForBSArray = []
                                        GlobalVariables.sharedManager.fastingArray = []
                                        GlobalVariables.sharedManager.randomBpArray = []
                                        GlobalVariables.sharedManager.postPrandialArray = []
                                        
                                        GlobalVariables.sharedManager.dateForBSArray = self.dateArray
                                        GlobalVariables.sharedManager.fastingArray = self.fastingArray
                                        GlobalVariables.sharedManager.randomBpArray = self.randomBpArray
                                        GlobalVariables.sharedManager.postPrandialArray = self.postPrandialArray
                                        
                                        NotificationCenter.default.post(name: Notification.Name("refreshChartDataValues1"), object: nil)
                                        
                                        DispatchQueue.main.async() {
                                            self.mainTableView.reloadData()
                                            ProgressHUD.dismiss()
                                        }
                                        
                                    }else{
                                        //array is empty
                                        showAlert(title: "", message: "No Health logs found, let’s get started by adding your health data here!", vc: self)
                                        ProgressHUD.dismiss()
                                    }
                                } //end if let bloodSugarLogArray line
                                else{
                                    //patient_blood_sugar_details array  is not found
                                    // showAlert(title: "Alert", message: "Array is empty", vc: self)
                                    // ProgressHUD.dismiss()
                                }
                                
                            }else{
                                //status code not 1
                                showAlert(title: "", message: "No Health logs found, let’s get started by adding your health data here!", vc: self)
                                ProgressHUD.dismiss()
                            }
                            
                        }else{
                            //somethig went erong // status code is not there
                            if let responseDataDict = JSON as? NSDictionary {
                                
                                if let msgDetails = responseDataDict.object(forKey: "detail") as? String{
                                    
                                    //showAlert(title: "Error", message: msgDetails, vc: self)
                                    print(msgDetails)
                                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                                    appDelegate?.performLogoutActionFromTheApp()
                                }else{
                                    
                                    showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                                }
                            }
                            ProgressHUD.dismiss()
                        }
                    }
                    else{
                        //somethig went erong //josn not there
                        showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                        ProgressHUD.dismiss()
                    }
                    
                case .failure(let error):
                    debugPrint(error)
                    showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                    ProgressHUD.dismiss()
                }
            }
            
        }//end else of check internet connection
    }

}
