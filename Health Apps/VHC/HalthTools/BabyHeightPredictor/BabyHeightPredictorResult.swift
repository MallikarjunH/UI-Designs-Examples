//
//  BabyHeightPredictorResult.swift
//  VidalHealth
//
//  Created by mallikarjun on 20/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class BabyHeightPredictorResult: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var okButtonOutlet: UIButton!
    
    var heightInFeetValue:String = ""
    var heightInInchesValue:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateBabyHeight()
        
        okButtonOutlet.layer.cornerRadius = 2
        
        self.mainTableView!.tableFooterView = UIView()
        mainTableView.allowsSelection = false
        
    }
    
    // HP Formula Implementation
    func calculateBabyHeight(){
        
        var fatherHeight = GlobalVariables.sharedManager.heightArrayOfFatherAndMotherForHp![0]
        var motherHeight = GlobalVariables.sharedManager.heightArrayOfFatherAndMotherForHp![1]
        
        // Father
        fatherHeight = fatherHeight.replacingOccurrences(of: "\'", with: ".")
        fatherHeight = fatherHeight.replacingOccurrences(of: "\"", with: "")
        
        let fatherFeetValue = fatherHeight.prefix(1) //need to use
        let  fatherFeetValueTest = "\(fatherFeetValue)."
        
        let fatherIchesValue = fatherHeight.replacingOccurrences(of: "\(fatherFeetValueTest)", with: "") //need to use
        // print("Father Feet: \(fatherFeetValue) and Inches: \(fatherIchesValue)") // 5' 9"
        
        var fatherHeightFeetInCentimeters = Double(fatherFeetValue) //* 30.48  //+ (Int(fatherIchesValue) * 2.54)
        var fatherHeightInchesInCentimeters = Double(fatherIchesValue)
        fatherHeightFeetInCentimeters = fatherHeightFeetInCentimeters! * 30.48
        fatherHeightInchesInCentimeters = fatherHeightInchesInCentimeters! * 2.54
        
        let fatherHeightInCentimeters:Int = Int(fatherHeightFeetInCentimeters!) + Int(fatherHeightInchesInCentimeters!) // final value for father
        //print("Father Height in Cent: \(fatherHeightInCentimeters)")
        
        //Mother
        motherHeight = motherHeight.replacingOccurrences(of: "\'", with: ".")
        motherHeight = motherHeight.replacingOccurrences(of: "\"", with: "")
        
        let motherFeetValue = motherHeight.prefix(1) //need to use
        let  motherFeetValueTest = "\(motherFeetValue)."
        
        let MotherIchesValue = motherHeight.replacingOccurrences(of: "\(motherFeetValueTest)", with: "") //need to use
        // print("Mother Feet: \(motherFeetValue) and Inches: \(MotherIchesValue)")  // 4' 11"
        
        var motherHeightFeetInCentimeters = Double(motherFeetValue)
        var motherHeightInchesInCentimeters = Double(MotherIchesValue)
        motherHeightFeetInCentimeters = motherHeightFeetInCentimeters! * 30.48
        motherHeightInchesInCentimeters = motherHeightInchesInCentimeters! * 2.54
        
        let motherHeightInCentimeters:Int = Int(motherHeightFeetInCentimeters!) + Int(motherHeightInchesInCentimeters!) // final value for mother
        // print("Mother Height in Cent: \(motherHeightInCentimeters)")
        
        // HeightPredictor
        
        if GlobalVariables.sharedManager.genderTypeForBFC == "m"{
            
            // let childrenHeight = motherHeightInCentimeters + 13
            // var totalHeight = Double(childrenHeight)/30.48
            
            let childrenHeight =  (fatherHeightInCentimeters + (motherHeightInCentimeters + 13)) / 2;
            var totalHeight = Double(childrenHeight)/30.48
            
            totalHeight = (totalHeight*10).rounded()/10
            
            let totalHeightInString = String(totalHeight)
            // print("Total Height: \(totalHeightInString)")
            
            let feetValue =  totalHeightInString.prefix(1)
            let feetValue1 = "\(feetValue)."
            let feetValue2 = totalHeightInString.replacingOccurrences(of: "\(feetValue1)", with: "")
            
            let inchValue = Double(feetValue2)
            let inchValueNew = Int((0.1 * inchValue!) * 12.0)
            
            heightInFeetValue = "\(feetValue)"
            heightInInchesValue = "\(inchValueNew)"
            // print("For Male Child: Feet is: \(feetValue) and inches: \(inchValue)")
        }
        else{
            //  let childrenHeight = fatherHeightInCentimeters - 13
            //  var totalHeight = Double(childrenHeight)/30.48
            
            let  childrenHeight = ((fatherHeightInCentimeters - 13) + motherHeightInCentimeters) / 2;
            var totalHeight = Double(childrenHeight)/30.48
            
            totalHeight = (totalHeight*10).rounded()/10
            
            let totalHeightInString = String(totalHeight)
            //   print("Total Height: \(totalHeightInString)")
            
            let feetValue =  totalHeightInString.prefix(1)
            let feetValue1 = "\(feetValue)."
            let feetValue2 = totalHeightInString.replacingOccurrences(of: "\(feetValue1)", with: "")
            
            let inchValue = Double(feetValue2)
            let inchValueNew = Int((0.1 * inchValue!) * 12.0)
            
            heightInFeetValue = "\(feetValue)"
            heightInInchesValue = "\(inchValueNew)"
            // print("For Female Child: Feet is: \(feetValue) and inches: \(inchValue)")
        }
        
        
        
    }
    
    //MARK: TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            
            let cell : BabyHeightPredictorResultCell1 = tableView.dequeueReusableCell(withIdentifier: "BabyHeightPredictorResultCell1Id", for: indexPath) as! BabyHeightPredictorResultCell1
            
            if GlobalVariables.sharedManager.genderTypeForBFC == "m"{
                
                cell.predictedHeightForYourChildLabel.text = "Predicted height of your son"
            }
            else{
                cell.predictedHeightForYourChildLabel.text = "Predicted height of your daughter"
            }
            
            cell.predictedHeightLabel.text = "\(heightInFeetValue) feet \(heightInInchesValue) inches"
            
            cell.predictedHeightDetailsLabel.text = ""
            
            return cell
        }
        else{
            
            let cell : BabyHeightPredictorResultCell2 = tableView.dequeueReusableCell(withIdentifier: "BabyHeightPredictorResultCell2Id", for: indexPath) as! BabyHeightPredictorResultCell2
            
            cell.heightPredictorResultLabel.text = "Height predictor is a fun tool that will help you predict the probable height of your fully grown child."
            return cell
        }
        
    }
    
    ////MARK: Navigation and Bottom Buttons
    @IBAction func okButtonAction(_ sender: Any) {
        //come back to main VC
        let allViewControllers = navigationController?.viewControllers
        for aViewController in allViewControllers ?? [] {
            if (aViewController is HealthToolsList) {
                navigationController?.popToViewController(aViewController, animated: true)
            }
        }
    }
    
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
    
    @IBAction func emergencyCallButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(emergencyVC, animated: true)
        }
    }
    
    
    
}
