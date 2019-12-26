//
//  CalorieCounterFoodDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 11/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCounterFoodDetails: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var servingValue = 0

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getFoodDetailsAPICall()
        
    }
    
    //MARK: TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterFoodDetailsCell1Id", for: indexPath) as! CalorieCounterFoodDetailsCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            return cell
        }
        else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterFoodDetailsCell2Id", for: indexPath) as! CalorieCounterFoodDetailsCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            return cell
        }else if indexPath.section == 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterFoodDetailsCell3Id", for: indexPath) as! CalorieCounterFoodDetailsCell3
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            cell.plusButton.addTarget(self, action: #selector(plusButtonMethod(sender:)), for: .touchUpInside)
            cell.minusButton.addTarget(self, action: #selector(minusButtonMethod(sender:)), for: .touchUpInside)
            cell.servingValueLabel.text = "\(servingValue)"
            return cell
        }
        else if indexPath.section == 3{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterFoodDetailsCell4Id", for: indexPath) as! CalorieCounterFoodDetailsCell4
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterFoodDetailsCell5Id", for: indexPath) as! CalorieCounterFoodDetailsCell5
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            
            return 85.0
        }
        else if indexPath.section == 1{
            
            return 60.0
        }
        else if indexPath.section == 2{
            
            return 60.0
        }
        else if indexPath.section == 3{
            
            return 170.0
        }
        else{
            
             return 56.0
        }
    }
    
    
    @objc func plusButtonMethod(sender:UIButton){
      //  print("cliked in +")
        servingValue = servingValue + 1
        updateView()
    }
    
    @objc func minusButtonMethod(sender:UIButton){
       // print("cliked in -")
        if servingValue != 0{
             servingValue = servingValue  - 1
             updateView()
        }
        else{
            
        }
       
    }
    
    func updateView(){
        
         DispatchQueue.main.async {
          self.mainTableView.reloadData()
        }
    }
    
    
    //MARK: Get Food Details API Call
    func getFoodDetailsAPICall(){
        
       let url = "https://api.nal.usda.gov/ndb/reports/"
        let params: [String: Any] = [
            "format": "json",
            "ndbno": GlobalVariables.sharedManager.foodNdbno,
            "type": "b",  //b or f2
            "api_key": "qlpKRK9aLDnY9gRs58Wk47NUhEILw7RiCs8qFrYr",
        ]
        
      /*  let nutrientsArray = [203,204,205]
        
        let url = "https://api.nal.usda.gov/ndb/nutrients/"
        let params: [String: Any] = [
            "format": "json",
            "ndbno": GlobalVariables.sharedManager.foodNdbno,
            "api_key": "qlpKRK9aLDnY9gRs58Wk47NUhEILw7RiCs8qFrYr",
            "nutrients": nutrientsArray,
        ] */
        
        
        
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")

    
        manager.get(url, parameters: params , progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            
            if let jsonResponse = responseObject as? [String: Any] { //[String: AnyObject]
        
               /*  if let reportJson = jsonResponse["report"] as? [String:Any]{
                 let foodArray = reportJson["foods"] as! [[String:Any]]
                 let foodDict:Dictionary<String,Any> = foodArray[0]
                 let nutrientsArray = foodDict["nutrients"] as! [[String:Any]]
                 print(nutrientsArray) */
                    
                
                 if let reportJson = jsonResponse["report"] as? [String:Any]{
                 let foodJson = reportJson["food"] as! [String:Any]
                    
                 let nutrientsArray = foodJson["nutrients"] as! [[String:Any]]
                 print(nutrientsArray)
                    
                   for foodDict:Dictionary<String,Any> in nutrientsArray{
                        
                    if let nutrientsId:String = foodDict["nutrient_id"] as? String { //Protein
 
                        if nutrientsId == "203"{
                            
                            print("1000000")
                        }
                    }
                    
                    }
                    
                    DispatchQueue.main.async {
                        //self.searchTableView.reloadData()
                    }
                    
                }else{
                    //show error
                }
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("Unable to Fetch Food Details - API fails with error \(error)")
        }
        
        
    }
    
    //MARK: Bottom and Navigation Buttons
    @IBAction func okButtonClicked(_ sender: Any) {
    
        let allViewControllers = navigationController?.viewControllers
        for aViewController in allViewControllers ?? [] {
            if (aViewController is CalorieCounterCalorieCalculator) {
                navigationController?.popToViewController(aViewController, animated: true)
            }
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
