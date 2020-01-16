//
//  SymptomCheckerSymptomQuestions.swift
//  VidalHealth
//
//  Created by mallikarjun on 25/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class SymptomCheckerSymptomQuestions: UIViewController,UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate,SelectItemPopUpDelegate {

    var firstCellSelectedValue = ""
    var secondCellSelectedValue = ""
    var thirdCellSelectedValue = ""
    
    var patientAge = ""
    var patientGender = ""
    var editingTextField:Int = 0
    
    var popUp: STPopupController? = nil
    
    let onImg = UIImage(named: "Radiobutton_On") as UIImage?
    let offImage = UIImage(named: "Radiobutton_Off") as UIImage?
    
    @IBOutlet weak var mainTableView: UITableView!
    
     //MARK: ViewControllers methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name("UIKeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name("UIKeyboardWillHideNotification"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //   NotificationCenter.default.removeObserver(self, name: Notification.Name("GetUserDataDictionary"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("UIKeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("UIKeyboardWillHideNotification"), object: nil)
    }
    
    //MARK: TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell: SymptomCheckerPossibleQuestionsCell1 = tableView.dequeueReusableCell(withIdentifier: "SymptomCheckerPossibleQuestionsCell1Id", for: indexPath) as! SymptomCheckerPossibleQuestionsCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            cell.firstYesButton.addTarget(self, action: #selector(firstYesButtonClicked(sender:)), for: .touchUpInside)
            cell.firstNoButton.addTarget(self, action: #selector(firstNoButtonClicked(sender:)), for: .touchUpInside)
     
            if firstCellSelectedValue == "y"{
                
                cell.firstYesButton.setImage(onImg, for: UIControlState.normal)
                cell.firstNoButton.setImage(offImage, for: UIControlState.normal)
            }else  if firstCellSelectedValue == "n" {
                
                cell.firstNoButton.setImage(onImg, for: UIControlState.normal)
                cell.firstYesButton.setImage(offImage, for: UIControlState.normal)
            }
            else{
                cell.firstYesButton.setImage(offImage, for: UIControlState.normal)
                cell.firstNoButton.setImage(offImage, for: UIControlState.normal)
            }
            return cell
        }
        else if indexPath.section == 1{
            
            let cell: SymptomCheckerPossibleQuestionsCell2 = tableView.dequeueReusableCell(withIdentifier: "SymptomCheckerPossibleQuestionsCell2Id", for: indexPath) as! SymptomCheckerPossibleQuestionsCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            cell.secondYesButton.addTarget(self, action: #selector(secondYesButtonClicked(sender:)), for: .touchUpInside)
            cell.secondNoButton.addTarget(self, action: #selector(secondNoButtonClicked(sender:)), for: .touchUpInside)
            
            if secondCellSelectedValue == "y"{
                
                cell.secondYesButton.setImage(onImg, for: UIControlState.normal)
                cell.secondNoButton.setImage(offImage, for: UIControlState.normal)
            }else  if secondCellSelectedValue == "n" {
                
                cell.secondNoButton.setImage(onImg, for: UIControlState.normal)
                cell.secondYesButton.setImage(offImage, for: UIControlState.normal)
            }
            else{
                cell.secondYesButton.setImage(offImage, for: UIControlState.normal)
                cell.secondNoButton.setImage(offImage, for: UIControlState.normal)
            }
            
            return cell
        }else if indexPath.section == 2{
            
            let cell: SymptomCheckerPossibleQuestionsCell3 = tableView.dequeueReusableCell(withIdentifier: "SymptomCheckerPossibleQuestionsCell3Id", for: indexPath) as! SymptomCheckerPossibleQuestionsCell3
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            cell.thirdYesButton.addTarget(self, action: #selector(thirdYesButtonClicked(sender:)), for: .touchUpInside)
            cell.thirdNoButton.addTarget(self, action: #selector(thirdNoButtonClicked(sender:)), for: .touchUpInside)
            
            if thirdCellSelectedValue == "y"{
                
                cell.thirdYesButton.setImage(onImg, for: UIControlState.normal)
                cell.thirdNoButton.setImage(offImage, for: UIControlState.normal)
            }else  if thirdCellSelectedValue == "n" {
                
                cell.thirdNoButton.setImage(onImg, for: UIControlState.normal)
                cell.thirdYesButton.setImage(offImage, for: UIControlState.normal)
            }
            else{
                cell.thirdYesButton.setImage(offImage, for: UIControlState.normal)
                cell.thirdNoButton.setImage(offImage, for: UIControlState.normal)
            }
            
            return cell
        }
        else{
            let cell: SymptomCheckerPossibleQuestionsCell4 = tableView.dequeueReusableCell(withIdentifier: "SymptomCheckerPossibleQuestionsCell4Id", for: indexPath) as! SymptomCheckerPossibleQuestionsCell4
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            cell.selectGenderButton.addTarget(self, action: #selector(showGender), for: UIControlEvents.touchUpInside)
            
            if (patientGender == "f") {
                cell.genderTextField.text = "Female"
            } else if (patientGender == "m") {
                cell.genderTextField.text = "Male"
            } else if (patientGender == "o") {
                cell.genderTextField.text = "Other"
            }
            else{
                cell.genderTextField.text = ""
            }
            
            if patientAge != "" {
                
                cell.ageTextField.text = patientAge
            }else{
                cell.ageTextField.text = ""
            }
            
            return cell
        }
    }
       
    //MARK: Radio Button Selection
    @objc func firstYesButtonClicked(sender:UIButton){
       
        firstCellSelectedValue = "y"
        self.mainTableView.reloadData()
    }
    @objc func firstNoButtonClicked(sender:UIButton){
        firstCellSelectedValue = "n"
        self.mainTableView.reloadData()
    }
    @objc func secondYesButtonClicked(sender:UIButton){
        secondCellSelectedValue = "y"
        self.mainTableView.reloadData()
    }
    
    @objc func secondNoButtonClicked(sender:UIButton){
        secondCellSelectedValue = "n"
        self.mainTableView.reloadData()
    }
    @objc func thirdYesButtonClicked(sender:UIButton){
        thirdCellSelectedValue = "y"
        self.mainTableView.reloadData()
    }
    
    @objc func thirdNoButtonClicked(sender:UIButton){
        thirdCellSelectedValue = "n"
        self.mainTableView.reloadData()
    }
    
    //MARK: Gender Pop-up
    
    @objc func showGender(){
        
        openPopUp(type: "gender")
    }
    
    func openPopUp(type:String){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp))
        let lSelectItemFromListPopUp = storyBoard.instantiateViewController(withIdentifier: "SelectItemFromListPopUp") as? SelectItemFromListPopUp
        //  lSelectItemFromListPopUp?.delegate = (self as! SelectItemPopUpDelegate)
        if(type == "gender")
        {
             lSelectItemFromListPopUp?.popUpType = type
        }
       
        lSelectItemFromListPopUp?.delegate = self as? SelectItemPopUpDelegate
        
        popUp = STPopupController(rootViewController: lSelectItemFromListPopUp!)
        popUp?.containerView.layer.cornerRadius = 4
        popUp?.backgroundView?.addGestureRecognizer(gestureRecognizer)
        popUp?.navigationBarHidden = true
        popUp?.transitionStyle = STPopupTransitionStyle.fade
        DispatchQueue.main.async(execute: {
            self.popUp?.present(in: self)
        })
        
    }
    
    @objc func dismissPopUp() {
        popUp?.dismiss()
    }
    
    func selectedItem(fromPopUp item: String?, popUpType type: String?) {
        
        if (type == "gender") {
            
            (view.viewWithTag(121) as? UILabel)?.text = item
            
            if (item == "Male") {
                patientGender = "m"
            } else if (item == "Female") {
                patientGender = "f"
            } else {
                patientGender = "o"
            }
            
            mainTableView.reloadData()
        }
        dismissPopUp()
    }

    //MARK: SHow and Hide Keyboard Methods
    @objc func keyboardWillShow(_ notification: Notification?) {
        if editingTextField == 11 {
            
            let keyboardSize = (notification?.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
            
            let newVerticalPosition = Float(-(keyboardSize.height ))
            
            moveFrame(toVerticalPosition: newVerticalPosition, forDuration: 0.3)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification?) {
        if editingTextField == 11 {
            moveFrame(toVerticalPosition: 0.0, forDuration: 0.3)
        }
    }
    
    func moveFrame(toVerticalPosition position: Float, forDuration duration: Float) {
        var frame: CGRect = view.frame
        frame.origin.y = CGFloat(position)
        
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.view.frame = frame
        })
    }
    
    //MARK: TextField Delegates Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        editingTextField = textField.tag
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
     func textFieldDidEndEditing(_ textField: UITextField){
        
        if textField.tag == 11 //age
        {
            patientAge = textField.text ?? ""
        }
        else if textField.tag == 12 //gender
        {
            patientGender = textField.text ?? ""
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
        
        if textField.tag == 11
        {
            let  length:Int = textField.text!.count
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && length < 3
        }
        
        return true
    }
    
    //MARK: Back and Next Button
    @IBAction func backButtonClicked(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
      // showAlert(message: "Please enter all mandatoey fields", title: "Alert")
         let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
         let nextVC = storyBoard.instantiateViewController(withIdentifier: "SymptomCheckerPossibleConditionsId") as? SymptomCheckerPossibleConditions
         navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    
    //MARK: Alert View
    func showAlert(message:String , title:String)
    {
        let alert: UIAlertController = UIAlertController.init(title:title, message:message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}
