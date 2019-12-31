//
//  HealthToolsList.swift
//  VidalHealth
//
//  Created by mallikarjun on 14/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class HealthToolsList: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
   // let healthToolsNamesArray = ["Body Fat Calculator","Height Predictor","Baby Bump Tracker","Symptom Checker","Calorie Counter","Health Logs","Activity Tracker","Pill Reminder","Menstruation Calender"]
  //  let healthToolsImageArray = ["bmi_calculator","baby_height_predictor","babay_bump_predictor","symptomChecker","calorie_calculator","health_log","activity_tracker","pill_reminder", "pms_calculator"]
    
    let healthToolsNamesArray = ["Body Fat Calculator","Height Predictor","Baby Bump Tracker","Health Logs"]
    let healthToolsImageArray = ["bmi_calculator","baby_height_predictor","babay_bump_predictor","health_log"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let lPatient = AppUtilities.getCurrentSelectedPatientInMyFamily()
        
        if lPatient?.full_name != nil {
            GlobalVariables.sharedManager.loggedUserName = lPatient!.full_name!
        } else {
           GlobalVariables.sharedManager.loggedUserName = "No Name"
        }
        
      /*  if lPatient!.patient_slug != nil {
            GlobalVariables.sharedManager.patientSlug = lPatient!.patient_slug!
        } else {
            GlobalVariables.sharedManager.patientSlug =  ""
        } */
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    //MARK: CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return healthToolsNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "healthToolsListCell", for: indexPath) as! HealthToolsListCollectionViewCell
    
        cell.itemTitle.text = healthToolsNamesArray[indexPath.item]
        cell.itemImages.image = UIImage(named: healthToolsImageArray[indexPath.row])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if indexPath.item == 0{ // Body Fat Calculator
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let bodyFatCalculatorVC = storyBoard.instantiateViewController(withIdentifier: "BodyFatCalculatorFormId") as? BodyFatCalculatorForm
    
            if (navigationController?.topViewController is BodyFatCalculatorForm) {
                return
            } else {
                navigationController?.pushViewController(bodyFatCalculatorVC!, animated: true)
            }
        }
        else if indexPath.item == 1{ // Height Predictor
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let babyHeightPredictor = storyBoard.instantiateViewController(withIdentifier: "BabyHeightPredictorFormId") as? BabyHeightPredictorForm
            
            if (navigationController?.topViewController is BabyHeightPredictorForm) {
                return
            } else {
                navigationController?.pushViewController(babyHeightPredictor!, animated: true)
            }
        }
        else if indexPath.item == 2{ // Baby Bumb Tracker
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let bbTrackerVC = storyBoard.instantiateViewController(withIdentifier: "BabyBumbTrackerMainVCId") as? BabyBumbTrackerMainVC
            
            if (navigationController?.topViewController is BabyBumbTrackerMainVC) {
                return
            } else {
                navigationController?.pushViewController(bbTrackerVC!, animated: true)
            }
        }
        else if indexPath.item == 3{ //Health Logs
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let healthLogsIntroVC = storyBoard.instantiateViewController(withIdentifier: "HealthLogsIntroScreenId") as? HealthLogsIntroScreen
            
            if (navigationController?.topViewController is HealthLogsIntroScreen) {
                return
            } else {
                navigationController?.pushViewController(healthLogsIntroVC!, animated: true)
            }
        }
        else if indexPath.item == 4{ // Symptom checker
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let symptomChecker = storyBoard.instantiateViewController(withIdentifier: "SymptomCheckerIntroScreenId") as? SymptomCheckerIntroScreen
            
            if (navigationController?.topViewController is SymptomCheckerIntroScreen) {
                return
            } else {
                navigationController?.pushViewController(symptomChecker!, animated: true)
            }
        }
         else if indexPath.item == 5{ //Calorie Counter
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let calorieCounterVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterIntroScreenId") as? CalorieCounterIntroScreen
            
            if (navigationController?.topViewController is CalorieCounterIntroScreen) {
                return
            } else {
                navigationController?.pushViewController(calorieCounterVC!, animated: true)
            }
        }
        
        else{
          //  print(indexPath.item)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    
        var cellSize: CGSize
    
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width - 30
    
        cellSize = CGSize(width: screenWidth / 2.0, height: 180)
    
        return cellSize
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
         return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    //MARK: Navigation Buttons
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func searchButtinClicked(_ sender: Any) {
        
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
