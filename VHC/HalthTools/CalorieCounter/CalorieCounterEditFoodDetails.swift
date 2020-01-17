//
//  CalorieCounterEditFoodDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 09/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCounterEditFoodDetails: UIViewController,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterEditFoodDetailsCell1Id", for: indexPath) as! CalorieCounterEditFoodDetailsCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            return cell
        }
        else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterEditFoodDetailsCell2Id", for: indexPath) as! CalorieCounterEditFoodDetailsCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterEditFoodDetailsCell3Id", for: indexPath) as! CalorieCounterEditFoodDetailsCell3
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            
            return 92.0
        }
        else if indexPath.section == 1{
            
            return 60.0
        }else{
            
            return 260.0
        }
    }
    
    //MARK: TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addButtonClicked(_ sender: Any) { 
        
       /* let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterSearchToAddFoodId") as? CalorieCounterSearchToAddFood
        navigationController?.pushViewController(nextVC!, animated: true)
       */ //Edit Food Details
        
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterCalorieCalculatorId") as? CalorieCounterCalorieCalculator
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
}
