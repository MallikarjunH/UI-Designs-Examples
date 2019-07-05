//
//  BabyHeightPredictorForm.swift
//  Baby Height Predictor
//
//  Created by mallikarjun on 25/06/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class BabyHeightPredictorForm: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var parentsHeightArray:[String] = []
    var textFieldEditEnabled = false
    var isGenderButtonSelected = false
    var babyGenderValue:String = ""
    var selectHeightPopUpOptionFor:String = ""
    var progressPercentageValue = 0.0
    
    let heightValuesArray =  ["4'0\"","4'1\"","4'2\"","4'3\"","4'4\"","4'5\"","4'6\"","4'7\"","4'8\"","4'9\"","5'0\"","5'1\"","5'2\"","5'3\"","5'4\"","5'5\"","5'6\"","5'7\"","5'8\"","5'9\"","6'0\"","6'1\"","6'2\"","6'3\"","6'4\"","6'5\"","6'6\"","6'7\"","6'8\"","6'9\"","7'0\"","7'1\"","7'2\"","7'3\"","7'4\"","7'5\""]
    
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var progressViewOutlet: UIProgressView!
    @IBOutlet weak var calculateButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.progressViewOutlet.progress = Float(progressPercentageValue)
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        progressViewOutlet.transform = transform
        progressViewOutlet.clipsToBounds = true
        progressViewOutlet.progressTintColor = UIColor(red: 0.00, green: 0.78, blue: 0.71, alpha: 1)
        progressViewOutlet.trackTintColor =  UIColor(red: 0.91, green: 0.89, blue: 0.89, alpha: 1)
        
        calculateButtonOutlet.layer.cornerRadius = 2
        
        self.mainTableView!.tableFooterView = UIView()
        mainTableView.allowsSelection = false
        
        parentsHeightArray.append("0") //fathers height
        parentsHeightArray.append("0") //mothers height
        
        
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
            
            let cell : BabyHeightPredictorFormCell0 = tableView.dequeueReusableCell(withIdentifier: "BabyHeightPredictorFormCell0Id", for: indexPath) as! BabyHeightPredictorFormCell0
            
            return cell
        }
        else if(indexPath.section == 1){
            
            let cell : BabyHeightPredictorFormCell1 = tableView.dequeueReusableCell(withIdentifier: "BabyHeightPredictorFormCell1Id", for: indexPath) as! BabyHeightPredictorFormCell1
            
            cell.maleButton.addTarget(self, action: #selector(maleButtonAction(sender:)), for: .touchUpInside)
            cell.femaleButton.addTarget(self, action: #selector(femaleButtonAction(sender:)), for: .touchUpInside)
            
            if babyGenderValue == "m"{
                cell.maleButton.setTitleColor(.white, for: .normal)
                cell.femaleButton.setTitleColor(.black, for: .normal)
                cell.maleButton.backgroundColor = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
                cell.femaleButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
            }
            else if babyGenderValue == "f"{
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
            
            let cell : BabyHeightPredictorFormCell2 = tableView.dequeueReusableCell(withIdentifier: "BabyHeightPredictorFormCell2Id", for: indexPath) as! BabyHeightPredictorFormCell2
            
            cell.selectFatherHeightButton.addTarget(self, action: #selector(selectHeightPopUpForFather(sender:)), for: .touchUpInside)
            cell.selectMotherHeightButton.addTarget(self, action: #selector(selectHeightPopUpForMother(sender:)), for: .touchUpInside)
            
            // cell.calculateButton.addTarget(self, action: #selector(calculateButtonAction(sender:)), for: .touchUpInside)
            
            if(parentsHeightArray[0] != "0") // father height value
            {
                cell.fatherHeightTextField.text = parentsHeightArray[0]
            }
            else
            {
                cell.fatherHeightTextField.text = ""
            }
            
            if(parentsHeightArray[1] != "0") // mother height value
            {
                cell.motherHeightTextField.text = parentsHeightArray[1]
            }
            else
            {
                cell.motherHeightTextField.text = ""
            }
            
            
            if isGenderButtonSelected && parentsHeightArray[0] != "0" && parentsHeightArray[1] != "0"{
                DispatchQueue.main.async { [weak self] in
                    self!.calculateButtonOutlet.backgroundColor = UIColor(red: 0.42, green: 0.76, blue: 0.35, alpha: 1)
                }
            }
            else{
                DispatchQueue.main.async { [weak self] in
                    self!.calculateButtonOutlet.backgroundColor = UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
                }
            }
            
            return cell
            
        }
    }
    
    //MARK: Update ProgressBar status
    func updateProgressBar(){
        
        DispatchQueue.main.async {
            self.progressViewOutlet.progress = Float(0.01 * self.progressPercentageValue)
            print("value is: \(Float(0.01 * self.progressPercentageValue))")
        }
        
    }
    
    //MARK: TextField Delegates Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Pop Ups
    @objc func selectHeightPopUpForFather(sender:UIButton)
    {
        if isGenderButtonSelected {
            selectHeightPopUpOptionFor = "f"
            self.showDropDownWithData(dropDownData:heightValuesArray)
        }else{
            showAlert(message: "Please select the gender first", title: "Alert")
        }
        
    }
    
    @objc func selectHeightPopUpForMother(sender:UIButton)
    {
        if isGenderButtonSelected {
            selectHeightPopUpOptionFor = "m"
            self.showDropDownWithData(dropDownData:heightValuesArray)
        }else{
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
        
        if selectHeightPopUpOptionFor == "f" {
            parentsHeightArray[0] = selectedOption //for father
            
            if parentsHeightArray[0] != "0" &&  parentsHeightArray[0] != ""{
                progressPercentageValue = progressPercentageValue + 33.33
            }else{
                progressPercentageValue = progressPercentageValue - 33.33
            }
        }
        else{
            parentsHeightArray[1] = selectedOption //for mother
            
            if parentsHeightArray[1] != "0" &&  parentsHeightArray[1] != ""{
                progressPercentageValue = progressPercentageValue + 33.33
            }else{
                progressPercentageValue = progressPercentageValue - 33.33
            }
        }
        
        updateProgressBar()
        self.mainTableView.reloadData()
        
    }
    
    // MARK: Male and Famale Button Actions
    @objc func maleButtonAction(sender:UIButton){
        //  print("male Button Clicked")
        isGenderButtonSelected = true
        babyGenderValue = "m"
        
        if progressPercentageValue == 33.33 {
            progressPercentageValue =  33.33
        }else{
            if progressPercentageValue > 1{
                
            }else{
                progressPercentageValue = progressPercentageValue + 33.33
            }
        }
        
        updateProgressBar()
        self.mainTableView.reloadData()
    }
    
    @objc func femaleButtonAction(sender:UIButton){
        //  print("female Button Clicked")
        isGenderButtonSelected = true
        babyGenderValue = "f"
        
        if progressPercentageValue == 33.33 {
            progressPercentageValue =  33.33
        }else{
            if progressPercentageValue > 1{
                
            }else{
                progressPercentageValue = progressPercentageValue + 33.33
            }
        }
        
        updateProgressBar()
        self.mainTableView.reloadData()
    }
    
    func showAlert(message:String , title:String)
    {
        let alert: UIAlertController = UIAlertController.init(title:title, message:message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Calculate Button Clicked
    @IBAction func calculateButtonClicked(_ sender: Any) {
        
        if !isGenderButtonSelected{
            showAlert(message: "Please select the gender first", title: "Alert")
        }
        else if parentsHeightArray[0] == "0" {
            showAlert(message: "Please select height of father", title: "Alert")
        }
        else if parentsHeightArray[1] == "0" {
            showAlert(message: "Please select height of mother", title: "Alert")
        }
        else{
            //api call
            print("Calculate result ")
            
       /*     let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let babyHeightPredictorResult = storyBoard.instantiateViewController(withIdentifier: "BabyHeightPredictorResultId") as? BabyHeightPredictorResult
            
            if (navigationController?.topViewController is BabyHeightPredictorResult) {
                return
            } else {
                
                navigationController?.pushViewController(babyHeightPredictorResult!, animated: true)
            } */
        }
    }

}
