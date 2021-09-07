//
//  ConsultOnlineClinicLists.swift
//  VidalHealth
//
//  Created by mallikarjun on 26/11/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class ConsultOnlineClinicLists: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    var clinicNameArray:[String] = []
    var clinicPicsArray:[String] = []
    
    var clinicPermalinkArray:[String] = []
    
    @IBOutlet weak var searchBGView: UIView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBGView.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
        
        getClinicListApiCall()
    }
    
    
    //MARK: GET CLinics API Call
    
    func getClinicListApiCall(){
        
        ProgressHUD.show("")
        
        let params:[String:Any] = [:]
        
        APIRequester_New.fireGetClinicLists(URLString: kGetTheListInHome, aParams: params as [AnyHashable : Any]) { response ,error in
            
            // print(response)
            
            if let clinicListsArray = response as? [[String:Any]] {
                
                if clinicListsArray.count > 0{
                    
                    self.clinicNameArray = []
                    self.clinicPicsArray = []
                    self.clinicPermalinkArray = []
                    
                    for clinicDictData:Dictionary<String,Any> in clinicListsArray{
                        
                        let clinicName:String = clinicDictData["clinic_name"] as? String ?? ""
                        let clinicPic:String = clinicDictData["clinic_pic"] as? String ?? ""
                        let clinicPermalink:String = clinicDictData["clinic_permalink"] as? String ?? ""
                        
                        self.clinicNameArray.append(clinicName)
                        self.clinicPicsArray.append(clinicPic)
                        self.clinicPermalinkArray.append(clinicPermalink)
                        
                    }
                }
                else{
                    //clinic list is empty //show alert
                    showAlert(title: "Oops!", message: "No Clinics are Available", vc: self)
                    ProgressHUD.dismiss()
                }
                
                DispatchQueue.main.async {
                    
                    self.mainCollectionView.reloadData()
                    ProgressHUD.dismiss()
                }
                
            }
            else{
                //clinicListsArray is not present //something went wrong
                showAlert(title: "Error", message: "Something Went Wrong", vc: self)
                ProgressHUD.dismiss()
            }
            
        }
    }
    
    //MARK: Collection view Datasource and delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return clinicNameArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchDetailsSpcialityCellId", for: indexPath) as! SearchDetailsSpcialityCell
        
        // cell.imageOutlet.image = UIImage(named: sampleImageArray[indexPath.item])
        cell.labelOutlet.text = clinicNameArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // print(indexPath.item)
        let userDefaults = UserDefaults.standard
        userDefaults.set("notFromNotification", forKey: "forYoga")
        
        
        let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
        let searchResultScreen = storyBoard.instantiateViewController(withIdentifier: "SearchResultScreenId") as? SearchResultScreen
        
        searchResultScreen?.getFilterType = "clinic"
        searchResultScreen?.getClinicSlugID = self.clinicPermalinkArray[indexPath.row]
        searchResultScreen?.getNavigationTitle = self.clinicNameArray[indexPath.row]
        searchResultScreen?.scheduleConsultationClinicSlug = self.clinicPermalinkArray[indexPath.row]
        
        GlobalVariables.sharedManager.clinicPermalink = self.clinicPermalinkArray[indexPath.row]
        
        if (navigationController?.topViewController is SearchResultScreen) {
            return
        }else {
            navigationController?.pushViewController(searchResultScreen!, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.mainCollectionView.frame.width/3.0) - 12 , height: 105)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    //MARK: TextField Delegate method
    private func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == self.searchTextField {
            return false; //do not show keyboard nor cursor
        }
        return true
    }
    
    //MARK: Search Button Action // SearchResultScreenId  DoctorsList
    
    @IBAction func searchTextFieldTouched(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
        let searchScreen = storyBoard.instantiateViewController(withIdentifier: "ConsultOnline_SearcScreenId") as? ConsultOnline_SearcScreen
        searchScreen?.searchFromVC = "fromClinicListsVC"
        
        if (navigationController?.topViewController is ConsultOnline_SearcScreen) {
            return
        } else{
            navigationController?.pushViewController(searchScreen!, animated: true)
        }
    }
    
    //MARK: Back and Navigation Buttons
    
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
    
    @IBAction func emergencyCallButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(emergencyVC, animated: true)
        }
    }
    
    
    
}
