//
//  BabyBumbTrackerMainVC.swift
//  VidalHealth
//
//  Created by mallikarjun on 04/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Alamofire

class BabyBumbTrackerMainVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { //month1
    
    var monthArray = ["1st Month","2nd Month","3rd Month","4th Month","5th Month","6th Month","7th Month","8th Month","9th Month"]
    var monthImgArray = ["month1","month2","month3","month4","month5","month6","month7","month8","month9"]
    
    var imgUrlArray:[String] = ["http://14.143.33.76/media/health_tools_media/bbt/l7toFZgevi/1567142584791.PNG","http://14.143.33.76/media/health_tools_media/bbt/l7toFZgevi/1567142584791.PNG","http://14.143.33.76/media/health_tools_media/bbt/l7toFZgevi/1567142584791.PNG","http://14.143.33.76/media/health_tools_media/bbt/l7toFZgevi/1567142584791.PNG","http://14.143.33.76/media/health_tools_media/bbt/l7toFZgevi/1567142584791.PNG","http://14.143.33.76/media/health_tools_media/bbt/l7toFZgevi/1567142584791.PNG","http://14.143.33.76/media/health_tools_media/bbt/l7toFZgevi/1567142584791.PNG","http://14.143.33.76/media/health_tools_media/bbt/l7toFZgevi/1567142584791.PNG","http://14.143.33.76/media/health_tools_media/bbt/l7toFZgevi/1567142584791.PNG",]
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadView(notification:)), name: Notification.Name("GetImagesRefreshCall"), object: nil)
        getImagesAPICall()
        //print("I m in vies didload")
    }
    
    
    @objc func reloadView(notification: Notification) {
        
        getImagesAPICall()
       // print("I m in reloadView notifications")
    }
    
    //MARK: Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return monthArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BabyBumbTrackerMainCellId", for: indexPath) as! BabyBumbTrackerMainCell
        
        // cell.mainBackgroundImage.isHidden = true
        //  cell.sampleFrontImage.isHidden = false
        // cell.gradientImgView.isHidden = true
        //  cell.sampleFrontImage.image = UIImage(named: monthImgArray[indexPath.item])
        //  cell.monthLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        cell.monthLabel.text = monthArray[indexPath.item]
        

       /* if imgUrlArray[indexPath.item] != ""{
            
            var image:UIImage? = nil
            
            let imageUrl:NSURL = NSURL(string: imgUrlArray[indexPath.item])!
            if let imageData:NSData = NSData(contentsOf: imageUrl as URL){
                
                image = UIImage(data: imageData as Data)
            }
            
            DispatchQueue.main.async() {
                cell.mainBackgroundImage.isHidden = false
                cell.mainBackgroundImage.image  = image
                cell.sampleFrontImage.isHidden = true
                cell.monthLabel.textColor = UIColor.white
                cell.gradientImgView.isHidden = false
            }
        } */
        
        /*let imageData:NSData = try! NSData(contentsOf: imageUrl as URL)
        guard let data = imageData else {
            return
        } */
        
        if imgUrlArray[indexPath.item] != ""{
            
            var image:UIImage? = nil
            
            let imageUrl:NSURL = NSURL(string: imgUrlArray[indexPath.item])!
            if let imageData:NSData = NSData(contentsOf: imageUrl as URL){
                
                image = UIImage(data: imageData as Data)
            }
    
            DispatchQueue.main.async() {
                cell.mainBackgroundImage.isHidden = false
                cell.mainBackgroundImage.image  = image
                cell.sampleFrontImage.isHidden = true
                cell.monthLabel.textColor = UIColor.white
                cell.gradientImgView.isHidden = false
            }
        }
        else{
            
            cell.mainBackgroundImage.isHidden = true
            cell.sampleFrontImage.isHidden = false
            cell.sampleFrontImage.image = UIImage(named: monthImgArray[indexPath.item])
            cell.gradientImgView.isHidden = true
            cell.monthLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.item)
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "BabyBumbTrackerDetailsVCId") as? BabyBumbTrackerDetailsVC
        GlobalVariables.sharedManager.babyMonth = monthArray[indexPath.item] //month number
        GlobalVariables.sharedManager.babyMonthImg = monthImgArray[indexPath.item] // sample image place holder
        
        GlobalVariables.sharedManager.babyImgUrl = imgUrlArray[indexPath.item]
        /*  if imgUrlArray[indexPath.item] != ""{
         
         getDataFromImage(from: imgUrlArray[indexPath.item]) { data, response, error in
         guard let data = data, error == nil else { return }
         GlobalVariables.sharedManager.uploadedImageFoTheMonth = data
         }
         }
         else{
         GlobalVariables.sharedManager.uploadedImageFoTheMonth = nil
         } */
        self.navigationController?.pushViewController(detailsVC!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize: CGSize
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width - 40
        
        cellSize = CGSize(width: screenWidth / 2.0, height: 235)
        
        return cellSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 13, bottom: 10, right: 13)
    }
    
    
    //MARK: API Call - To Get Images for 9 months
    
    func getImagesAPICall(){
    
        if DBHandler.appDelegateShared().isConnectedToNetwork().rawValue == 0
        {
            showAlert(title: "No Internet Connection", message: "Make sure that Wi-Fi or mobile data is turned on, then try again.", vc: self)
            ProgressHUD.dismiss()
           // return
        }
        else{
            
            imgUrlArray = []
            
            self.imgUrlArray.append("") //month 1
            self.imgUrlArray.append("") //month 2
            self.imgUrlArray.append("") //month 3
            self.imgUrlArray.append("") //month 4
            self.imgUrlArray.append("") //month 5
            self.imgUrlArray.append("")  //month 6
            self.imgUrlArray.append("") //month 7
            self.imgUrlArray.append("") //month 8
            self.imgUrlArray.append("") //month 9
            
            ProgressHUD.show("Loading...")
            
            let url  =   AppUtilities.getBaseURL() + kGetNineMonthsImagesForBBT
            
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
            
            let headersParams: HTTPHeaders = [
                //"Content-Type": "application/json",
                // "Accept": "application/json",
                "X-CSRFToken": csrfTokenValue,
            ]
            
            /*  print(csrfTokenValue!)
             print(GlobalVariables.sharedManager.patientSlug) */
            
            Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headersParams).responseJSON { (response) in
                switch response.result {
                case .success(let JSON):
                    //  debugPrint(JSON)
                    
                    if let responseDataDict = JSON as? NSDictionary{
                        
                        if let statusCode = responseDataDict.object(forKey: "status_code") as? NSNumber {
                            // // print(statusCode)
                            if statusCode == 1{
                                
                                let imageArray = responseDataDict.object(forKey: "images_data") as! [[String:Any]]
                                
                                if imageArray.count > 0{
                                    
                                    for imageData:Dictionary<String,Any> in imageArray{
                                        
                                        let month:String = imageData["month"] as? String ?? "1"
                                        var imageURL:String = imageData["photo"] as? String  ?? "http://14.143.33.76/media/health_tools_media/bbt/l7toFZgevi/1567142584791.PNG"
                                        imageURL = String(imageURL.dropFirst())  //removing first character
                                        
                                        let imgUrl = AppUtilities.getBaseURL() + imageURL
                                        // print(month); print(imgUrl)
                                        if month == "1"{
                                            
                                            self.imgUrlArray[0].append(imgUrl)
                                        }
                                        else if month == "2"{
                                            
                                            self.imgUrlArray[1].append(imgUrl)
                                        }
                                        else if month == "3"{
                                            
                                            self.imgUrlArray[2].append(imgUrl)
                                        }
                                        else if month == "4"{
                                            
                                            self.imgUrlArray[3].append(imgUrl)
                                        }
                                        else if month == "5"{
                                            
                                            self.imgUrlArray[4].append(imgUrl)
                                        }
                                        else if month == "6"{
                                            
                                            self.imgUrlArray[5].append(imgUrl)
                                        }
                                        else if month == "7"{
                                            
                                            self.imgUrlArray[6].append(imgUrl)
                                        }
                                        else if month == "8"{
                                            
                                            self.imgUrlArray[7].append(imgUrl)
                                        }
                                        else if month == "9"{
                                            
                                            self.imgUrlArray[8].append(imgUrl)
                                        }else{
                                            //none
                                        }
                                        
                                    } //end for
                                } //end if imageArray.count > 0{
                                else{
                                    //array is empty
                                }
                                
                                //  print(self.imgUrlArray)
                                DispatchQueue.main.async() {
                                    self.mainCollectionView.reloadData()
                                    ProgressHUD.dismiss()
                                }
                                
                            }else{
                                //if statusCode == 1 end => status code is 0
                                ProgressHUD.dismiss()
                            }
                        } //end if let statusCode
                        else{
                            //show error //status code not found
                            if let responseDataDict = JSON as? NSDictionary {
                                
                                if let msgDetails = responseDataDict.object(forKey: "detail") as? String{
                                    // showAlert(title: "Error", message: msgDetails, vc: self)
                                    print(msgDetails)
                                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                                    appDelegate?.performLogoutActionFromTheApp()
                                    
                                }else{
                                    
                                    showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                                }
                            }
                            ProgressHUD.dismiss()
                        }
                    }else{
                        //json error //json not found
                        showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                        ProgressHUD.dismiss()
                    }
                    
                    
                case .failure(let error):
                    //debugPrint(error)
                    print("Request failed with error: \(error)")
                    showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                    ProgressHUD.dismiss()
                }
            }
        }
        

    }
    
   
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("GetImagesRefreshCall"), object: nil)
    }
    
    //MARK: Navigation Buttons & Bottom Buttons
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
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
    
    
    @IBAction func notificationButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let notificationVC = storyBoard.instantiateViewController(withIdentifier: "Notifications") as! Notifications
        if ((self.navigationController?.topViewController?.isKind(of: Notifications.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(notificationVC, animated: true)
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
    
}

