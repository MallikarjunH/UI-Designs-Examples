//
//  BodyFatCalculatorResult.swift
//  VidalHealth
//
//  Created by mallikarjun on 14/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class BodyFatCalculatorResult: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var genderValue = ""
   // var usersDataArray:[String] = []
    var totalBodyFatPercentageValue:Double?
    var fitnessResult = ""
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        genderValue =  GlobalVariables.sharedManager.genderTypeForBFC!
       // usersDataArray = GlobalVariables.sharedManager.userDataArrayForBFC!
        totalBodyFatPercentageValue = GlobalVariables.sharedManager.totalBodyFatPercentageValue
        fitnessResult = GlobalVariables.sharedManager.fitnessResult
        
        self.mainTableView!.tableFooterView = UIView()
        mainTableView.allowsSelection = false
        
        // Do any additional setup after loading the view.
    }
    


    //MARK: TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            
            let cell : BodyFatCalculatorResultCell1 = tableView.dequeueReusableCell(withIdentifier: "BodyFatCalculatorResultCell1Id", for: indexPath) as! BodyFatCalculatorResultCell1
            
            print("\(totalBodyFatPercentageValue!)")
            print(fitnessResult)
            
            cell.percentageLabel.text = "\(totalBodyFatPercentageValue!) %"
            cell.fitnessResultLabel.text = fitnessResult
            
            if fitnessResult == "Essential Fat"{
                
                cell.fitnessResultImage.image = UIImage(named: "underweightPic")
            }
            else if fitnessResult == "Athletes"{
                
                cell.fitnessResultImage.image = UIImage(named: "athletePic")
            }
            else if fitnessResult == "Fitness"{
                
                cell.fitnessResultImage.image = UIImage(named: "athletePic")
            }
            else if fitnessResult == "Average"{
                
                cell.fitnessResultImage.image = UIImage(named: "acceptablePic")
            }
            else if fitnessResult == "Obese"{
                
                cell.fitnessResultImage.image = UIImage(named: "obesePic")
            }
            else{
                
                
            }
            
            return cell
        }
        else if(indexPath.section == 1){
            
            let cell : BodyFatCalculatorResultCell2 = tableView.dequeueReusableCell(withIdentifier: "BodyFatCalculatorResultCell2Id", for: indexPath) as! BodyFatCalculatorResultCell2
           
            cell.resultDescriptionLabel.text = "Body fat Calculator is a tool that will help you to measure percentage of fat in your body, using specific measurements."
            return cell
        }
        else  if(indexPath.section == 2){
            
            let cell : BodyFatCalculatorResultCell3 = tableView.dequeueReusableCell(withIdentifier: "BodyFatCalculatorResultCell3Id", for: indexPath) as! BodyFatCalculatorResultCell3
            
            return cell
            
        }
        else{
            let cell : BodyFatCalculatorResultCell4 = tableView.dequeueReusableCell(withIdentifier: "BodyFatCalculatorResultCell4Id", for: indexPath) as! BodyFatCalculatorResultCell4
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        var height:CGFloat = CGFloat()
        if indexPath.section == 0 {
            mainTableView.rowHeight = 180
            height = mainTableView.rowHeight
        }
        else if indexPath.section  == 1 {
            mainTableView.rowHeight = UITableViewAutomaticDimension
            height =  mainTableView.rowHeight
        }
        else if indexPath.section  == 2 {
           mainTableView.rowHeight = 297
           height =  mainTableView.rowHeight
        }
        else{
            
            mainTableView.rowHeight = 50
            height =  mainTableView.rowHeight
        }
        
        return height
    }
    
    
    //MARK: Alert msg
    func showAlert(message:String , title:String)
    {
        let alert: UIAlertController = UIAlertController.init(title:title, message:message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Navigation Buttons
    @IBAction func okButtonClicked(_ sender: Any) {
        
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
    
    @IBAction func notiificationButtonClicked(_ sender: Any) {
      
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
