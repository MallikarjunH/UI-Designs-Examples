////
////  BodyFatCalculatorResult.swift
////  Body Fat Calculator
////
////  Created by mallikarjun on 21/06/19.
////  Copyright © 2019 Mallikarjun H. All rights reserved.
////
//
//import UIKit
//
//import UIKit
//
//class BodyFatCalculatorResult: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    
//    @IBOutlet weak var mainTableView: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.mainTableView!.tableFooterView = UIView()
//        mainTableView.allowsSelection = false
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        
//        return 3
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if(indexPath.section == 0){
//            
//            let cell : BodyFatCalculatorResultCell1 = tableView.dequeueReusableCell(withIdentifier: "BodyFatCalculatorResultCell1Id", for: indexPath) as! BodyFatCalculatorResultCell1
//            
//            return cell
//        }
//        else if(indexPath.section == 1){
//            
//            let cell : BodyFatCalculatorResultCell2 = tableView.dequeueReusableCell(withIdentifier: "BodyFatCalculatorResultCell2Id", for: indexPath) as! BodyFatCalculatorResultCell2
//            
//            return cell
//        }
//        else {
//            
//            let cell : BodyFatCalculatorResultCell3 = tableView.dequeueReusableCell(withIdentifier: "BodyFatCalculatorResultCell3Id", for: indexPath) as! BodyFatCalculatorResultCell3
//            
//            return cell
//            
//        }
//        
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        var height:CGFloat = CGFloat()
//        if indexPath.section == 0 {
//            mainTableView.rowHeight = 180
//            height = mainTableView.rowHeight
//        }
//        else if indexPath.section  == 1 {
//            mainTableView.rowHeight = UITableViewAutomaticDimension
//            height =  mainTableView.rowHeight
//        }
//        else {
//            mainTableView.rowHeight = 297
//            height =  mainTableView.rowHeight
//        }
//        
//        return height
//    }
//    
//    @IBAction func backButtonClicked(_ sender: Any) {
//        
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    
//    @IBAction func searchButtonClicked(_ sender: Any) {
//        
//    }
//    
//    
//    @IBAction func notiificationButtonClicked(_ sender: Any) {
//        
//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let notificationVC = storyBoard.instantiateViewController(withIdentifier: "Notifications") as! Notifications
//        if ((self.navigationController?.topViewController?.isKind(of: Notifications.classForCoder()))!) {
//            return
//        } else {
//            self.navigationController?.pushViewController(notificationVC, animated: true)
//        }
//        
//    }
//    
//    
//    @IBAction func callButtonClicked(_ sender: Any) {
//        
//        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
//        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
//        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
//            return
//        } else {
//            self.navigationController?.pushViewController(emergencyVC, animated: true)
//        }
//        
//    }
//    
//    
//}
