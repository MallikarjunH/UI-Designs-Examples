//
//  BloodPressureLogs.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Alamofire

class BloodPressureLogs: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var mainTableView: UITableView!
   
    var dateArray = [String]()
    var systolicBpArray = [Double]()
    var diastolicBpArray = [Double]()
    var heartRateArray = [Double]()
    var riskLevelArray = [String]()
    var imageUrlArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         NotificationCenter.default.addObserver(self, selector: #selector(self.reloadLogRecords(notification:)), name: Notification.Name("reloadsLogRecords"), object: nil)
        
        // Do any additional setup after loading the view.
        self.mainTableView.tableFooterView = UIView()
        getLogsForBloodPressure()
    }
    
     @objc func reloadLogRecords(notification: Notification) {
        getLogsForBloodPressure()
     }
    
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureLogsCellId", for: indexPath) as! BloodPressureLogsCell
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
             cell.riskLevelDotColor.backgroundColor =  UIColor.orange
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
        GlobalVariables.sharedManager.logValue1 = "\(systolicBpArray[indexPath.row])"
        GlobalVariables.sharedManager.logValue2 = "\(diastolicBpArray[indexPath.row])"
        GlobalVariables.sharedManager.logValue3 = "\(heartRateArray[indexPath.row])"
        
        NotificationCenter.default.post(name: Notification.Name("selectedLogTabFromBloodPressure"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("reloadsLogRecords"), object: nil)
    }
    
    //MARK: GET Logs API Call
    
    func getLogsForBloodPressure(){
        
        if DBHandler.appDelegateShared().isConnectedToNetwork().rawValue == 0
        {
            showAlert(title: "No Internet Connection", message: "Make sure that Wi-Fi or mobile data is turned on, then try again.", vc: self)
            ProgressHUD.dismiss()
            
        }else{
            
            let url = kStagingAPIBaseURLPath + kGetLogsForBloodPressureForHealthLogs
            // let csrfTokenValue = UserDefaults.standard.string(forKey: "csrftoken")
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
                    // debugPrint(JSON)
                    
                    if let responseDataDict = JSON as? NSDictionary{
                        
                        if let statusCode = responseDataDict.object(forKey: "status_code") as? NSNumber{
                            
                            if statusCode == 1{
                                
                                if let bloodPressureLogArray = responseDataDict.object(forKey: "patient_blood_pressure_details") as? [[String:Any]]{
                                    
                                    if bloodPressureLogArray.count > 0{
                                        
                                        self.dateArray = []
                                        self.systolicBpArray = []
                                        self.diastolicBpArray = []
                                        self.heartRateArray = []
                                        self.riskLevelArray = []
                                        self.imageUrlArray = []
                                        
                                        for logsData:Dictionary<String,Any> in bloodPressureLogArray{
                                            
                                            let uploadedDate:String = logsData["uploaded_date"] as? String ?? "2019-08-20"
                                            let riskLevel:String = logsData["risk_level"] as? String ?? ""
                                            let systolicBp:Int = logsData["systolic_bp"] as? Int ?? 0
                                            let diastolicBp:Int = logsData["diastolic_bp"] as? Int ?? 0
                                            let heartRate:Int = logsData["heart_rate"] as? Int ?? 0
                                            let imageUrl:String = logsData["upload_bp_data"] as? String ?? ""                                        // imageURL = String(imageURL.dropFirst())  //removing first character
                                            
                                            // print("\(uploadedDate) \(riskLevel) \(systolicBp) \(diastolicBp) \(heartRate)")
                                            
                                            self.dateArray.append(convertDateFormat2(dobValue: uploadedDate) )
                                            self.systolicBpArray.append(Double(systolicBp))
                                            self.diastolicBpArray.append(Double(diastolicBp))
                                            self.heartRateArray.append(Double(heartRate))
                                            self.riskLevelArray.append(riskLevel)
                                            self.imageUrlArray.append(imageUrl)
                                        }
                                        
                                        GlobalVariables.sharedManager.dateForBPArray = []
                                        GlobalVariables.sharedManager.systolicBpArray = []
                                        GlobalVariables.sharedManager.systolicBpArray  = []
                                        GlobalVariables.sharedManager.heartRateArray  = []
                                        
                                        GlobalVariables.sharedManager.dateForBPArray = self.dateArray
                                        //  GlobalVariables.sharedManager.riskLevelForBPArray = riskLevelArray
                                        // GlobalVariables.sharedManager.imageUrlForBPArray = imageUrlArray
                                        GlobalVariables.sharedManager.systolicBpArray = self.systolicBpArray
                                        GlobalVariables.sharedManager.diastolicBpArray = self.diastolicBpArray
                                        GlobalVariables.sharedManager.heartRateArray = self.heartRateArray
                                        
                                        NotificationCenter.default.post(name: Notification.Name("refreshChartDataValues"), object: nil)
                                        
                                        DispatchQueue.main.async() {
                                            self.mainTableView.reloadData()
                                            ProgressHUD.dismiss()
                                        }
                                        
                                    }else{
                                        //array is empty
                                        showAlert(title: "", message: "No Health logs found, let’s get started by adding your health data here!", vc: self)
                                        ProgressHUD.dismiss()
                                    }
                                } //end if let bloodPressureLogArray line
                                else{
                                    //patient_blood_pressure_details array  is not found
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
