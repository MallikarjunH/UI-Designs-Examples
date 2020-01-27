//
//  ResonForConsultation.swift
//  VidalHealth
//
//  Created by mallikarjun on 23/12/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

@objcMembers class ResonForConsultation: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var continueButtonOutlet: UIButton!
    
    @objc var patient_slugForOC:String =  ""
    
    @objc var doctorNameForOC:String =  ""
    @objc var doctorImgForOC:String =  ""
    @objc var doctorSpecilityForOC:String =  ""
    @objc var doctorEducationForOC:String =  ""
    
    var alloButtonToClick:Bool =  false
    
    @objc var consultationSlugForOC:String = ""
    @objc var consultationTypeForOC:String = "" //audioConsult, videoConsult, textConsult
    @objc var consultationModeForOC:String = "" // talkNow // need to add -  schedule , text (after
    
    let greyColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.TEXT_GREY_COLOR)
    let greenColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.BUTTON_GREEN_COLOR)
    
    var testEmptyString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        continueButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREY_COLOR)
        
        reasonTextView.layer.borderColor = greyColor.cgColor
        reasonTextView.layer.borderWidth = 1.0
        reasonTextView.layer.cornerRadius = 0
        
        GlobalVariables.sharedManager.reasonForConsultationOnline = testEmptyString
        AppUtilities.saveConsultationReason(testEmptyString)
        
        // print("Consultation Slug: \(consultationSlugForOC)")
        // print("Consultation Mode: \(consultationModeForOC)")
        // print("Consultation Type: \(consultationTypeForOC)")
        
        //if from textconsult
        //Consultation Slug: emempty ("") | Consultation Mode: schedule | Consultation Type: textConsult
        
        //if from talk now
        //consultationSlugForOC = empty ("") | consultationModeForOC = talkNow | consultationTypeForOC =  videoConsult
        
        //if from shedule
        //Consultation Slug: FkQIO5s0sHREYbLdCKdWVeDl | Consultation Mode: schedule | Consultation Type: audioConsult
    }
    
    /* Updated for Swift 4 */
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            self.updatesUI()
            textView.resignFirstResponder()
            return false
        }
        
        if textView == reasonTextView {
            
            if (text == " ") {
                if textView.text.count == 0 {
                    return false
                }
            }
            
            if (textView.text as NSString).replacingCharacters(in: range, with: text).count < textView.text.count {
                
                return true
            }
            
            if (textView.text as NSString).replacingCharacters(in: range, with: text).count > 500 {
                return false
            }
            
            let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 .*$%(),;:-[]=+")
            
            
            if Int((text as NSString).rangeOfCharacter(from: set).location) == NSNotFound {
                return false
            }
        }
        
        return true
    }
    
    /* Older versions of Swift */
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            self.updatesUI()
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func updatesUI(){
        view.endEditing(true)
        if reasonTextView.text == "" {
            alloButtonToClick = false
            continueButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREY_COLOR)
            
        }else{
            alloButtonToClick = true
            continueButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.BUTTON_GREEN_COLOR)
        }
    }
    
    //MARK: Navigation Button
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        
        if alloButtonToClick{
            //  print("Clicked")
            GlobalVariables.sharedManager.reasonForConsultationOnline = reasonTextView.text
            AppUtilities.saveConsultationReason(reasonTextView.text)
            
            if ( consultationModeForOC == "schedule" && (consultationTypeForOC == "audioConsult" || consultationTypeForOC == "videoConsult") ){
                
                let lPatientQuestionParams = [
                    "consultation_slug": consultationSlugForOC,
                    "patient_question": reasonTextView.text //AppUtilities.getConsultationReason()
                    ] as [String : Any]
                ProgressHUD.show("Submitting Health Info")
                
                APIRequesterHelper.updatePatientQuestion(lPatientQuestionParams as [AnyHashable : Any], withCompletion: { result, actualResult, error in
                    
                    ProgressHUD.dismiss()
                    self.title = ""
                    
                    /*  let lConsultationDetail = self.storyboard.instantiateViewController(withIdentifier: "ConsultationDetail") as? ConsultationDetail
                     if (self.navigationController?.topViewController is ConsultationDetail) {
                     return
                     } else {
                     lConsultationDetail?.aConsultationDetailSlug = self.aConsultation_slug
                     if let lConsultationDetail = lConsultationDetail {
                     self.navigationController?.pushViewController(lConsultationDetail, animated: true)
                     }
                     } */
                })
                
            }
            else {
                
            }
            //naviagte to upload svcreen //patient_slugForOC
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let uploadSceenVC = storyBoard.instantiateViewController(withIdentifier: "UploadsScreen") as? UploadsScreen
            
            uploadSceenVC?.consultationReasonForOC = reasonTextView.text
            uploadSceenVC?.fromVCForOC = "OC"
            uploadSceenVC?.consultationTypeForOC = consultationTypeForOC
            uploadSceenVC?.consultationModeForOC = consultationModeForOC
            
            uploadSceenVC?.doctorNameForOC = doctorNameForOC;
            uploadSceenVC?.doctorImgForOC =  doctorImgForOC;
            uploadSceenVC?.doctorSpecilityForOC = doctorSpecilityForOC
            uploadSceenVC?.doctorEducationForOC = doctorEducationForOC
            uploadSceenVC?.aConsultation_slug = consultationSlugForOC
            uploadSceenVC?.patient_slugForOC = patient_slugForOC
            
            // navigationController?.setNavigationBarHidden(false, animated: true)
            
            if (navigationController?.topViewController is UploadsScreen) {
                return
            } else {
                navigationController?.pushViewController(uploadSceenVC!, animated: true)
            }
            
        }else{
            //button not selected
        }
    }
    
}
