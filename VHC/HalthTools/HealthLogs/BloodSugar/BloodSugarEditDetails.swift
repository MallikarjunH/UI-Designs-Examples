//
//  BloodSugarEditDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Photos
import Alamofire

class BloodSugarEditDetails:UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIDocumentPickerDelegate,UIDocumentMenuDelegate {

    var uploadFileButtonClicked = false
    var uploadedFileName = ""
    var currentUpload : Int = 0
    
    var fastingValueForBs = ""
    var randomValueForBs = ""
    var postPrandialForBs = ""
    var reminderValue = ""
    
    var fastingPriority = ""
    var randomPriority = ""
    var postPrandialPriority = ""
    
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodSugarViewAndEditCell1Id", for: indexPath) as! BloodSugarViewAndEditCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                
                cell.firstCellImg.isHidden = true
                cell.firstCellsLabel.text = GlobalVariables.sharedManager.dateValue //"28 March 2019"
            }
            else{
                cell.firstCellImg.isHidden = false
                cell.firstCellsLabel.text = "Enter your health record"
            }
            
            return cell
        }
        else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodSugarViewAndEditCell2Id", for: indexPath) as! BloodSugarViewAndEditCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                
                cell.fastingTextField.text = GlobalVariables.sharedManager.logValue1
                cell.fastingPriorityBGView.isHidden = true
            }
            else{
                
                if fastingValueForBs.isEmpty{
                    cell.fastingPriorityBGView.isHidden = true
                    cell.fastingTextField.text = ""
                    validateTestArrayForButton[0] = "0"
                }else{
                    
                    validateTestArrayForButton[0] = "1"
                    cell.fastingTextField.text = fastingValueForBs
                    cell.fastingPriorityBGView.isHidden = false
                    let value = Int(fastingValueForBs)
                    
                    if value! > 100{
                        cell.fastingPriorityLabel.text = "High    "
                        cell.fastingPriorityLabel.textColor = UIColor.red //UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1)
                        cell.fastingPriorityColorView.backgroundColor = UIColor.red
                        riskLevel1 = "Needs Attention"
                    }
                    else if value! > 69 && value! < 101{
                        cell.fastingPriorityLabel.text = "Normal"
                        cell.fastingPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        cell.fastingPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        riskLevel1 = "Healthy"
                    }
                    else if value! < 70{
                        cell.fastingPriorityLabel.text = "Low     "
                        cell.fastingPriorityLabel.textColor = UIColor.red
                        cell.fastingPriorityColorView.backgroundColor = UIColor.red
                        riskLevel1 = "Needs Attention"
                    }
                }
            }
            
            return cell
        }
        else if indexPath.section == 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodSugarViewAndEditCell3Id", for: indexPath) as! BloodSugarViewAndEditCell3
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                
                cell.randomTextField.text =  GlobalVariables.sharedManager.logValue2
                cell.randomPriorityBGView.isHidden = true
            }
            else{
                
                if randomValueForBs.isEmpty{
                    cell.randomPriorityBGView.isHidden = true
                    cell.randomTextField.text = ""
                    validateTestArrayForButton[1] = "0"
                }else{
                    
                    validateTestArrayForButton[1] = "1"
                    
                    cell.randomTextField.text = randomValueForBs
                    cell.randomPriorityBGView.isHidden = false
                    let value = Int(randomValueForBs)
                    
                    if value! > 160{
                        cell.randomPriorityLabel.text = "High    "
                        cell.randomPriorityLabel.textColor = UIColor.red
                        cell.randomPriorityColorView.backgroundColor = UIColor.red
                        riskLevel2 = "Needs Attention"
                    }
                    else if value! > 69 && value! < 161{
                        cell.randomPriorityLabel.text = "Normal"
                        cell.randomPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        cell.randomPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        riskLevel2 = "Healthy"
                    }
                    else if value! < 70{
                        cell.randomPriorityLabel.text = "Low     "
                        cell.randomPriorityLabel.textColor = UIColor.red
                        cell.randomPriorityColorView.backgroundColor = UIColor.red
                        riskLevel2 = "Needs Attention"
                    }
                    
                }
                
            }
            
            return cell
        }
        else if indexPath.section == 3{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodSugarViewAndEditCell4Id", for: indexPath) as! BloodSugarViewAndEditCell4
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            if GlobalVariables.sharedManager.fromVCNameInHealthBlogs == "viewMode"{
                
                 cell.postPrandialTextField.text =  GlobalVariables.sharedManager.logValue3
                 cell.postPrandialPriorityBGView.isHidden = true
            }
            else{
                
                if postPrandialForBs.isEmpty{
                    cell.postPrandialPriorityBGView.isHidden = true
                    cell.postPrandialTextField.text = ""
                    validateTestArrayForButton[2] = "0"
                }else{
                    
                    validateTestArrayForButton[2] = "1"
                    
                    cell.postPrandialTextField.text = postPrandialForBs
                    cell.postPrandialPriorityBGView.isHidden = false
                    let value = Int(postPrandialForBs)
                    
                    if value! > 140{
                        cell.postPrandialPriorityLabel.text = "High    "
                        cell.postPrandialPriorityLabel.textColor = UIColor.red
                        cell.postPrandialPriorityColorView.backgroundColor =  UIColor.red
                        riskLevel3 = "Needs Attention"
                    }
                    else if  value! > 69 && value! < 141 {
                        cell.postPrandialPriorityLabel.text = "Normal"
                        cell.postPrandialPriorityLabel.textColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        cell.postPrandialPriorityColorView.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                        riskLevel3 = "Healthy"
                        
                    }
                    else if value! < 70{
                        cell.postPrandialPriorityLabel.text = "Low     "
                        cell.postPrandialPriorityLabel.textColor = UIColor.red
                        cell.postPrandialPriorityColorView.backgroundColor =   UIColor.red
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodSugarViewAndEditCell5Id", for: indexPath) as! BloodSugarViewAndEditCell5
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
        } // add reminder
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BloodSugarViewAndEditCell6Id", for: indexPath) as! BloodSugarViewAndEditCell6
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
        
        if textField.tag == 8{
            
            self.view.endEditing(true)
            textField.resignFirstResponder()
            // selectMonthPopUpView()
            
        }
        else{
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
        if textField.tag == 5 // fasting textField
        {
            fastingValueForBs = textField.text ?? ""
            
            if !fastingValueForBs.isEmpty{
        
                let value = Int(fastingValueForBs)

                if value! > 400 || value! < 30{
                    fastingValueForBs = ""
                    showAlert(title: "The values entered seem to be incorrect", message: "Fasting Blood Sugar values should be in between 30-400 mg/dL", vc: self)
                }
                else{}
            }else {}
        }
        else if textField.tag == 6 // random textField
        {
            randomValueForBs = textField.text ?? ""
            if !randomValueForBs.isEmpty{
                
                let value = Int(randomValueForBs)
                
                if value! > 400 || value! < 30{
                    
                    showAlert(title: "The values entered seem to be incorrect", message: "Random Blood Sugar values should be in between 30-400 mg/dL", vc: self)
                }
                else{}
            }else {}
        }
        else if textField.tag == 7 // post prandial textField
        {
            postPrandialForBs = textField.text ?? ""
            if !postPrandialForBs.isEmpty{
                
                let value = Int(postPrandialForBs)
                if value! > 400 || value! < 30{
                    
                    showAlert(title: "The values entered seem to be incorrect", message: "Post Prandial Blood Sugar values should be in between 30-400 mg/dL", vc: self)
                }
                else{}
            }else {}
        }
        else if textField.tag == 8 //  reminder textField
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
        
        if textField.tag == 5 || textField.tag == 6 || textField.tag == 7
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

    @IBAction func saveButtonClicked(_ sender: Any) {
   
        if DBHandler.appDelegateShared().isConnectedToNetwork().rawValue == 0
        {
            showAlert(title: "No Internet Connection", message: "Make sure that Wi-Fi or mobile data is turned on, then try again.", vc: self)
            ProgressHUD.dismiss()
        }else{
            
            if fastingValueForBs == ""{
                
                showAlert(title: "Alert", message: "Please enter the value for Fasting BS", vc: self)
            }
            else if randomValueForBs == ""{
                showAlert(title: "Alert", message: "Please enter the value for Random BS", vc: self)
            }
            else if postPrandialForBs == ""{
                showAlert(title: "Alert", message: "Please enter the value for Post Prandial", vc: self)
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
                    "fasting": fastingValueForBs,
                    "random": randomValueForBs,
                    "post_prandial": postPrandialForBs,
                    "upload_type": "blood_sugar",
                    "risk_level": riskLevelValue ,
                ]
                
                let headersParams: HTTPHeaders = [
                    "X-CSRFToken": csrfTokenValue,
                    "Content-Type": "application/json"
                ]
                
                let urlPath  =   AppUtilities.getBaseURL() + kAddRecordsForBloodSugarForHealthLogs
                
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
        } //end if of check interner conection
    } //end button clicked
    
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
    
    @IBAction func notificationButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let notificationVC = storyBoard.instantiateViewController(withIdentifier: "Notifications") as! Notifications
        if ((self.navigationController?.topViewController?.isKind(of: Notifications.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
    }
    
    func showAlertWithAction(message:String)
    {
        let alert: UIAlertController = UIAlertController.init(title: "Success", message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (actionSheetController) -> Void in
            
            NotificationCenter.default.post(name: Notification.Name("reloadsLogRecordsForBS"), object: nil)
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
