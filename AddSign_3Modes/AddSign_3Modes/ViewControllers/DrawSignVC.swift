//
//  DrawSignVC.swift
//  AddSign_3Modes
//
//  Created by EOO61 on 30/01/22.
//

import UIKit

class DrawSignVC: UIViewController,YPSignatureDelegate {

    @IBOutlet weak var signatureView: YPDrawSignatureView!
    
    @IBOutlet weak var signButtonOutlet: UIButton!
    @IBOutlet weak var termsAndConditionLabel: UILabel!
    @IBOutlet weak var checkBoxButtonOutlet: UIButton!
    var checkBoxSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signButtonOutlet.isHidden = true
        termsAndConditionLabel.isHidden = true
        checkBoxButtonOutlet.isHidden = true
        checkBoxButtonOutlet.setTitle("", for: .normal)
        
        signButtonOutlet.clipsToBounds = true
        signButtonOutlet.layer.cornerRadius = 10
        signButtonOutlet.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        // Do any additional setup after loading the view.
        signatureView.delegate = self
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
    
    @IBAction func clearSign(_ sender: Any) {
        signButtonOutlet.isHidden = true
        termsAndConditionLabel.isHidden = true
        checkBoxButtonOutlet.isHidden = true
        
        self.signatureView.clear()
    }
    
    @IBAction func saveSign(_ sender: Any) {
        // Getting the Signature Image from self.drawSignatureView using the method getSignature().
        if let signatureImage = self.signatureView.getSignature(scale: 10) {
            
            // Saving signatureImage from the line above to the Photo Roll.
            // The first time you do this, the app asks for access to your pictures.
            UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil) //****enable later
            
            // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.
            self.signatureView.clear() //****enable later
        }
    }
    
    
    // MARK: - Delegate Methods
    func didStart(_ view : YPDrawSignatureView) {
        print("Started Drawing")
    }
    func didFinish(_ view : YPDrawSignatureView) {
        print("Finished Drawing")
        
        signButtonOutlet.isHidden = false
        termsAndConditionLabel.isHidden = false
        checkBoxButtonOutlet.isHidden = false
    }
}


