//
//  MonthDetailsVC.swift
//  Baby Bumb Tracker
//
//  Created by mallikarjun on 04/07/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class MonthDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var simpleImagePicker: UIImagePickerController? = nil
   
    @IBOutlet weak var mainTableView: UITableView!
  
    var selectedImage:UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthDetailsCell1Id", for: indexPath) as! MonthDetailsCell1
            
            cell.demoImageView.isHidden = true
            
            if selectedImage != nil{
                
                 cell.mainImageView.image = selectedImage
            }
           
            
            cell.addPhotoButton.addTarget(self, action: #selector(selectPhotos(sender:)), for: .touchUpInside)
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthDetailsCell2Id", for: indexPath) as! MonthDetailsCell2
            
            cell.descriptionLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
            return cell
            
        }
    }
    
     @objc func selectPhotos(sender:UIButton){
        
        
        let actionSheet = UIAlertController(title: "Choose to update Profile", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.dismiss(animated: true) {
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Upload Photo", style: .default, handler: { action in
            
            
            self.simpleImagePicker = UIImagePickerController()
            self.simpleImagePicker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.simpleImagePicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.simpleImagePicker?.allowsEditing = true

            self.present(self.simpleImagePicker!, animated: true, completion: nil)
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { action in
            
            
            self.simpleImagePicker = UIImagePickerController()
            self.simpleImagePicker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.simpleImagePicker!.sourceType = UIImagePickerController.SourceType.camera
            self.simpleImagePicker?.allowsEditing = true
            
            self.present(self.simpleImagePicker!, animated: true, completion: nil)
            
        }))
        
        present(actionSheet, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image = info[.editedImage] as? UIImage
        if image == nil {
            image = info[.originalImage] as? UIImage
        }
        //UIImageView *img = [self.view viewWithTag:125];
        //profileImage.image = image
        
        selectedImage = image
        self.mainTableView.reloadData()
        simpleImagePicker!.dismiss(animated: true)
    
    }

}
