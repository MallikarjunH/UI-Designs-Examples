//
//  LipidProfileEditDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 22/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Photos
import Alamofire

class LipidProfileEditDetails: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIDocumentPickerDelegate,UIDocumentMenuDelegate {

    var uploadFileButtonClicked = false
    var uploadedFileName = ""
    var currentUpload : Int = 0
    
    var totalCholesterolValueForThyroid = ""
    var hdlValueForThyroid = ""
    var ldlValueThyroid = ""
    var reminderValue = ""
    
    var riskLevel1 = ""
    var riskLevel2 = ""
    var riskLevel3 = ""
    
     var validateTestArrayForButton = [String]()
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LipidProfileViewAndEditCell1Id", for: indexPath) as! LipidProfileViewAndEditCell1
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LipidProfileViewAndEditCell2Id", for: indexPath) as! LipidProfileViewAndEditCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                
                cell.totalCholesterolTextField.text = GlobalVariables.sharedManager.logValue1
                cell.totalCholesterolPriorityBGView.isHidden = true
            }
            else{
                
                if totalCholesterolValueForThyroid.isEmpty{
                    cell.totalCholesterolPriorityBGView.isHidden = true
                    cell.totalCholesterolTextField.text = ""
                    validateTestArrayForButton[0] = "0"
                }else{
                    
                    validateTestArrayForButton[0] = "1"
                    
                    cell.totalCholesterolTextField.text = totalCholesterolValueForThyroid
                    cell.totalCholesterolPriorityBGView.isHidden = false
                    let value = Int(totalCholesterolValueForThyroid)
                    
                    if value! > 280{
                        cell.totalCholesterolPriorityLabel.text = "Very High"
                        cell.totalCholesterolPriorityLabel.textColor = UIColor.red
                        cell.totalCholesterolPriorityColorView.backgroundColor =   UIColor.red
                        riskLevel1 = "Needs Attention"
                    }
                    else if value! > 240 && value! < 281{
                        cell.totalCholesterolPriorityLabel.text = "High    "
                        cell.totalCholesterolPriorityLabel.textColor = UIColor.red
                        cell.totalCholesterolPriorityColorView.backgroundColor =   UIColor.red
                        riskLevel1 = "Needs Attention"
                    }
                    else {
                        
                        cell.totalCholesterolPriorityLabel.text = "Normal   "
                        cell.totalCholesterolPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        cell.totalCholesterolPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        riskLevel1 = "Healthy"
                    }
                  /*  else if value! < 201{
                        cell.totalCholesterolPriorityLabel.text = "Normal   "
                        cell.totalCholesterolPriorityLabel.textColor = UIColor.green
                        cell.totalCholesterolPriorityColorView.backgroundColor = UIColor.green
                        riskLevel1 = "Healthy"
                    } */
                }
            }
            
            return cell
        }
        else if indexPath.section == 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LipidProfileViewAndEditCell3Id", for: indexPath) as! LipidProfileViewAndEditCell3
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                
                cell.hdlTextField.text = GlobalVariables.sharedManager.logValue2
                cell.hdlPriorityBGView.isHidden = true
            }
            else{
                
                if hdlValueForThyroid.isEmpty{
                    cell.hdlPriorityBGView.isHidden = true
                    cell.hdlTextField.text = ""
                    validateTestArrayForButton[1] = "0"
                }else{
                    validateTestArrayForButton[1] = "1"
                    
                    cell.hdlTextField.text = hdlValueForThyroid
                    cell.hdlPriorityBGView.isHidden = false
                    let value = Int(hdlValueForThyroid)
                    
                    if value! < 40 {
                        cell.hdlPriorityLabel.text = "Low   "
                        cell.hdlPriorityLabel.textColor = UIColor.red
                        cell.hdlPriorityColorView.backgroundColor =  UIColor.red
                        riskLevel2 = "Needs Attention"
                    }
                    else if value! > 39{
                        cell.hdlPriorityLabel.text = "Normal      "
                        cell.hdlPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        cell.hdlPriorityColorView.backgroundColor =  UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        riskLevel2 = "Healthy"
                    }
                    else{
                        
                    }
                }
            }
            
            return cell
        }
        else if indexPath.section == 3{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LipidProfileViewAndEditCell4Id", for: indexPath) as! LipidProfileViewAndEditCell4
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                
                 cell.ldlTextField.text = GlobalVariables.sharedManager.logValue3
                 cell.ldlPriorityBGView.isHidden = true
            }
            else{
                
                if ldlValueThyroid.isEmpty{
                    cell.ldlPriorityBGView.isHidden = true
                    cell.ldlTextField.text = ""
                    validateTestArrayForButton[2] = "0"
                }else{
                    
                    validateTestArrayForButton[2] = "1"
                    
                    cell.ldlTextField.text = ldlValueThyroid
                    cell.ldlPriorityBGView.isHidden = false
                    let value = Int(ldlValueThyroid)
                    
                    if value! > 190{
                        cell.ldlPriorityLabel.text = "Very High"
                        cell.ldlPriorityLabel.textColor = UIColor.red
                        cell.ldlPriorityColorView.backgroundColor =  UIColor.red
                        riskLevel3 = "Needs Attention"
                    }
                    else if value! > 130 && value! < 191{
                        cell.ldlPriorityLabel.text = "High     "
                        cell.ldlPriorityLabel.textColor = UIColor.red
                        cell.ldlPriorityColorView.backgroundColor =  UIColor.red
                        riskLevel3 = "Needs Attention"
                    }
                    else if value! < 131{
                        cell.ldlPriorityLabel.text = "Normal   "
                        cell.ldlPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        cell.ldlPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        riskLevel3 = "Healthy"
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LipidProfileViewAndEditCell5Id", for: indexPath) as! LipidProfileViewAndEditCell5
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
        else{ //// add reminder
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LipidProfileViewAndEditCell6Id", for: indexPath) as! LipidProfileViewAndEditCell6
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            
            return 80.0
        }
        if indexPath.section == 1{
            
            return 70.0
        }
        if indexPath.section == 2{
            
            return 70.0
        }
        if indexPath.section == 3{
            
            return 70.0
        }
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
        
        if textField.tag == 16{
            
            self.view.endEditing(true)
            textField.resignFirstResponder()
            // selectMonthPopUpView()
            
        }
        else{
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
        if textField.tag == 13 // total Cholesterol textField
        {
            totalCholesterolValueForThyroid = textField.text ?? ""
            
            if !totalCholesterolValueForThyroid.isEmpty{
                
                let value = Int(totalCholesterolValueForThyroid)
                
                if value! > 400 || value! < 40{
                    totalCholesterolValueForThyroid = ""
                    showAlert(title: "The values entered seem to be incorrect", message: "Total Cholesterol values should be in between 40-400 mg/dL", vc: self)
                }
                else{}
            }else {}
        }
        else if textField.tag == 14 // hdl textField
        {
            hdlValueForThyroid = textField.text ?? ""
            
            if !hdlValueForThyroid.isEmpty{
                
                let value = Int(hdlValueForThyroid)
                
                if value! > 300 || value! < 10{
                    hdlValueForThyroid = ""
                    showAlert(title: "The values entered seem to be incorrect", message: "HDL values should be in between 10-300 mg/dL", vc: self)
                }
                else{}
            }else {}
        }
        else if textField.tag == 15 // ldl textField
        {
            ldlValueThyroid = textField.text ?? ""
            
            if !ldlValueThyroid.isEmpty{
                
                let value = Int(ldlValueThyroid)
                
                if value! > 400 || value! < 30{
                    ldlValueThyroid = ""
                    showAlert(title: "The values entered seem to be incorrect", message: "LDL values should be in between 30-400 mg/dL", vc: self)
                }
                else{}
            }else {}
        }
        else if textField.tag == 16 //  reminder textField
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
        
        if textField.tag == 13 || textField.tag == 14 || textField.tag == 15
        {
            let  length:Int = textField.text!.count
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && length < 3
        }
        return true
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
    
    func openDocumentViewController()
    {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: UIDocumentPickerMode.import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
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

    //MARK: Navigation and Bottom Buttons
    
    @IBAction func backButtonClicked(_ sender: Any) {
  
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func searchButtonClicked(_ sender: Any) {
       
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let searchVC: SearchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        if ((self.navigationController?.topViewController?.isKind(of: SearchViewController.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
  
        if DBHandler.appDelegateShared().isConnectedToNetwork().rawValue == 0
        {
            showAlert(title: "No Internet Connection", message: "Make sure that Wi-Fi or mobile data is turned on, then try again.", vc: self)
            ProgressHUD.dismiss()
        }
        else{
            
            if totalCholesterolValueForThyroid == ""{
                
                showAlert(title: "Alert", message: "Please enter Total Cholesterol test reading", vc: self)
            }
            else if hdlValueForThyroid == ""{
                showAlert(title: "Alert", message: "Please enter HDL test reading", vc: self)
            }
            else if ldlValueThyroid == ""{
                showAlert(title: "Alert", message: "Please enter LDL test reading", vc: self)
            }
            else{
                //api call
                
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
                
                // let csrfTokenValue = UserDefaults.standard.string(forKey: "csrftoken")
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
                    "total_cholesterol": totalCholesterolValueForThyroid,
                    "hdl": hdlValueForThyroid,
                    "ldl": ldlValueThyroid,
                    "upload_type": "lipid_profile",
                    "risk_level": riskLevelValue,
                ]
                
                let headersParams: HTTPHeaders = [
                    "X-CSRFToken": csrfTokenValue,
                    "Content-Type": "application/json"
                ]
                
                let urlPath  =   AppUtilities.getBaseURL() + kAddRecordsForLipidProfileForHealthLogs
                
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
                                        
                                        showAlert(title: "Error", message: "Something went wrong. Please try again later.", vc: self)
                                    }
                                }
                                
                                showAlert(title: "Error", message: "Something went wrong. Please try again later.", vc: self)
                                ProgressHUD.dismiss()
                            }
                            else{
                                //json error
                                showAlert(title: "Error", message: "Something went wrong. Please try again later.", vc: self)
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
            
        } //end check internet connection

    } //end saveButtonClicked
    
    func showAlertWithAction(message:String)
    {
        let alert: UIAlertController = UIAlertController.init(title: "Success", message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (actionSheetController) -> Void in
            
            NotificationCenter.default.post(name: Notification.Name("reloadsLogRecordsForLP"), object: nil)
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
