//
//  NewMyAddaCreatePopUp.swift
//  ApartmentAdda
//
//  Created by arun on 28/02/18.
//  Copyright © 2018 3five8. All rights reserved.
//

import UIKit

class NewMyAddaCreatePopUp: UIView {
    //var bgView:UIView!
    
    @IBOutlet weak var crossBtn: UIButton!
    var frameForPlusBtn:CGRect!
    
    weak var parentVC:UIViewController!
   // var groupData:MyAddaGroups!
    var groupId = 0
    var groupName = ""
    @IBOutlet var createGroupLbl: UILabel!
    @IBOutlet var createGroupIcon: UIImageView!
    @IBOutlet var createGrpBtn: UIButton!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumLbl: UILabel!
    
    @IBOutlet weak var uploadImageConst: NSLayoutConstraint!
    
    
    func hideAlbum(){
        
        uploadImageConst.constant = 0
        albumImage.isHidden = true
          albumLbl.isHidden = true
    }
    @IBAction func didTapOnCreateConversation(_ sender: Any) {
       print("Clicked on Create Conversation")
       /* let vc = parentVC.storyboard?.instantiateViewController(withIdentifier: "MyAddaCreateConvoViewController") as! MyAddaCreateConvoViewController
        vc.pNav = parentVC?.navigationController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        if groupId != 0 {
            vc.textForVisibleTo = "Visible to: \(groupName)"
            vc.groupIdSelected = "\(groupId)"
        }
        parentVC.present(nav, animated: true) */
        
        didTabOnCrossBtn(UIButton())
    }
    
    @IBAction func didTapOnUploadPhotos(_ sender: Any) {
        
        print("Clicked on Upload Photo")
       // let vc = parentVC.storyboard?.instantiateViewController(withIdentifier: "MyAddaAddPhotoGalleryViewController") as! MyAddaAddPhotoGalleryViewController
       // vc.parentVC = self.parentVC
       // parentVC.present(vc, animated: true)
        
        didTabOnCrossBtn(UIButton())
        
    }
    
    @IBAction func didTapOnCreatePoll(_ sender: Any) {
        print("Clicked on Create Poll")
       didTabOnCrossBtn(UIButton())
    
    }
    
    @IBAction func didTapOnCreateGrp(_ sender: Any) {
        print("Clicked on Create Group")
        didTabOnCrossBtn(UIButton())
    }
    
   @objc func didTabOnCross(_ sender: UITapGestureRecognizer) {
    let tmpCrossBtn  = UIImageView(image: crossBtn.currentImage)
   
    if frameForPlusBtn != nil {
        tmpCrossBtn.frame =  frameForPlusBtn
        self.superview?.superview?.addSubview(tmpCrossBtn)
         self.superview?.superview?.bringSubviewToFront(tmpCrossBtn)
    }

    var newCenter = self.frame
        newCenter.origin = CGPoint(x: 12, y: UIScreen.main.bounds.height)
        
    UIView.animate(withDuration: 0.3, delay: 0.0,usingSpringWithDamping: 1,
                   initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
             if self.frameForPlusBtn != nil {
            tmpCrossBtn.transform = tmpCrossBtn.transform.rotated(by: CGFloat(-Double.pi/4))
            }
            self.frame = newCenter
             self.superview?.backgroundColor = .clear
        }, completion: { finished in
            
            if self.frameForPlusBtn != nil {
            tmpCrossBtn.removeFromSuperview()
                self.frameForPlusBtn = nil
            }
             self.superview?.removeFromSuperview()
            //self.removeFromSuperview()
           
        })
    }

    
    @IBAction func didTabOnCrossBtn(_ sender: Any) {
        let tmpCrossBtn  = UIImageView(image: crossBtn.currentImage)
       
        if frameForPlusBtn != nil {
            tmpCrossBtn.frame =  frameForPlusBtn
            self.superview?.superview?.addSubview(tmpCrossBtn)
            self.superview?.superview?.bringSubviewToFront(tmpCrossBtn)
        }
        
        var newCenter = self.frame
        newCenter.origin = CGPoint(x: 12, y: UIScreen.main.bounds.height)

        UIView.animate(withDuration: 0.3, delay: 0.0,usingSpringWithDamping: 1,
                       initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
             if self.frameForPlusBtn != nil {
            tmpCrossBtn.transform = tmpCrossBtn.transform.rotated(by: CGFloat(-Double.pi/4))
            }
            self.frame = newCenter
            self.superview?.backgroundColor = .clear
        }, completion: { finished in
            if self.frameForPlusBtn != nil {
                tmpCrossBtn.removeFromSuperview()
                self.frameForPlusBtn = nil
            }
            
            self.superview?.removeFromSuperview()
           
            //self.removeFromSuperview()
            
        })
        
       
    }
    
}
