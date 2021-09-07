//
//  PhotoPickerPopUpVC.swift
//  VidalHealth
//
//  Created by mallikarjun on 04/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

protocol selectedPhotoOptionPopUpVCDelegate: class {
    func selectPhotoPopUpSelected(_ selectedOption: String)
}

class PhotoPickerPopUpVC: UIViewController {

    
    weak var suggistionPopUpDelegate: selectedPhotoOptionPopUpVCDelegate?
    
    @IBOutlet weak var cameraImage: UIImageView!
    
    @IBOutlet weak var galleryImage: UIImageView!
    
    @IBOutlet weak var uploadImageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uploadImageLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(cameraTouched(tapGestureRecognizer:)))
        cameraImage.isUserInteractionEnabled = true
        cameraImage.addGestureRecognizer(tapGestureRecognizer1)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(galleryTouched(tapGestureRecognizer:)))
        galleryImage.isUserInteractionEnabled = true
        galleryImage.addGestureRecognizer(tapGestureRecognizer2)
    }
    
    //MARK: Actions for Option: Camera and Gallery
    @objc func cameraTouched(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("Clicked on Camera")
         self.suggistionPopUpDelegate?.selectPhotoPopUpSelected("camera")
      //  let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
    }

    @objc func galleryTouched(tapGestureRecognizer: UITapGestureRecognizer)
    {
         print("Clicked on Gallary")
         self.suggistionPopUpDelegate?.selectPhotoPopUpSelected("gallery")
        //  let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
    }


}
