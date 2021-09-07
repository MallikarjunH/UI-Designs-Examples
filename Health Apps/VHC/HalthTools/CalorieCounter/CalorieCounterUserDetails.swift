//
//  CalorieCounterUserDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 08/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCounterUserDetails: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,VCDatePickerActionDelegate,MMWeightPickerDelegate,SelectItemPopUpDelegate,HeightSelectionPopUpVCDelegate{

    var nameValue:String = ""
    var genderValue: String = ""
    var dateOfBirth: String = ""
    var weightValue: String = ""
    var heightValue: String = ""
    var activityLevelValue:String = ""
    
    var ageInYears = 0
    var weightValueNew = 0.0
    var heightInCm = 0.0
    var givenDob:Date?
    
    var selectedTextField = ""
    
    var editingTextField:Int = 0
    
    var lDatePicker: VC_Date_And_Time_Picker? = nil
    
    var popUp: STPopupController? = nil
    var popUpViewController: STPopupController!
    
    let heightValuesArray =  ["4'0\"","4'1\"","4'2\"","4'3\"","4'4\"","4'5\"","4'6\"","4'7\"","4'8\"","4'9\"","4'10\"","4'11\"","5'0\"","5'1\"","5'2\"","5'3\"","5'4\"","5'5\"","5'6\"","5'7\"","5'8\"","5'9\"","5'10\"","5'11\"","6'0\"","6'1\"","6'2\"","6'3\"","6'4\"","6'5\"","6'6\"","6'7\"","6'8\"","6'9\"","6'10\"","6'11\"","7'0\"","7'1\"","7'2\"","7'3\"","7'4\"","7'5\""]
    
    let activityLevelOptionsArray = ["Sedentary","Less Active","Moderately Active","Very Active","Extremely Active"]
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounteUsersDetailsCellId", for: indexPath) as! CalorieCounteUsersDetailsCell
         cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        // name value
        if nameValue != ""{
            
            cell.nameTextField.text = nameValue
        }else{
            cell.nameTextField.text = ""
        }
        
        // Date of birth
        if dateOfBirth != ""{
            
            cell.dateOfBirthTextField.text = dateOfBirth
        
                let now = Date()
                let ageComponents = Calendar.current.dateComponents([.year], from: givenDob!, to: now)
                let age = ageComponents.year
                ageInYears = age!
            
        }else{
            cell.dateOfBirthTextField.text = ""
        }
        
        //weight
        let weight = weightValue
        if weight != ""{
            cell.weightTextField.text = "\(weight) Kg"
            weightValueNew = Double(weight) ?? 0.0
        }
        else{
            cell.weightTextField.text = ""
        }
        
        //height
        let height = heightValue
        if height != ""{
            cell.heightTextField.text = "\(height) inc"
            
            var heightValue1 = height
            heightValue1 = heightValue1.replacingOccurrences(of: "\'", with: ".")
            heightValue1 = heightValue1.replacingOccurrences(of: "\"", with: "") //5.4
            
            let feetValue = heightValue1.prefix(1) //e.g 5 in feet
            let FeetValueTest = "\(feetValue)."
            let inchValue =  heightValue1.replacingOccurrences(of: "\(FeetValueTest)", with: "") // 4 in inches
            let feetInCm = Double(feetValue)
            let inchInCm = Double(inchValue)
            
            heightInCm = (feetInCm! * 30.48) + (inchInCm! * 2.54)
        }
        else{
            cell.heightTextField.text = ""
        }
        
        //gender
        if (genderValue == "f") {
            cell.genderTextField.text = "Female"
        } else if (genderValue == "m") {
           cell.genderTextField.text = "Male"
        } else if (genderValue == "o") {
            cell.genderTextField.text = "Other"
        }
        else{
            cell.genderTextField.text = ""
        }
        
        // activity level
        if activityLevelValue != ""{
            
            cell.activityLevelTextField.text = activityLevelValue
        }else{
            cell.activityLevelTextField.text = ""
        }
        
        return cell
    }
    
    
    //MARK: Select date
    func showDatePicker(){
        
        if lDatePicker == nil {
            lDatePicker = VC_Date_And_Time_Picker(frame: view.frame)
            lDatePicker?.actionDelegate = self
            lDatePicker?.setMode(UIDatePickerMode.date)
            lDatePicker?.setMaxDate(Date())
            view.addSubview(lDatePicker!)
            
            let minDate = "01-01-1900"
            
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd-MM-yyyy"
            let minNSDate: Date? = dateFormat.date(from: minDate)
            lDatePicker?.setMinDate(minNSDate)// = minNSDate
        }
    }
    
    func cancel(_ sender: Any!) {
        
        if lDatePicker != nil {
            lDatePicker?.isHidden = true
            lDatePicker = nil
        }
    }
    
    func done(_ selectedDateAndTime: Date!) {
        
        let lDateFor = DateFormatter()
        lDateFor.dateFormat = "dd MMM, yyyy"
        let value = lDateFor.string(from: selectedDateAndTime)
        
        let lDa: Date? = lDateFor.date(from: value)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy"
        givenDob = lDa
        var lDOB: String? = nil
        if let lDa = lDa {
            lDOB = dateFormatter.string(from: lDa)
        }
        
        (view.viewWithTag(122) as? UILabel)?.text = lDOB
        dateOfBirth = lDOB ?? ""
        lDatePicker?.isHidden = true
        lDatePicker = nil
        
        mainTableView.reloadData()
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
    
    func weightSelected(_ weight: String?) {
        
        weightValue = weight ?? ""
        if weightValue.hasSuffix(" kg"){
            weightValue = weightValue.replacingOccurrences(of: " kg", with: "")
        }
        print("Selected weight is: \(weightValue)")
        mainTableView.reloadData()
    }
    
    //MARK: Select Gender
    func showGender(){
        
        openPopUp(type: "gender")
    }
    
    func openPopUp(type:String){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopUp2))
        let lSelectItemFromListPopUp = storyBoard.instantiateViewController(withIdentifier: "SelectItemFromListPopUp") as? SelectItemFromListPopUp
        //  lSelectItemFromListPopUp?.delegate = (self as! SelectItemPopUpDelegate)
        lSelectItemFromListPopUp?.popUpType = type
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
    
    @objc func dismissPopUp2() {
        popUp?.dismiss()
    }
    
    func selectedItem(fromPopUp item: String?, popUpType type: String?) {
        
        if (type == "gender") {
            
            (view.viewWithTag(121) as? UILabel)?.text = item
            
            if (item == "Male") {
                genderValue = "m"
            } else if (item == "Female") {
                genderValue = "f"
            } else {
                genderValue = "o"
            }
            
            mainTableView.reloadData()
        }
        dismissPopUp2()
    }
    
    //MARK: Select height
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
        
        if selectedTextField == "heightOption"{
            heightValue = selectedOption
        }else{
            activityLevelValue = selectedOption
        }
        
        self.mainTableView.reloadData()
    }
    
    //MARK: TextField Delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
         self.mainTableView.reloadData()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 6{ // weight
            
            self.view.endEditing(true)
            textField.resignFirstResponder()
            weightPickerView()
        }
        else if textField.tag == 7{  // height
            selectedTextField = "heightOption"
            self.view.endEditing(true)
            textField.resignFirstResponder()
            self.showDropDownWithData(dropDownData:heightValuesArray)
        }
        else if textField.tag == 8{ // gender
            
            self.view.endEditing(true)
            textField.resignFirstResponder()
            showGender()
        }
        else if textField.tag == 9{ //dob
            
            self.view.endEditing(true)
            textField.resignFirstResponder()
            showDatePicker()
        }
        else if textField.tag == 10{ //activity level
            selectedTextField = "activityLevelOption"
            self.view.endEditing(true)
            textField.resignFirstResponder()
            self.showDropDownWithData(dropDownData:activityLevelOptionsArray)
        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
        if textField.tag == 5 //name value
        {
            nameValue = textField.text ?? ""
        }
        else  if textField.tag == 6 //weight value
        {
            weightValue = textField.text ?? ""
        }
        else  if textField.tag == 7 //height value
        {
            heightValue = textField.text ?? ""
        }
        else  if textField.tag == 8 //gender value
        {
            genderValue = textField.text ?? ""
        }
        else  if textField.tag == 9 //dob value
        {
            dateOfBirth = textField.text ?? ""
            
        }
        else  if textField.tag == 10 //activity level value
        {
             activityLevelValue = textField.text ?? ""
        }
        else{
            
        }
        self.mainTableView.reloadData()
    }
    
    func calculateBmrValue(){
        
        var bmrValue = 0.0
        if genderValue == "m"{
      
            bmrValue = 88.362 + (13.397 * weightValueNew)
            bmrValue = bmrValue + (4.799 * heightInCm)
            bmrValue = bmrValue - (5.677 * Double(ageInYears))

        }else{
            
            bmrValue = 447.593 + (9.247 * weightValueNew)
            bmrValue = bmrValue + (3.098 * heightInCm)
            bmrValue = bmrValue - (4.330 * Double(ageInYears))
        }
        
        if(activityLevelValue == "Sedentary"){
            bmrValue = bmrValue * 1.2
        }
        else if(activityLevelValue == "Less Active"){
             bmrValue = bmrValue * 1.375
        }
        else if(activityLevelValue == "Moderately Active"){
              bmrValue = bmrValue * 1.55
        }
        else if(activityLevelValue == "Very Active"){
              bmrValue = bmrValue * 1.725
        }
        else if(activityLevelValue == "Extremely Active"){
               bmrValue = bmrValue * 1.9
        }else{}
        
        let bmrInInt = Int(bmrValue)
        GlobalVariables.sharedManager.bmrValue = "\(bmrInInt)"
    }
    
    func showAlert(message:String , title:String)
    {
        let alert: UIAlertController = UIAlertController.init(title:title, message:message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Navigation Button and Bottom Buttons Actions
    @IBAction func calculateBmrButtonAction(_ sender: Any) {
        
      //  print("Hight in Cm:\(heightInCm) and Age in Years: \(ageInYears)")
       
   /*     if nameValue == ""{
            
            showAlert(message: "Please enter your name", title: "Alert")
        }
        else if weightValue == ""{
            
            showAlert(message: "Please select your weight", title: "Alert")
        }
        else if heightValue == ""{
            
            showAlert(message: "Please select your height", title: "Alert")
        }
        else if genderValue == ""{
            
            showAlert(message: "Please select your gender", title: "Alert")
        }
        else if dateOfBirth == ""{
            
            showAlert(message: "Please select your date of birth", title: "Alert")
        }
        else if activityLevelValue == ""{
            
            showAlert(message: "Please select any activity level", title: "Alert")
        }
        else{
            
            if genderValue == "o"{
               
                 showAlert(message: "Gender should be either male or male", title: "Alert")
            }
            else{
                calculateBmrValue()
                
                let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
                let detailsVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterBmrCounterId") as? CalorieCounterBmrCounter
                self.navigationController?.pushViewController(detailsVC!, animated: true)
            }
            
        } */
        
        calculateBmrValue()
        
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterBmrCounterId") as? CalorieCounterBmrCounter
        self.navigationController?.pushViewController(detailsVC!, animated: true)
       
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
    
}
