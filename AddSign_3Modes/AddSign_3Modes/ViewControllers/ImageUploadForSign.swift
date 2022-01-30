//
//  ImageUploadForSign.swift
//  AddSign_3Modes
//
//  Created by EOO61 on 30/01/22.
//

import UIKit
import Photos
import MobileCoreServices

class ImageUploadForSign: UIViewController {

    @IBOutlet weak var uploadButtonOutlet: UIButton!
    @IBOutlet weak var resetButtonOutlet: UIButton!
    @IBOutlet weak var uploadedImg: UIImageView!
    
    @IBOutlet weak var termsAndConditionLabel: UILabel!
    @IBOutlet weak var checkBoxButtonOutlet: UIButton!
    var checkBoxSelected = false
    
    @IBOutlet weak var signButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        signButtonOutlet.isHidden = true
        termsAndConditionLabel.isHidden = true
        checkBoxButtonOutlet.isHidden = true
        checkBoxButtonOutlet.setTitle("", for: .normal)
        
        signButtonOutlet.clipsToBounds = true
        signButtonOutlet.layer.cornerRadius = 10
        signButtonOutlet.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        uploadButtonOutlet.clipsToBounds = true
        uploadButtonOutlet.layer.cornerRadius = 10
        uploadButtonOutlet.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        resetButtonOutlet.layer.borderWidth = 0.5
        resetButtonOutlet.layer.borderColor = UIColor.gray.cgColor
        resetButtonOutlet.clipsToBounds = true
        resetButtonOutlet.layer.cornerRadius = 10
        resetButtonOutlet.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }

    
    @IBAction func resetButtonAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.signButtonOutlet.isHidden = true
            self.termsAndConditionLabel.isHidden = true
            self.checkBoxButtonOutlet.isHidden = true
            self.uploadedImg.image = UIImage(named: "")
            self.checkBoxSelected = false
            self.checkBoxButtonOutlet.setImage(UIImage(named: "ic_unselect_Checkbox"), for: .normal)
        }
    }
    
    @IBAction func checkBoxButtonClicked(_ sender: Any) {
        DispatchQueue.main.async {
            if self.checkBoxSelected {
                self.checkBoxSelected = false
                self.checkBoxButtonOutlet.setImage(UIImage(named: "ic_unselect_Checkbox"), for: .normal)
            }else{
                self.checkBoxSelected = true
                self.checkBoxButtonOutlet.setImage(UIImage(named: "ic_check_box"), for: .normal)
            }
        }
    }
}

extension ImageUploadForSign: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBAction func uplaodButtonAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        myPickerController.allowsEditing = true
        self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
   
        if let editImage = info[.editedImage] as? UIImage{
            self.loadUploadedImage(img: editImage)
        }
        else if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.loadUploadedImage(img: pickedImage)
        }
        else if let image = info[.originalImage] as? UIImage {
            self.loadUploadedImage(img: image)
        }
        picker.dismiss(animated: true,completion: nil)
        
    }
    
    func loadUploadedImage(img:UIImage) {
        DispatchQueue.main.async {
            self.signButtonOutlet.isHidden = false
            self.termsAndConditionLabel.isHidden = false
            self.checkBoxButtonOutlet.isHidden = false
            self.uploadedImg.image = img
        }
    }
}


/*
let date = Date()
let df = DateFormatter()
df.dateFormat = "yyMMdd-Hs"
let dateString = df.string(from: date)
let documentName = "document\(dateString).pdf"
print("Created PDF Name is: \(documentName)")

let docURL = documentDirectory.appendingPathComponent(documentName)
createPDFS(arrImages: self.imagesArray)?.write(to: docURL, atomically: true)
let fileData = try! Data.init(contentsOf: docURL)

//13 dec code added - check image/pdf from gallary/camera is more than 5mb
var Size = Float()
Size = Float(Double(fileData.count)/1024)
let fileSize = Int(Size)
print("PDF Size New: \(fileSize)")
if fileSize > 5000 {
    self.showAlert("FAB eSign Message", message: "The supported file is maximum of 5 MB")
    return
}

let base64String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
//self.base64Data = base64String


//add notification
var docDic:[String:String] = [:]
docDic["docName"] = documentName
docDic["docBase64Data"] = base64String

NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getSelectedPDFDetails"), object: nil, userInfo: ["docDataDict" : docDic])
_ = navigationController?.popViewController(animated: true)
*/
