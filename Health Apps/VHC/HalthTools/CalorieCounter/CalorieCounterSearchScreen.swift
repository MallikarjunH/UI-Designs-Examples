//
//  CalorieCounterSearchScreen.swift
//  VidalHealth
//
//  Created by mallikarjun on 08/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit
import Alamofire

class CalorieCounterSearchScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var searchMainView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var backgroundDummyText: UILabel!
    @IBOutlet weak var backgroundDummyIng: UIImageView!
    
    var selectedFood:String = ""
    var sampleFoodArray = ["Apple", "Banana", "Eggs", "Watermelon", "Chicken", "Water", "Vegetables"]
    
    var searchResultArray1:[String] = []
    var searchResultArray = [" "]
    
    var ndbnoArray:[String] = []
    var ndbnoArray1:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchTableView.isHidden = true
        searchMainView.layer.cornerRadius = 3
        backgroundDummyText.isHidden = false
        backgroundDummyIng.isHidden = false
        backgroundDummyText.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        
    }

    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFoodInCalorieCounterCellId", for: indexPath) as! SearchFoodInCalorieCounterCell
        
        cell.foodMainLabel.text = self.searchResultArray[indexPath.row]
        cell.foodSubLabel.text = "1 Whole (35g)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedFood = searchResultArray[indexPath.row] //food name
        GlobalVariables.sharedManager.foodNdbno = ndbnoArray[indexPath.row]   //food id
        
        if !selectedFood.isEmpty{
            
            reloadView()
        }
        else{
            
        }
    }
    
    func reloadView(){
        
        DispatchQueue.main.async {
            self.searchTextField.text = self.selectedFood
            self.searchTableView.isHidden = true
            self.backgroundDummyIng.isHidden = true
            self.backgroundDummyText.isHidden = true
        }
    }
    
    //MARK: TextFeild Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.searchTableView.isHidden = true
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        backgroundDummyText.isHidden = true
        backgroundDummyIng.isHidden = true
        
     /*   if searchTextField.text!.count > 2{
             self.searchTableView.isHidden = false
        }else
        {
            self.searchTableView.isHidden = true
        } */
       
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            //print("Backspace was pressed")
            return true
        }
        
        if searchTextField.text!.count < 2{
        }
        else{
           // DispatchQueue.main.async {
                self.searchFoodItemAPICall(searchItem: self.searchTextField.text!)
                self.searchTableView.isHidden = false
           // }
        }
       
        
        return true
    }
    
    //MARK: Seach Food item API call
    func searchFoodItemAPICall(searchItem:String){
        
//        if searchTextField.text!.count < 3{
//            showAlert(message: "Please enter more than 2 characters", title: "Alert")
//        }else{
            //api call
            let searchSting2:String = searchTextField.text!
            let searchString = searchSting2.replacingOccurrences(of: " ", with: "%20")

            let url = "https://api.nal.usda.gov/ndb/search/"
            let params: [String: Any] = [
                "format": "json",
                "sort": "r",
                "max": 25,
                "offset": 0,
                "ds":"Standard Reference",
                "api_key": "qlpKRK9aLDnY9gRs58Wk47NUhEILw7RiCs8qFrYr",
                "q": searchString,
            ]
            
          /*  let headers: HTTPHeaders = [
                "token": "YOUR_TOKEN_HERE",
                "x-api-key": "YOUR_KEY_HERE"
            ] */
        
            let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
            manager.requestSerializer = AFJSONRequestSerializer()
            manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
            manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
          
            
         //   print(params)
            manager.get(url, parameters: params , progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
               
                if let jsonResponse = responseObject as? [String: Any] { //[String: AnyObject]
                
                    // var listJson = jsonResponse["list"] as? [String:Any]
                    // let itemArray = listJson["item"] as! [[String:Any]]
                    
                   // self.searchResultArray.removeAll()
                    
                    self.searchResultArray1.removeAll()
                    self.ndbnoArray1.removeAll()
                    
                    if let listJson = jsonResponse["list"] as? [String:Any]{
                        
                        let itemArray = listJson["item"] as! [[String:Any]]
                        
                        for foodDict:Dictionary<String,Any> in itemArray{
                            
                            let foodName:String = foodDict["name"] as! String
                            let foodNdbno:String = foodDict["ndbno"] as! String
                            print(foodName)
                            self.searchResultArray1.append(foodName)
                            self.ndbnoArray1.append(foodNdbno)
                            
                        }
                        
                        //self.searchResultArray = self.searchResultArray1
                        // self.searchTableView.reloadData()
                        
                        DispatchQueue.main.async {
                            self.searchResultArray.removeAll()
                            self.ndbnoArray.removeAll()
                            
                            self.searchResultArray = self.searchResultArray1
                            self.ndbnoArray = self.ndbnoArray1
                            
                            self.searchTableView.reloadData()
                        }
                        
                    }else{
                        //show error
                    }
                   
                    
                }
            }) { (task: URLSessionDataTask?, error: Error) in
                print("Unable to Fetch Search Details - API fails with error \(error)")
            }
            
            
       // }
    }
 
    
    //MARK: Alert
    func showAlert(message:String , title:String)
    {
        let alert: UIAlertController = UIAlertController.init(title:title, message:message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Navigatioin and Bottom Buttons
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
     /*   let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterEditFoodDetailsId") as? CalorieCounterEditFoodDetails
        navigationController?.pushViewController(nextVC!, animated: true) */
        
        if searchTextField.text == ""{
            showAlert(message: "Search field should not be empty", title: "Alert")
        }
        else{
            GlobalVariables.sharedManager.foodName = searchTextField.text!
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterFoodDetailsId") as? CalorieCounterFoodDetails
            navigationController?.pushViewController(nextVC!, animated: true)
        }
        
    }
    
}
