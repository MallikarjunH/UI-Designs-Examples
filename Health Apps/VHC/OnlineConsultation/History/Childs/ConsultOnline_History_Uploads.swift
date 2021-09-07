//
//  ConsultOnline_History_Uploads.swift
//  VidalHealth
//
//  Created by mallikarjun on 25/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//


import UIKit

class ConsultOnline_History_Uploads: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var usersUploadDocsArray:[[String:Any]] = []
    
    @IBOutlet weak var uploadPhotosLabel: UILabel!
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var mainTableView: UITableView!
    
    var uploadedFileName = ""
    
    var fileNameArray:[String] = []
    var fileUploadedDateArray:[String] = []
    var fileSizeArray:[String] = []
    var fileImageArray:[String] = []
    
    var paramTOAdd:[String:Any] = ["documentType":"","documentName":"","documentData":"","documentSize":"","fileType":"","fileExtension":""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTableView!.tableFooterView = UIView()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        uploadImage.isUserInteractionEnabled = true
        uploadImage.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadUsersUploadedDocs(notification:)), name: Notification.Name("usersUploadedDocuments"), object: nil)
    }
    

    //MARK: Notification call
    @objc func reloadUsersUploadedDocs(notification: Notification) {
        
        guard let usersDocsDictionary:[[String:Any]] = notification.userInfo!["userData"] as? [[String : Any]] else { return }
        
        print("Users Uploaded Doc Data: \(usersDocsDictionary)")
        self.usersUploadDocsArray = usersDocsDictionary
        
        if self.usersUploadDocsArray.count > 0 {
            
            self.fileNameArray =  []
            self.fileUploadedDateArray = []
            self.fileSizeArray = []
            self.fileImageArray = []
            
            for documentDataDict:Dictionary<String,Any> in usersUploadDocsArray{
                
                let imageThumbnail:String = documentDataDict["records_thumbnail"] as? String ?? ""
                let fileName:String = documentDataDict["file_name"] as? String ?? ""
                let createdAt:String = documentDataDict["created_at"] as? String ?? ""
                let fileSize:String = documentDataDict["file_size"] as? String ?? ""
                
                self.fileNameArray.append(fileName)
                self.fileUploadedDateArray.append(createdAt)
                self.fileSizeArray.append(fileSize)
                self.fileImageArray.append(imageThumbnail)
            }
        }
        
        DispatchQueue.main.async {
            
            if self.usersUploadDocsArray.count > 0 {
                self.uploadImage.isHidden = true
                self.uploadPhotosLabel.isHidden = true
                self.mainTableView.isHidden = false
            }
            else{
                self.uploadImage.isHidden = false
                self.uploadPhotosLabel.isHidden = false
                self.mainTableView.isHidden = true
            }
            self.mainTableView.reloadData()
        }
    }
    
    
    //MARK: Tableview datasource and delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if self.usersUploadDocsArray.count > 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            =  2 //1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return self.usersUploadDocsArray.count
        }
            
        else if section == 1 {
            
            return 1
        }
        else{
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UploadFilesInHistoryCell1Id", for: indexPath) as!  UploadFilesInHistoryCell1
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.fileNameLabel.text = self.fileNameArray[indexPath.row]
            cell.fileUploadedTimeLabel.text = self.fileUploadedDateArray[indexPath.row]
            cell.fileSizeLabel.text = "\(self.fileSizeArray[indexPath.row])"
            
            //cell.fileImage.image = UIImage(named: "icon_right_arrow")
            
            if self.fileImageArray[indexPath.row] != ""{
                AppUtilitiesSwift.getData(from: self.fileImageArray[indexPath.row] as String) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() {
                        cell.fileImage.image  = UIImage(data: data)
                    }
                }
            }
            else{
                
                cell.fileImage.image = UIImage(named: "icon_right_arrow")
            }
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UploadFilesInHistoryCell2Id", for: indexPath) as!  UploadFilesInHistoryCell2
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
          //  cell.addButton.addTarget(self, action: #selector(selectFileButton(sender:)), for: .touchUpInside)
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 96.0
        }
        else{
            return 50.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            //show details - full image
        }
        else if indexPath.section == 1 {
           
            print("Clicked on to add new files")
            self.uploadDocumentFunction()
        }
    }
    
    
    //MARK: Clicked on image - to upload files
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Clicked on Image Button to select/upload files")
        
        self.uploadDocumentFunction()
    }
    
    func uploadDocumentFunction(){
        
        let alertController = UIAlertController(title: "Upload Document", message: "Tap to upload Documents", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            self.openPhotoMedia(mediaType:"TakePhoto")
            //print("Default is pressed.....")
        }
        let action2 = UIAlertAction(title: "Upload Photo", style: .default) { (action) in
            
            // print("Cancel is pressed......")
            self.openPhotoMedia(mediaType:"UploadPhoto")
        }
        
        let action3 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            //print("Destructive is pressed....")
            
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        
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
            //currentUpload += 1
            paramTOAdd["documentName"] = fileName
            paramTOAdd["documentSize"] = fileSize
            paramTOAdd["fileExtension"] = "jpg"
            uploadedFileName = fileName
        }
        dismiss(animated: true, completion: nil)
       // self.mainTableView.reloadData()
        self.reloadInputViews()
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: Remove observer
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("usersUploadedDocuments"), object: nil)
    }

}
