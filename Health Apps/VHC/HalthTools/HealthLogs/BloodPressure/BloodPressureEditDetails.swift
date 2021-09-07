//
//  BloodPressureEditDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Photos
import Alamofire

class BloodPressureEditDetails: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIDocumentPickerDelegate,UIDocumentMenuDelegate {
   
    
    
    var uploadFileButtonClicked = false
    var uploadedFileName = ""
    var currentUpload : Int = 0
    
    var systolicBPValue = ""
    var diastolicBPValue = ""
    var heartRateValue = ""
    var reminderValue = ""
    
    var riskLevel1 = ""
    var riskLevel2 = ""
    var riskLevel3 = ""
    
    var validateTestArrayForButton = [String]()
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var saveButtonOutlet: UIButton!
  
     var paramTOAdd:[String:Any] = ["documentType":"","documentName":"","documentData":"","documentSize":"","fileType":"","fileExtension":""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
            
            saveButtonOutlet.isHidden = true
        }
        // Do any additional setup after loading the view.
        paramTOAdd["documentData"] = nil
        
        validateTestArrayForButton.append("0")
        validateTestArrayForButton.append("0")
        validateTestArrayForButton.append("0")
        
        self.mainTableView.tableFooterView = UIView()
    }
    
    //MARK: TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
            
            return 4
        }else{
            
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureViewAndEditCell1Id", for: indexPath) as! BloodPressureViewAndEditCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                
                cell.firstCellImg.isHidden = true
                cell.firstCellLabel.text = GlobalVariables.sharedManager.dateValue //"28 March 2019"
            }
            else{
                cell.firstCellImg.isHidden = false
                cell.firstCellLabel.text = "Enter your health record"
            }
            return cell
        }
        else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureViewAndEditCell2Id", for: indexPath) as! BloodPressureViewAndEditCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                
                cell.systolicBPTextField.text =  GlobalVariables.sharedManager.logValue1
                cell.systolicBPPriorityBGView.isHidden = true
            }
            else{
                
                if systolicBPValue.isEmpty{
                    cell.systolicBPPriorityBGView.isHidden = true
                    cell.systolicBPTextField.text = ""
                    validateTestArrayForButton[0] = "0"
                }else{
                    
                    validateTestArrayForButton[0] = "1"
                    cell.systolicBPTextField.text = systolicBPValue
                    cell.systolicBPPriorityBGView.isHidden = false
                    
                    let systolicValue = Int(systolicBPValue)
                    
                    if diastolicBPValue == ""{
                        
                        if systolicValue! > 180{
                            cell.systolicBPPriorityLabel.text = "Hypertensive "
                            cell.systolicBPPriorityLabel.textColor =  UIColor.red //UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1)
                            cell.systolicBPPriorityColorView.backgroundColor =  UIColor.red  //UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1)
                            riskLevel1 = "Needs Attention"
                        }
                        else if systolicValue! > 139 && systolicValue! < 181{
                            cell.systolicBPPriorityLabel.text = "High (Stage 2)"
                            cell.systolicBPPriorityLabel.textColor =  UIColor.red
                            cell.systolicBPPriorityColorView.backgroundColor =  UIColor.red
                            riskLevel1 = "Needs Attention"
                        }
                        else if systolicValue! > 129 && systolicValue! < 140{
                            cell.systolicBPPriorityLabel.text = "High (Stage 1)"
                            cell.systolicBPPriorityLabel.textColor =  UIColor.red
                            cell.systolicBPPriorityColorView.backgroundColor = UIColor.red
                            riskLevel1 = "Needs Attention"
                        }
                        else if systolicValue! > 119 && systolicValue! < 130{
                            cell.systolicBPPriorityLabel.text = "Elevated     "
                            cell.systolicBPPriorityLabel.textColor =  UIColor.red
                            cell.systolicBPPriorityColorView.backgroundColor = UIColor.red
                            riskLevel1 = "Needs Attention"
                        }
                        else if systolicValue! > 89 && systolicValue! < 120{
                            cell.systolicBPPriorityLabel.text = "Normal       "
                            cell.systolicBPPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                            cell.systolicBPPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                            riskLevel1 = "Healthy"
                        }
                        else if systolicValue! < 90{
                            cell.systolicBPPriorityLabel.text = "Low          "
                            cell.systolicBPPriorityLabel.textColor =  UIColor.red
                            cell.systolicBPPriorityColorView.backgroundColor =   UIColor.red
                            riskLevel1 = "Needs Attention"
                        }
                    }
                    else{ // diastolicBPValue is not empty
                        
                        let diastolicValue = Int(diastolicBPValue)
                        
                        if systolicValue! < 90 && diastolicValue! < 60 {
                            cell.systolicBPPriorityLabel.text = "Low          "
                            cell.systolicBPPriorityLabel.textColor =  UIColor.red
                            cell.systolicBPPriorityColorView.backgroundColor =   UIColor.red
                            riskLevel1 = "Needs Attention"
                        }
                        else if ( systolicValue! < 120  && systolicValue! > 89 ) && ( diastolicValue! < 80 &&  diastolicValue! > 59 ) {
                            cell.systolicBPPriorityLabel.text = "Normal       "
                            cell.systolicBPPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                            cell.systolicBPPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                            riskLevel1 = "Healthy"
                        }
                        else if (systolicValue! < 130 && systolicValue! > 119) && ( diastolicValue! < 80 && diastolicValue! < 59 ){
                            cell.systolicBPPriorityLabel.text = "Elevated     "
                            cell.systolicBPPriorityLabel.textColor =  UIColor.red
                            cell.systolicBPPriorityColorView.backgroundColor = UIColor.red
                            riskLevel1 = "Needs Attention"
                        }
                        else if (systolicValue! < 140 && systolicValue! > 129) && (diastolicValue! < 90 && diastolicValue! > 79){
                            cell.systolicBPPriorityLabel.text = "High (Stage 1)"
                            cell.systolicBPPriorityLabel.textColor =  UIColor.red
                            cell.systolicBPPriorityColorView.backgroundColor = UIColor.red
                            riskLevel1 = "Needs Attention"
                        }
                        else if (systolicValue! > 139 && systolicValue! < 181 ) && ( diastolicValue! > 89 && diastolicValue! < 121 ){
                        
                                cell.systolicBPPriorityLabel.text = "High (Stage 2)"
                                cell.systolicBPPriorityLabel.textColor =  UIColor.red
                                cell.systolicBPPriorityColorView.backgroundColor =  UIColor.red
                                riskLevel1 = "Needs Attention"
                           
                        }
                        else if systolicValue! > 180 && diastolicValue! > 120 {
                            cell.systolicBPPriorityLabel.text = "Hypertensive "
                            cell.systolicBPPriorityLabel.textColor =  UIColor.red //UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1)
                            cell.systolicBPPriorityColorView.backgroundColor =  UIColor.red  //UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1)
                            riskLevel1 = "Needs Attention"
                        }//if systolic value is > 140 and distoloc value > 90
                        else{
                            if systolicValue! < 90 {
                                cell.systolicBPPriorityLabel.text = "Low          "
                                cell.systolicBPPriorityLabel.textColor =  UIColor.red
                                cell.systolicBPPriorityColorView.backgroundColor =   UIColor.red
                                riskLevel1 = "Needs Attention"
                            }
                            else if systolicValue! < 120 && systolicValue! > 89 {
                                cell.systolicBPPriorityLabel.text = "Normal       "
                                cell.systolicBPPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                                cell.systolicBPPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                                riskLevel1 = "Healthy"
                            }
                            else if systolicValue! < 130 && systolicValue! > 119 {
                                cell.systolicBPPriorityLabel.text = "Elevated     "
                                cell.systolicBPPriorityLabel.textColor =  UIColor.red
                                cell.systolicBPPriorityColorView.backgroundColor = UIColor.red
                                riskLevel1 = "Needs Attention"
                            }
                            else if systolicValue! < 140 && systolicValue! > 129 {
                                cell.systolicBPPriorityLabel.text = "High (Stage 1)"
                                cell.systolicBPPriorityLabel.textColor =  UIColor.red
                                cell.systolicBPPriorityColorView.backgroundColor = UIColor.red
                                riskLevel1 = "Needs Attention"
                            }
                            else if systolicValue! > 139 && systolicValue! < 181 {
                                cell.systolicBPPriorityLabel.text = "High (Stage 2)"
                                cell.systolicBPPriorityLabel.textColor =  UIColor.red
                                cell.systolicBPPriorityColorView.backgroundColor =  UIColor.red
                                riskLevel1 = "Needs Attention"
                            }else{
                                cell.systolicBPPriorityLabel.text = "Hypertensive "
                                cell.systolicBPPriorityLabel.textColor =  UIColor.red
                                cell.systolicBPPriorityColorView.backgroundColor =  UIColor.red
                                riskLevel1 = "Needs Attention"
                            }
                        }
                    }
                    
                } //end else
            } //end else of if GlobalVariables...

            return cell
        }
        else if indexPath.section == 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureViewAndEditCell3Id", for: indexPath) as! BloodPressureViewAndEditCell3
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
             if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                
                cell.diastolicBPTextField.text = GlobalVariables.sharedManager.logValue2
                cell.diastolicBPPriorityBGView.isHidden = true
             }
             else{
                
                if diastolicBPValue.isEmpty{
                    cell.diastolicBPPriorityBGView.isHidden = true
                    cell.diastolicBPTextField.text = ""
                    validateTestArrayForButton[1] = "0"
                }else{
                    
                    validateTestArrayForButton[1] = "1"
                    cell.diastolicBPTextField.text = diastolicBPValue
                    cell.diastolicBPPriorityBGView.isHidden = false
                    
                    let diastolicValue = Int(diastolicBPValue)
                    
                    if systolicBPValue == ""{
                       
                        if diastolicValue! > 120{
                            cell.diastolicBPPriorityLabel.text = "Hypertensive "
                            cell.diastolicBPPriorityLabel.textColor = UIColor.red
                            cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                            riskLevel2 = "Needs Attention"
                        }
                        else if diastolicValue! > 89 && diastolicValue! < 121{
                            cell.diastolicBPPriorityLabel.text = "High (Stage 2)"
                            cell.diastolicBPPriorityLabel.textColor = UIColor.red
                            cell.diastolicBPPriorityColorView.backgroundColor =  UIColor.red
                            riskLevel2 = "Needs Attention"
                        }
                        else if diastolicValue! > 79 && diastolicValue! < 90{
                            cell.diastolicBPPriorityLabel.text = "High (Stage 1)"
                            cell.diastolicBPPriorityLabel.textColor = UIColor.red
                            cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                            riskLevel2 = "Needs Attention"
                        }
                        else if diastolicValue! > 59 && diastolicValue! < 80{
                            cell.diastolicBPPriorityLabel.text = "Normal       "
                            cell.diastolicBPPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                            cell.diastolicBPPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                            riskLevel2 = "Healthy"
                        }
                        else if diastolicValue! < 60{
                            cell.diastolicBPPriorityLabel.text = "Low          "
                            cell.diastolicBPPriorityLabel.textColor = UIColor.red
                            cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                            riskLevel2 = "Needs Attention"
                        }
                    }
                    else{ // systolicBPValue is not empty
                        
                        let systolicValue = Int(systolicBPValue)
                        
                        if systolicValue! < 90 && diastolicValue! < 60 {
                            cell.diastolicBPPriorityLabel.text = "Low          "
                            cell.diastolicBPPriorityLabel.textColor = UIColor.red
                            cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                            riskLevel2 = "Needs Attention"
                        }
                        else if ( systolicValue! < 120  && systolicValue! > 89 ) && ( diastolicValue! < 80 &&  diastolicValue! > 59 ) {
                            cell.diastolicBPPriorityLabel.text = "Normal       "
                            cell.diastolicBPPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                            cell.diastolicBPPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                            riskLevel2 = "Healthy"
                        }
                        else if (systolicValue! < 130 && systolicValue! > 119) && ( diastolicValue! < 80 && diastolicValue! < 59 ){
                            cell.diastolicBPPriorityLabel.text = "Elevated     "
                            cell.diastolicBPPriorityLabel.textColor =  UIColor.red
                            cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                            riskLevel2 = "Needs Attention"
                        }
                        else if (systolicValue! < 140 && systolicValue! > 129) && (diastolicValue! < 90 && diastolicValue! > 79){
                            cell.diastolicBPPriorityLabel.text = "High (Stage 1)"
                            cell.diastolicBPPriorityLabel.textColor = UIColor.red
                            cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                            riskLevel2 = "Needs Attention"
                        }
                        else if (systolicValue! > 139 && systolicValue! < 181 ) && ( diastolicValue! > 89 && diastolicValue! < 121 ){
                            cell.diastolicBPPriorityLabel.text = "High (Stage 2)"
                            cell.diastolicBPPriorityLabel.textColor = UIColor.red
                            cell.diastolicBPPriorityColorView.backgroundColor =  UIColor.red
                            riskLevel2 = "Needs Attention"
                    
                        }
                        else if systolicValue! > 180 && diastolicValue! > 120 {
                                cell.diastolicBPPriorityLabel.text = "Hypertensive "
                                cell.diastolicBPPriorityLabel.textColor = UIColor.red
                                cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                                riskLevel2 = "Needs Attention"
                        }
                        else{
                            if systolicValue! < 90 {
                                cell.diastolicBPPriorityLabel.text = "Low          "
                                cell.diastolicBPPriorityLabel.textColor = UIColor.red
                                cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                                riskLevel2 = "Needs Attention"
                            }
                            else if systolicValue! < 120 && systolicValue! > 89 {
                                cell.diastolicBPPriorityLabel.text = "Normal       "
                                cell.diastolicBPPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                                cell.diastolicBPPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                                riskLevel2 = "Healthy"
                            }
                            else if systolicValue! < 130 && systolicValue! > 119 {
                                cell.diastolicBPPriorityLabel.text = "Elevated     "
                                cell.diastolicBPPriorityLabel.textColor =  UIColor.red
                                cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                                riskLevel2 = "Needs Attention"
                            }
                            else if systolicValue! < 140 && systolicValue! > 129 {
                                cell.diastolicBPPriorityLabel.text = "High (Stage 1)"
                                cell.diastolicBPPriorityLabel.textColor = UIColor.red
                                cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                                riskLevel2 = "Needs Attention"
                            }
                            else if systolicValue! > 139 && systolicValue! < 181 {
                                cell.diastolicBPPriorityLabel.text = "High (Stage 2)"
                                cell.diastolicBPPriorityLabel.textColor = UIColor.red
                                cell.diastolicBPPriorityColorView.backgroundColor =  UIColor.red
                                riskLevel2 = "Needs Attention"
                            }else{
                                cell.diastolicBPPriorityLabel.text = "Hypertensive "
                                cell.diastolicBPPriorityLabel.textColor = UIColor.red
                                cell.diastolicBPPriorityColorView.backgroundColor = UIColor.red
                                riskLevel2 = "Needs Attention"
                            }
                            
                        }
                    }
                }
            }
            
            return cell
        }
        else if indexPath.section == 3{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureViewAndEditCell4Id", for: indexPath) as! BloodPressureViewAndEditCell4
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                cell.heartRateTextField.text = GlobalVariables.sharedManager.logValue3
                cell.heartRatePriorityBGView.isHidden = true
            }
            else{
                
                if heartRateValue.isEmpty{
                    cell.heartRatePriorityBGView.isHidden = true
                    cell.heartRateTextField.text = ""
                    validateTestArrayForButton[2] = "0"
                }else{
                    
                    validateTestArrayForButton[2] = "1"
                    cell.heartRateTextField.text = heartRateValue
                    cell.heartRatePriorityBGView.isHidden = false
                    
                    let value = Int(heartRateValue)
                    
                    if value! > 100{
                        cell.heartRatePriorityLabel.text = "High         "
                        cell.heartRatePriorityLabel.textColor = UIColor.red
                        cell.heartRatePriorityColorView.backgroundColor = UIColor.red
                        riskLevel3 = "Needs Attention"
                    }
                    else if value! > 59 && value! < 101{
                        cell.heartRatePriorityLabel.text = "Normal       "
                        cell.heartRatePriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        cell.heartRatePriorityColorView.backgroundColor =  UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        riskLevel3 = "Healthy"
                    }
                    else if value! < 60{
                        cell.heartRatePriorityLabel.text = "Low          "
                        cell.heartRatePriorityLabel.textColor = UIColor.red
                        cell.heartRatePriorityColorView.backgroundColor = UIColor.red
                        riskLevel3 = "Needs Attention"
                    }
                    
                }
                
                if validateTestArrayForButton[0] == "1" &&  validateTestArrayForButton[1] == "1" && validateTestArrayForButton[2] == "1" {
                    
                    saveButtonOutlet.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                }
                else{
                      saveButtonOutlet.backgroundColor =  UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
                }
            }
            
            return cell
        }
        else if indexPath.section == 4{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureViewAndEditCell5Id", for: indexPath) as! BloodPressureViewAndEditCell5
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if paramTOAdd["documentData"] != nil{
             
                //let ext =  paramTOAdd["fileExtension"] as! String
                cell.cancelImage.isHidden = false
                cell.selectedFileNameLabel.text = uploadedFileName //+ "." + ext
            }else{
                
                cell.cancelImage.isHidden = true
                cell.selectedFileNameLabel.text = ""
            }
        
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            cell.cancelButtonHiddenButton.addTarget(self, action: #selector(cancelSelectedImageClick(sender:)), for: .touchUpInside)
            cell.uploadImage.isUserInteractionEnabled = true
            cell.uploadImage.addGestureRecognizer(tapGestureRecognizer)
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressureViewAndEditCell6Id", for: indexPath) as! BloodPressureViewAndEditCell6
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            cell.addReminderTextField.text = reminderValue
            
            return cell
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 4{
            
            uploadFileButtonClicked = true
            
            if let array = [indexPath] as? [IndexPath] {
                tableView.reloadRows(at: array, with: .fade)
            }
            return
        }
        else{
            
        }
    }
  /*  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 4{
            
            uploadFileButtonClicked = true
             // tableView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
              let indexPathRow:Int = 0
              let indexPosition = IndexPath(row: indexPathRow, section: 4)
              tableView.reloadRows(at: [indexPosition], with: .top)
            
             // mainTableView.reloadData()
            }
        else{
            
        }
        
    } */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
      if indexPath.section == 4{
        
        if uploadFileButtonClicked{
                
                return 102.0
        }else{
               return  70.0
              }
            
      }else{
            
            return 70.0
        }
        
    }
    
    //MARK: Cancel Uploaded Image
     @objc func cancelSelectedImageClick(sender:UIButton){
        
         paramTOAdd["documentData"] = nil
         uploadFileButtonClicked = false
         self.mainTableView.reloadData()
    }
    
    //MARK: Upload Image Action
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Clicked on upload")
        uploadFileButtonClicked = true
       
        let alertController = UIAlertController(title: "Upload Document", message: "Tap to upload Documents", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            self.openPhotoMedia(mediaType:"TakePhoto")
            //print("Default is pressed.....")
        }
        let action2 = UIAlertAction(title: "Upload Photo", style: .default) { (action) in
            
            // print("Cancel is pressed......")
            self.openPhotoMedia(mediaType:"UploadPhoto")
        }
        let action3 = UIAlertAction(title: "Upload Document", style: .default) { (action) in
            //print("Destructive is pressed....")
            self.openDocumentViewController()
            
        }
        let action4 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            //print("Destructive is pressed....")
            
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        alertController.addAction(action4)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK - Photo Media
    func openPhotoMedia(mediaType: String)
    {
        if (mediaType == "TakePhoto")
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
                
            }
        }
        else
        {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        //    var paramTOAdd = ["claimType":"","claimTypeId":"","amount":"","documentType":"","documentName":"","documentData":""]
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imgData = UIImageJPEGRepresentation(selectedImage, 0.1)
        let imgDataInData: NSData  =  NSData(data: UIImageJPEGRepresentation(selectedImage, 0.1)!)
        paramTOAdd["documentData"] = imgData
        let fileSize:Double =  Double(imgDataInData.length) / 1024.0 //image size in kb
        var fileName : String!
        // Added code to get file name
        
        
        paramTOAdd["fileType"] = "image"
        
        if let imgFileName = info[UIImagePickerControllerReferenceURL]
        {
            let url = imgFileName as? URL ?? URL(string: "")!
            let ext = url.absoluteString.components(separatedBy: "ext=")[1]
            print(ext)
            
            
            fileName = String(describing: url.lastPathComponent)
            paramTOAdd["documentName"] = fileName
            paramTOAdd["documentSize"] = fileSize
            
            //uploadDocumentArray[3] = fileName
            uploadedFileName = fileName
            paramTOAdd["fileExtension"] = ext
            //"fileType":"","fileExtension":""
        }
        else{
            fileName =  "\(String(format: "%.0f", Date().timeIntervalSince1970 * 1000)).PNG"
            currentUpload += 1
            paramTOAdd["documentName"] = fileName
            paramTOAdd["documentSize"] = fileSize
            paramTOAdd["fileExtension"] = "jpg"
           // uploadDocumentArray[3] = fileName
             uploadedFileName = fileName
        }
        dismiss(animated: true, completion: nil)
        self.mainTableView.reloadData()
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK - Document Contoller
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
    }
    
    func openDocumentViewController()
    {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: UIDocumentPickerMode.import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    @available(iOS 8.0, *)
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let cico = url as URL
        //print("The Url is : \(cico)")
        
        do {
            let fileData = try NSData(contentsOf: cico, options: NSData.ReadingOptions())
            //print(fileData)
            
            let fileName = String(describing: url.lastPathComponent)
            
            let ext = String(describing: url.pathExtension)
            print(ext)
            
            let fileSize:Double =  Double(fileData.length) / 1024.0
            
            paramTOAdd["documentData"] = fileData
            paramTOAdd["documentName"] = fileName
            paramTOAdd["documentSize"] = fileSize
            paramTOAdd["fileType"] = "application"
            paramTOAdd["fileExtension"] = ext
            uploadedFileName = fileName
            
            self.mainTableView.reloadData()
            
        } catch {
            print(error)
        }
        
    }
    
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        print(" cancelled by user")
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    //MARK: TextField Delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       
        if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
            return false; //do not show keyboard nor cursor
        }else{
              return true
        }
      
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 4{
            
            self.view.endEditing(true)
            textField.resignFirstResponder()
            // selectMonthPopUpView()
            
        }
        else{
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
        if textField.tag == 1 // Systolic textField
        {
            systolicBPValue = textField.text ?? ""
            
            if !systolicBPValue.isEmpty{
                
                let systolicValue = Int(systolicBPValue)
                
                if systolicValue! > 300 || systolicValue! < 50{
                    systolicBPValue = ""
                    showAlert(title: "The values entered seem to be incorrect", message: "Systolic BP values should be in between 50-300 mmHg", vc: self)
                }
                else{
                    
                    if !diastolicBPValue.isEmpty{
                        
                        let diastolicValue = Int(diastolicBPValue) ?? 0
                        
                        if systolicValue == diastolicValue {
                            systolicBPValue = ""
                            diastolicBPValue = ""
                            showAlert(title: "The values entered seem to be incorrect", message: "Systolic BP & Diastolic BP values should not be same", vc: self)
                        }else if systolicValue! < diastolicValue {
                            diastolicBPValue = ""
                            showAlert(title: "The values entered seem to be incorrect", message: "Diastolic BP value should be less than Systolic BP value", vc: self)
                        }else {} // systolicValue and diastolicValue are not equal
                    }
                    else {} //end systolic is empty
                }
            }else {}
        }
        else if textField.tag == 2 // Diastolic textField
        {
            diastolicBPValue = textField.text ?? ""
            
            if !diastolicBPValue.isEmpty{
                
                let diastolicValue = Int(diastolicBPValue)
                
                if diastolicValue! > 150 || diastolicValue! < 30{
                    diastolicBPValue = ""
                    showAlert(title: "The values entered seem to be incorrect", message: "Diastolic BP should be in between 30-150 mmHg", vc: self)
                }
                else{
                    
                    if !systolicBPValue.isEmpty{
                        
                        let systolicValue = Int(systolicBPValue) ?? 0
                        
                        if systolicValue == diastolicValue {
                            systolicBPValue = ""
                            diastolicBPValue = ""
                            showAlert(title: "The values entered seem to be incorrect", message: "Systolic BP & Diastolic BP value should not be same", vc: self)
                        }else if systolicValue < diastolicValue! {
                            diastolicBPValue = ""
                            showAlert(title: "The values entered seem to be incorrect", message: "Diastolic BP value should be less than Systolic value", vc: self)
                        }else {} // systolicValue and diastolicValue are not equal
                    }
                    else {} //end systolic is empty
                } // end value is within range
            }else {} //dustolic empty is empty
        }
        else if textField.tag == 3 // Heart Rate textField
        {
            heartRateValue = textField.text ?? ""
            
            if !heartRateValue.isEmpty{
                
                let value = Int(heartRateValue)
                
                if value! > 200 || value! < 40{
                    heartRateValue = ""
                    showAlert(title: "The values entered seem to be incorrect", message: "Heart rate should be in between 40-200 Beats Per Minute", vc: self)
                }
                else{}
            }else {}
        }
        else if textField.tag == 4 // add reminder textField
        {
            reminderValue = textField.text ?? ""
        }
        else{
            
        }
        self.mainTableView.reloadData()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            //print("Backspace was pressed")
            return true
        }
        
        if textField.tag == 1 || textField.tag == 2 || textField.tag == 3
        {
            let  length:Int = textField.text!.count
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && length < 3
        }
        return true
    }
    
    
    
    //MARK: Navigation Buttons and Bottom Button
    
    @IBAction func backButtonClicked(_ sender: Any) {
   
        self.navigationController?.popViewController(animated: true)
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
    
    
    
    func showAlertWithAction(message:String)
    {
        let alert: UIAlertController = UIAlertController.init(title: "Success", message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (actionSheetController) -> Void in
            
            NotificationCenter.default.post(name: Notification.Name("reloadsLogRecords"), object: nil)
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if DBHandler.appDelegateShared().isConnectedToNetwork().rawValue == 0
        {
            showAlert(title: "No Internet Connection", message: "Make sure that Wi-Fi or mobile data is turned on, then try again.", vc: self)
            ProgressHUD.dismiss()

        }
        else{
            
            if systolicBPValue == ""{
                
                showAlert(title: "Alert", message: "Please enter the value for Systolic BP", vc: self)
            }
            else if diastolicBPValue == ""{
                showAlert(title: "Alert", message: "Please enter the value for Diastolic BP", vc: self)
            }
            else if heartRateValue == ""{
                showAlert(title: "Alert", message: "Please enter the value for Heart rate", vc: self)
            }
            else{
                //api call
                //risk level
                
                
                var docData:Data? = nil
                if let data = paramTOAdd["documentData"] as? NSData {
                    // data exists
                    docData = data as Data
                } else {
                    // data doesn't exist yet at this index
                    docData =  Data()
                }
                // let docData = paramTOAdd["documentData"] as? NSData ??
                let dataExtension = paramTOAdd["fileExtension"] as! String
                let fileDocumentType =  paramTOAdd["fileType"] as! String
                let mimeTypestr = fileDocumentType + "/" + dataExtension
                
                ProgressHUD.show("Uploading...")
                
                //  let csrfTokenValue = UserDefaults.standard.string(forKey: "csrftoken")
                var  csrfTokenValue = ""
                if (AppUtilities.getCSFRToken() != nil)
                {
                    csrfTokenValue = AppUtilities.getCSFRToken()
                }
                
                var riskLevelValue = ""
                if riskLevel1 == "Healthy" && riskLevel2 == "Healthy" && riskLevel3 == "Healthy" {
                    riskLevelValue = "Healthy"
                }else{
                    riskLevelValue = "Needs Attention"
                }
                
                var patientSlugValue = ""
                let lPatient = AppUtilities.getCurrentSelectedPatientInMyFamily()
                
                if lPatient!.patient_slug != nil {
                    patientSlugValue = lPatient!.patient_slug!
                } else {
                    patientSlugValue = ""
                }
                
                let parameters = [
                    "patient_slug" : patientSlugValue,
                    "systolic_bp": systolicBPValue,
                    "diastolic_bp": diastolicBPValue,
                    "heart_rate": heartRateValue,
                    "upload_type": "blood_pressure",
                    "risk_level": riskLevelValue,  //needs to change
                ]
                
                let headersParams: HTTPHeaders = [
                    "X-CSRFToken": csrfTokenValue,
                ]
                
                let urlPath  =   AppUtilities.getBaseURL() + kAddRecordsForBloodPressureForHealthLogs
                
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                    
                    for (key, value) in parameters {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                    // MultipartFormData.append(imgData!, withName: "file", fileName: self.attachmentFileName, mimeType: self.mimeType) // this wont work
                    multipartFormData.append(docData!, withName: "file", fileName: self.uploadedFileName , mimeType: mimeTypestr)
                    
                }, usingThreshold: UInt64.init(), to: urlPath, method: .post, headers: headersParams) { (result) in
                    
                    switch result {
                    case .success(let upload, _, _):
                        
                        upload.responseJSON { response in
                            
                            //   print(response.result)
                            print(response.result.value!)
                            
                            if let jsonDict = response.result.value as? NSDictionary {
                                
                                if let msg = jsonDict.object(forKey: "status_message") as? String {
                                    
                                    //showAlert(title: "Success", message: msg!, vc: self)
                                    self.showAlertWithAction(message: msg)
                                    
                                    DispatchQueue.main.async() {
                                        self.mainTableView.reloadData()
                                        ProgressHUD.dismiss()
                                    }
                                }
                                else{
                                    
                                    if let msgDetails = jsonDict.object(forKey: "detail") as? String{
                                        
                                        showAlert(title: "Error", message: msgDetails, vc: self)
                                    }else{
                                        
                                        showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                                    }
                                }
                                
                                showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                                ProgressHUD.dismiss()
                            }
                            else{
                                //json error
                                showAlert(title: "Oops!!!", message: "Something went wrong. Please try again later.", vc: self)
                                ProgressHUD.dismiss()
                            }
                        }
                        
                    case .failure(let encodingError):
                        // print(encodingError)
                        showAlert(title: "Error", message: encodingError as! String, vc: self)
                        ProgressHUD.dismiss()
                        break
                    }
                }
            }
        } //end if check network connection

    } //end func if saveButonClicked
    
}
