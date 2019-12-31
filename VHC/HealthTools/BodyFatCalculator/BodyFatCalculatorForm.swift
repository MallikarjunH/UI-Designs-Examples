//
//  BodyFatCalculatorForm.swift
//  VidalHealth
//
//  Created by mallikarjun on 14/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class BodyFatCalculatorForm: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,MMWeightPickerDelegate {
    //HeightSelectionPopUpVCDelegate
    
   
 //   var popUpViewController: STPopupController!
    
    var usersDataArray:[String] = []
    var textFieldEditEnabled = false
    var patientGenderValue:String = ""
    var editingTextField:Int = 0
    var progressPercentageValueForMale = 0.0
    var progressPercentageValueForMale1 = 0.0
     var progressPercentageValueForMale2 = 0.0
    
    var progressPercentageValueForFemale = 0.0
    var progressPercentageValueForFemale1 = 0.0
    var progressPercentageValueForFemale2 = 0.0
    var progressPercentageValueForFemale3a = 0.0
    var progressPercentageValueForFemale3b = 0.0
    var progressPercentageValueForFemale4a = 0.0
    var progressPercentageValueForFemale4b = 0.0
    var progressPercentageValueForFemale5a = 0.0
    var progressPercentageValueForFemale5b = 0.0
    
 //   var isHeightIsSelected = false
    var isWightIsSelected = false
    
    var totalBodyFatPercentageValue:Double?
    var fitnessResult = ""

 //   let heightValuesArray =  ["4'0\"","4'1\"","4'2\"","4'3\"","4'4\"","4'5\"","4'6\"","4'7\"","4'8\"","4'9\"","4'10\"","4'11\"","5'0\"","5'1\"","5'2\"","5'3\"","5'4\"","5'5\"","5'6\"","5'7\"","5'8\"","5'9\"","5'10\"","5'11\"","6'0\"","6'1\"","6'2\"","6'3\"","6'4\"","6'5\"","6'6\"","6'7\"","6'8\"","6'9\"","6'10\"","6'11\"","7'0\"","7'1\"","7'2\"","7'3\"","7'4\"","7'5\""]
    
    @IBOutlet weak var mainTableView: UITableView!
  
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var progressViewOutlet: UIProgressView!
    
    //MARK: ViewControllers methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.progressViewOutlet.progress = 0.0 //Float(progressPercentageValue)
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        progressViewOutlet.transform = transform
        progressViewOutlet.clipsToBounds = true
        progressViewOutlet.progressTintColor = UIColor(red: 0.00, green: 0.78, blue: 0.71, alpha: 1)
        progressViewOutlet.trackTintColor =  UIColor(red: 0.91, green: 0.89, blue: 0.89, alpha: 1)
        
        self.mainTableView!.tableFooterView = UIView()
        mainTableView.allowsSelection = false
        
        usersDataArray.append("0") //weight value
     //   usersDataArray.append("0") //height value
        usersDataArray.append("0") //waist value
        usersDataArray.append("0") //wriest value
        usersDataArray.append("0") //hip value
        usersDataArray.append("0") //foream value
        
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
    
    //MARK: Keyboard Show and Hide Methods
    @objc func keyboardWillShow(_ notification: Notification?) {
        if  editingTextField == 14 || editingTextField == 15 || editingTextField == 16 {
            
            let keyboardSize = (notification?.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
            
            let newVerticalPosition = Float(-(keyboardSize.height ))
            
            moveFrame(toVerticalPosition: newVerticalPosition, forDuration: 0.3)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification?) {
        if editingTextField == 14 || editingTextField == 15 || editingTextField == 16 {
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
    
    //MARK: Update ProgressView
    func updateProgressBar(){
        
        DispatchQueue.main.async {
            if self.patientGenderValue == "m"{
                
                self.progressViewOutlet.progress = Float(0.01 * self.progressPercentageValueForMale)
                print("male value is: \(self.progressPercentageValueForMale)")
                print("% value for male is: \(Float(0.01 * self.progressPercentageValueForMale))")
                
            }else if self.patientGenderValue == "f"{
                
                self.progressViewOutlet.progress = Float(0.01 * self.progressPercentageValueForFemale)
                print("female  value is: \(self.progressPercentageValueForFemale)")
                print("% value for female is: \(Float(0.01 * self.progressPercentageValueForFemale))")
            }
           
        }
        
    }
    
    //MARK: TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        if(indexPath.section == 0){
            
            let cell : HealthToolsCalculatorFormCell0 = tableView.dequeueReusableCell(withIdentifier: "HealthToolsCalculatorFormCell0", for: indexPath) as! HealthToolsCalculatorFormCell0
            
             return cell
        }
        else if(indexPath.section == 1){
            
            let cell : HealthToolsCalculatorFormCell1 = tableView.dequeueReusableCell(withIdentifier: "HealthToolsCalculatorFormCell1", for: indexPath) as! HealthToolsCalculatorFormCell1
           
            cell.maleButton.addTarget(self, action: #selector(maleButtonAction(sender:)), for: .touchUpInside)
            cell.femaleButton.addTarget(self, action: #selector(femaleButtonAction(sender:)), for: .touchUpInside)
            
            if patientGenderValue == "m"{
              cell.maleButton.setTitleColor(.white, for: .normal)
              cell.femaleButton.setTitleColor(.black, for: .normal)
              cell.maleButton.backgroundColor = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
              cell.femaleButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
            }
            else if patientGenderValue == "f"{
                cell.femaleButton.setTitleColor(.white, for: .normal)
                cell.maleButton.setTitleColor(.black, for: .normal)
                cell.femaleButton.backgroundColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
                cell.maleButton.backgroundColor =  UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
            }
            else{
                cell.maleButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
                cell.femaleButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
            }
    
            return cell
        }
        else{
            
            let cell : HealthToolsCalculatorFormCell2 = tableView.dequeueReusableCell(withIdentifier: "HealthToolsCalculatorFormCell2", for: indexPath) as! HealthToolsCalculatorFormCell2
            
           //  cell.calculateButton.addTarget(self, action: #selector(calculateButtonAction(sender:)), for: .touchUpInside)
           //  cell.selectHeightButton.addTarget(self, action: #selector(selectHeightPopUp(sender:)), for: .touchUpInside)
            
            if(usersDataArray[0] != "0") // weight value
            {
                cell.weightTextField.text = "\(usersDataArray[0])"
            }
            else
            {
                cell.weightTextField.text = ""
            }
            
          /*  if(usersDataArray[1] != "0") // height value
            {
                cell.heightTextField.text = usersDataArray[1]
            }
            else
            {
                cell.heightTextField.text = ""
            } */
            
            if(usersDataArray[1] != "0" && usersDataArray[1] != "") // waist circumference
            {
                cell.waistCircumferenceTextField.text = usersDataArray[1]
            }
            else
            {
                cell.waistCircumferenceTextField.text = ""
            }
            
            if patientGenderValue == "m"{
               
                cell.wristCircumferenceTextField.isHidden = true
                cell.hipCircumferenceTextField.isHidden = true
                cell.forearmCircumferenceTextField.isHidden = true
            }
            else{
                
                cell.wristCircumferenceTextField.isHidden = false
                cell.hipCircumferenceTextField.isHidden = false
                cell.forearmCircumferenceTextField.isHidden = false
                
                if(usersDataArray[2] != "0" && usersDataArray[2] != "") // wrist circumference
                {
                    cell.wristCircumferenceTextField.text = usersDataArray[2]
                }
                else
                {
                    cell.wristCircumferenceTextField.text = ""
                }
                
                if(usersDataArray[3] != "0" && usersDataArray[3] != "") // hip circumference
                {
                    cell.hipCircumferenceTextField.text = usersDataArray[3]
                }
                else
                {
                    cell.hipCircumferenceTextField.text = ""
                }
                
                if(usersDataArray[4] != "0" && usersDataArray[4] != "") // forearm circumference
                {
                    cell.forearmCircumferenceTextField.text = usersDataArray[4]
                }
                else
                {
                    cell.forearmCircumferenceTextField.text = ""
                }
                
            }
        
              if patientGenderValue == "m"{
                
                if progressPercentageValueForMale == 99.9999{
                    
                    DispatchQueue.main.async {
                        self.calculateButton.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.calculateButton.backgroundColor = UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
                    }
                }
            }
            else  if patientGenderValue == "f"{
                
                if progressPercentageValueForFemale == 99.9996{
                    
                    DispatchQueue.main.async {
                        self.calculateButton.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.calculateButton.backgroundColor = UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
                    }
                }
                
            }
             else{
                    
                    DispatchQueue.main.async {
                        self.calculateButton.backgroundColor = UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
                    }
                }
          /*  if progressPercentageValueForMale == 99.9999 || progressPercentageValueForFemale == 99.9996{
               
               // print("make green")
                DispatchQueue.main.async {
                    self.calculateButton.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                }
            }
            else{
               // print("no green")
                DispatchQueue.main.async {
                    self.calculateButton.backgroundColor = UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
                }
            } */

            return cell
            
        }
        
    }
    
    // MARK: Select Weight picker
    func weightSelected(_ weight: String?) {
        
        usersDataArray[0] = weight ?? ""
        /*  if usersDataArray[0].hasSuffix(" kg"){
         usersDataArray[0] = usersDataArray[0].replacingOccurrences(of: " kg", with: "")
         } */
        print("Selected weight is: \(usersDataArray[0])")
        
        if usersDataArray[0] != "0" &&  usersDataArray[0] != ""{
            if isWightIsSelected{
                
            }else{
                if patientGenderValue == "m"{
                    
                    progressPercentageValueForMale = progressPercentageValueForMale + 33.3333
                }
                else if patientGenderValue == "f"{
                    
                    progressPercentageValueForFemale = progressPercentageValueForFemale + 16.6666
                }
               
                isWightIsSelected = true
            }
            
        }else{
            if patientGenderValue == "m"{
                
                progressPercentageValueForMale = progressPercentageValueForMale - 33.3333
                
            }else if patientGenderValue == "f"{
               
                progressPercentageValueForFemale = progressPercentageValueForFemale - 16.6666
            }
           
        }
        mainTableView.reloadData()
        updateProgressBar()
    }
    
    //MARK: Select Weight
    func weightPickerView(){
        
        view.endEditing(true)
        
        let completeBlock = { popupView, finished in
            } as MMPopupCompletionBlock
        
        let picker = MMWeightPickerView()
        picker.delegate = self
        picker.show(completeBlock)
    }
    

    
/*    // MARK: Height Selection Pop-up
    @objc func selectHeightPopUp(sender:UIButton)
    {
        editingTextField = 21
        
        if textFieldEditEnabled {
             self.showDropDownWithData(dropDownData:heightValuesArray)
        }
        else{
            showAlert(message: "Please select the gender first", title: "Alert")
        }
    }
    
    func showDropDownWithData(dropDownData: [String]) {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp(_:)))
        let storyBoard = UIStoryboard.init(name: "HealthTools", bundle: nil)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: "HeightSelectionPopUpVCId") as! HeightSelectionPopUpVC
        popUpVC.suggistionPopUpDelegate = self as! HeightSelectionPopUpVCDelegate
        popUpVC.heightValueArray = dropDownData
        
        popUpViewController = STPopupController.init(rootViewController: popUpVC)
        popUpViewController.backgroundView?.addGestureRecognizer(gestureRecognizer)
        popUpViewController.navigationBarHidden = true
        popUpViewController.transitionStyle = STPopupTransitionStyle.fade
        DispatchQueue.main.async(execute: {
            self.popUpViewController.present(in: AppDelegate.topMostController())
        })
    }
    
    @objc func dismissPopUp(_ sender: UITapGestureRecognizer) {
        popUpViewController.dismiss()
    }
    
    func SuggistionPopUpSelected(_ index: Int, _ selectedOption: String) {
         self.view.endEditing(true)
         popUpViewController.dismiss()
       //  print(selectedOption)
         usersDataArray[1] = selectedOption
        
        if usersDataArray[1] != "0" &&  usersDataArray[1] != ""{
            if isHeightIsSelected{
            
            }else{
                progressPercentageValue = progressPercentageValue + 14.2857
                isHeightIsSelected = true
            }
           
        }else{
            progressPercentageValue = progressPercentageValue - 14.2857
        }
         self.mainTableView.reloadData()
         updateProgressBar()
    } */
    
    //MARK: Male and Female Button Actions
    @objc func maleButtonAction(sender:UIButton){
      //  print("male Button Clicked")
        textFieldEditEnabled = true
        patientGenderValue = "m"
        usersDataArray[0] = ""
        usersDataArray[1] = ""
        usersDataArray[2] = ""
        usersDataArray[3] = ""
        usersDataArray[4] = ""
        
        isWightIsSelected = false
        
        progressPercentageValueForMale = 33.3333
        progressPercentageValueForFemale = 16.6666
        
      //  print("Male % = \(progressPercentageValueForMale)")
       // print("Female % = \(progressPercentageValueForFemale)")
        
        if progressPercentageValueForMale == 33.3333 {
            progressPercentageValueForMale =  33.3333
        }else{
            if progressPercentageValueForMale > 100{
               
            }else{
             progressPercentageValueForMale = progressPercentageValueForMale + 33.3333
            }
        }
        updateProgressBar()
        self.mainTableView.reloadData()
    }
    
    @objc func femaleButtonAction(sender:UIButton){
      //  print("female Button Clicked")
        textFieldEditEnabled = true
        patientGenderValue = "f"
        usersDataArray[0] = ""
        usersDataArray[1] = ""
      
        isWightIsSelected = false
        
        progressPercentageValueForFemale = 16.6666
        progressPercentageValueForMale = 33.3333
        
        //print("Male % = \(progressPercentageValueForMale)")
       // print("Female % = \(progressPercentageValueForFemale)")
        
        if progressPercentageValueForFemale == 16.6666 {
            progressPercentageValueForFemale =  16.6666
        }else{
            if progressPercentageValueForFemale > 100{
                
            }else{
               progressPercentageValueForFemale = progressPercentageValueForFemale + 16.6666
            }
        }
        updateProgressBar()
        self.mainTableView.reloadData()
    }
    
    //MARK: TextField Delegates Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        self.mainTableView.reloadData()
        return true
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
            let allowedCharacters = CharacterSet(charactersIn:"0123456789.")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && length < 3
        }
        else if textField.tag == 13 || textField.tag == 14 || textField.tag == 15 || textField.tag == 16 {
            
            let  length:Int = textField.text!.count
            let allowedCharacters = CharacterSet(charactersIn:"0123456789.")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && length < 4
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textFieldEditEnabled {
            return true
        }
        else{
            showAlert(title: "Alert", message: "Please select your Gender", vc: self)
            return false
        }
       
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        editingTextField = textField.tag
        
        if textField.tag == 11{ // weight
            
            self.view.endEditing(true)
            textField.resignFirstResponder()
            weightPickerView()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField){
        
        if textField.tag == 11 //weitghValue
        {
            usersDataArray[0] = textField.text ?? "0"
            
         /*   if usersDataArray[0] != "0" &&  usersDataArray[0] != ""{
                progressPercentageValue = progressPercentageValue + 14.2857
            }else{
                progressPercentageValue = progressPercentageValue - 14.2857
            } */
        }
      /*  else if textField.tag == 12 //height value
        {
            usersDataArray[1] = textField.text ?? "0"
            
             if usersDataArray[1] != "0" &&  usersDataArray[1] != ""{
                progressPercentageValue = progressPercentageValue + 14.2857
            }else{
                progressPercentageValue = progressPercentageValue - 14.2857
            }
        } */
        else if textField.tag == 13 //waist vakue
        {
            usersDataArray[1] = textField.text ?? "0"
            
                if usersDataArray[1] == ""
                {
                    usersDataArray[1] = "0"
                }else{
                    
                }
            
                let waistValue = Float(usersDataArray[1])!
                
                if waistValue > 9.0 && waistValue < 51.0{
                    
                    if patientGenderValue == "m"{
                        if progressPercentageValueForMale == progressPercentageValueForMale1{
                            
                        }else{
                            progressPercentageValueForMale = progressPercentageValueForMale + 33.3333
                            progressPercentageValueForMale1 = progressPercentageValueForMale
                        }
                        
                    }
                    else if patientGenderValue == "f"{
                        
                        if progressPercentageValueForFemale == progressPercentageValueForFemale1{
                        }else{
                            progressPercentageValueForFemale = progressPercentageValueForFemale + 16.6666
                            progressPercentageValueForFemale1 = progressPercentageValueForFemale
                        }
                    }else{}
                }else{
                    
                    
                    if (waistValue > 50.0 || waistValue < 10.0){
                    
                      //  let waistValue = Float(usersDataArray[1])!
                        
                        if waistValue == 0.0 {
                            
                            if patientGenderValue == "m"{
                                if progressPercentageValueForMale == progressPercentageValueForMale2 {
                                    
                                }else{
                                    progressPercentageValueForMale = progressPercentageValueForMale - 33.3333
                                    progressPercentageValueForMale2 = progressPercentageValueForMale
                                }
                                
                            }
                            else if patientGenderValue == "f"{
                                if progressPercentageValueForFemale == progressPercentageValueForFemale2{
                                    
                                }else{
                                    progressPercentageValueForFemale = progressPercentageValueForFemale - 16.6666
                                    progressPercentageValueForFemale2 = progressPercentageValueForFemale
                                }
                            }else{ } //end female if
                        }else{
                            
                        }
    
                    }
                    else{ }
                    usersDataArray[1] = ""
                    showAlert(title: "Alert", message: "Waist circumference values should be in between 10-50 inches", vc: self)
                }
        }
        else if textField.tag == 14 //wrist value
        {
            usersDataArray[2] = textField.text ?? "0"
            
            if usersDataArray[2] == ""
            {
                usersDataArray[2] = "0"
            }else{
                
            }
            
            let wristValue = Float(usersDataArray[2])!
            
            if wristValue > 1.0 && wristValue < 16.0 {
                
                if patientGenderValue == "f"{
                    
                    if progressPercentageValueForFemale == progressPercentageValueForFemale3a{
                        
                    }else{
                        progressPercentageValueForFemale = progressPercentageValueForFemale + 16.6666
                        progressPercentageValueForFemale3a = progressPercentageValueForFemale
                    }
                }
                else{}
            }else{
                
                if wristValue < 2 || wristValue > 16{
                    
                    if wristValue == 0.0{
                    if progressPercentageValueForFemale == progressPercentageValueForFemale3b{
                        
                    }else{
                        progressPercentageValueForFemale = progressPercentageValueForFemale - 16.6666
                        progressPercentageValueForFemale3b = progressPercentageValueForFemale
                        }
                     }
                    
                }else{}
                
                usersDataArray[2] = ""
                showAlert(title: "Alert", message: "Wrist circumference values should be in between 2-15 inches", vc: self)
            }
        }
        else if textField.tag == 15 //hip
        {
            usersDataArray[3] = textField.text ?? "0"
            
            if usersDataArray[3] == ""
            {
                usersDataArray[3] = "0"
            }else{
                
            }
            let hipValue = Float(usersDataArray[3])!
           
            if hipValue > 14.0 && hipValue < 71.0 {
                
                if patientGenderValue == "f"{
                    
                    if progressPercentageValueForFemale == progressPercentageValueForFemale4a{
                        
                    }else{
                        progressPercentageValueForFemale = progressPercentageValueForFemale + 16.6666
                        progressPercentageValueForFemale4a = progressPercentageValueForFemale
                    }
                }
                else{}
            }
            else{
                
                if hipValue == 0.0 {
                    if progressPercentageValueForFemale == progressPercentageValueForFemale4b{
                        
                    }else{
                        progressPercentageValueForFemale = progressPercentageValueForFemale - 16.6666
                        progressPercentageValueForFemale4b = progressPercentageValueForFemale
                    }
                }else{}
               
                usersDataArray[3] = ""
                showAlert(title: "Alert", message: "Hip circumference values should be in between 15-70 inches", vc: self)
            }
        }
        else if textField.tag == 16 //forearm
        {
            usersDataArray[4] = textField.text ?? "0"
            
            if usersDataArray[4] == ""
            {
                usersDataArray[4] = "0"
            }else{
                
            }
            
            let forearmValue = Float(usersDataArray[4])!
           
            if forearmValue > 3.0 && forearmValue < 31.0 {
                
                if patientGenderValue == "f"{
                    
                    if progressPercentageValueForFemale == progressPercentageValueForFemale5a{
                        
                    }else{
                        progressPercentageValueForFemale = progressPercentageValueForFemale + 16.6666
                        progressPercentageValueForFemale5a = progressPercentageValueForFemale
                    }
                }
                else{}
            }else{
                if forearmValue == 0.0{
                    if progressPercentageValueForFemale == progressPercentageValueForFemale5b{
                        
                    }else{
                        progressPercentageValueForFemale = progressPercentageValueForFemale - 16.6666
                        progressPercentageValueForFemale5b = progressPercentageValueForFemale
                    }
                }
                else{}
                usersDataArray[4] = ""
                showAlert(title: "Alert", message: "Forearm circumference values should be in between 4-30 inches", vc: self)
            }
        }
        
        self.mainTableView.reloadData()
        updateProgressBar()
    }

    
    //MARK: Calculate Button Clicked

    @IBAction func calculateButtonClicked(_ sender: Any) {
      
        self.view.endEditing(true)
    
        GlobalVariables.sharedManager.genderTypeForBFC = patientGenderValue
    
        if patientGenderValue == "m"{
            
            if usersDataArray[0] == "" || usersDataArray[0] == "0"{
                
                showAlert(title: "Alert", message: "Please enter your Weight (in Kilograms)", vc: self)
            }
            else if usersDataArray[1] == "" || usersDataArray[1] == "0"{
                
                showAlert(title: "Alert", message: "Please enter your Waist circumference (in inches)", vc: self)
            }
            else{
                
                 calculateBodyFatCalculatorResultForMale()
            }
        }
        else if patientGenderValue == "f"{
            
            if  usersDataArray[0] == "" || usersDataArray[0] == "0"{
                
                showAlert(title: "Alert", message: "Please enter your Weight (in Kilograms)", vc: self)
            }
            else if  usersDataArray[1] == "" || usersDataArray[1] == "0"{
                
                showAlert(title: "Alert", message: "Please enter your Waist circumference (in inches)", vc: self)
            }
            else if  usersDataArray[2] == "" || usersDataArray[2] == "0"{
                
                showAlert(title: "Alert", message: "Please enter your Wrist circumference (in inches)", vc: self)
            }
            else if  usersDataArray[3] == "" || usersDataArray[3] == "0"{
                
                showAlert(title: "Alert", message: "Please enter your Hip circumference (in inches)", vc: self)
            }
            else if  usersDataArray[4] == "" || usersDataArray[4] == "0"{
                
                showAlert(title: "Alert", message: "Please enter your Forearm circumference (in inches)", vc: self)
            }
            else{
                
                 calculateBodyFatCalculatorResultForFemale()
            }
            
        } //end female
        else{
            showAlert(title: "Alert", message: "Please select your Gender", vc: self)
        }
    }
    
    
    func calculateBodyFatCalculatorResultForMale(){
        
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let bodyFatCalculatorResult = storyBoard.instantiateViewController(withIdentifier: "BodyFatCalculatorResultId") as? BodyFatCalculatorResult
        
          //  print("inside calculateBodyFatCalculatorResultForMale")
            usersDataArray[0] = usersDataArray[0].replacingOccurrences(of: " kg", with: "")
            
            let weightValue = Double(usersDataArray[0])
            let waistCircumferenceValue = Double(usersDataArray[1])
            
            
            let totalBodyWeight = weightValue! * 2.20462
            let factor1 = (totalBodyWeight * 1.082) + 94.42
            let factor2 = waistCircumferenceValue! * 4.15
            
            let leanBodyMass = factor1 - factor2
            let bodyFatWeight = totalBodyWeight - leanBodyMass
            
            let bodyFatPercentage = (bodyFatWeight * 100) / totalBodyWeight
        
            totalBodyFatPercentageValue = (bodyFatPercentage*10).rounded()/10 // conversion into 1 decimal values
            // print("Total % is: \(totalBodyFatPercentageValue)")
            
            //checking %
            if totalBodyFatPercentageValue! < 3 || totalBodyFatPercentageValue! > 40.0{
                // show error msg
                showAlert(title: "Alert", message: "Please check if the data entered is correct.", vc: self)
            }
            else{
                
                if totalBodyFatPercentageValue! < 6 && totalBodyFatPercentageValue! > 2.9 {
                    
                    fitnessResult = "Essential Fat"
                }
                else if totalBodyFatPercentageValue! < 14.0 && totalBodyFatPercentageValue! > 5.9 {
                    
                    fitnessResult = "Athletes"
                }
                else if totalBodyFatPercentageValue! < 18.0 && totalBodyFatPercentageValue! > 13.9 {
                    
                    fitnessResult = "Fitness"
                }
                else if totalBodyFatPercentageValue! < 25.0 && totalBodyFatPercentageValue! > 17.9 {
                    
                    fitnessResult = "Average"
                }
                else if totalBodyFatPercentageValue! > 25.0 && totalBodyFatPercentageValue! < 41.0{
                    
                    fitnessResult = "Obese"
                }
                
                //naviagte to next vc
                GlobalVariables.sharedManager.fitnessResult = fitnessResult
                GlobalVariables.sharedManager.totalBodyFatPercentageValue = totalBodyFatPercentageValue ?? 0.0
               
               // print("naviagte go")
                
                navigationController?.pushViewController(bodyFatCalculatorResult!, animated: true)
            
            }
        
    }
    
    func calculateBodyFatCalculatorResultForFemale(){
        
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let bodyFatCalculatorResult = storyBoard.instantiateViewController(withIdentifier: "BodyFatCalculatorResultId") as? BodyFatCalculatorResult
        
            usersDataArray[0] = usersDataArray[0].replacingOccurrences(of: " kg", with: "")
            let weightValue = Double(usersDataArray[0])
            let waistCircumferenceValue = Double(usersDataArray[1])
            let wristCircumferenceValue = Double(usersDataArray[2])
            let hipCircumferenceValue = Double(usersDataArray[3])
            let forearmCircumferenceValue = Double(usersDataArray[4])
            
            let totalBodyWeight = weightValue! * 2.20462
            let factor1 = (totalBodyWeight * 0.732) + 8.987
            let factor2 = wristCircumferenceValue! / 3.140
            let factor3 = waistCircumferenceValue! * 0.157
            let factor4 = hipCircumferenceValue! * 0.249
            let factor5 = forearmCircumferenceValue! * 0.434
            
            let leanBodyMass = factor1 + factor2 - factor3 - factor4 + factor5
            let bodyFatWeight = totalBodyWeight - leanBodyMass
            let bodyFatPercentage = (bodyFatWeight * 100) / totalBodyWeight
            
            totalBodyFatPercentageValue = (bodyFatPercentage*10).rounded()/10 // conversion into 1 decimal values
            // print("Total % is: \(totalBodyFatPercentageValue)")
            
             //checking %
            if totalBodyFatPercentageValue! < 10 || totalBodyFatPercentageValue! > 40.0 {
                
                showAlert(title: "Alert", message: "Please check if the data entered is correct.", vc: self)
            }else{
                
                if totalBodyFatPercentageValue! < 14.0 && totalBodyFatPercentageValue! > 9.9 {
                    
                    fitnessResult = "Essential Fat"
                }
                else if totalBodyFatPercentageValue! < 21.0 && totalBodyFatPercentageValue! > 13.9 {
                    
                    fitnessResult = "Athletes"
                }
                else if totalBodyFatPercentageValue! < 25.0 && totalBodyFatPercentageValue! > 20.9 {
                    
                    fitnessResult = "Fitness"
                }
                else if totalBodyFatPercentageValue! < 32.0 && totalBodyFatPercentageValue! > 24.9 {
                    
                    fitnessResult = "Average"
                }
                else if totalBodyFatPercentageValue! > 32.9 && totalBodyFatPercentageValue! < 41.0{
                    
                    fitnessResult = "Obese"
                }
                
                //navigate to next vc
                GlobalVariables.sharedManager.fitnessResult = fitnessResult
                GlobalVariables.sharedManager.totalBodyFatPercentageValue = totalBodyFatPercentageValue ?? 0.0
                
                if (navigationController?.topViewController is BodyFatCalculatorResult) {
                    return
                } else {
                    
                    navigationController?.pushViewController(bodyFatCalculatorResult!, animated: true)
                }
            }
        
    }
    
    //MARK: Navigation Bar Buttons
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func callButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(emergencyVC, animated: true)
        }
        
    }
    
}
