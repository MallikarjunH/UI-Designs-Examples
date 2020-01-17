//
//  CalorieCounterOptions.swift
//  VidalHealth
//
//  Created by mallikarjun on 08/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCounterOptions: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
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
         
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterOptionsCell1Id", for: indexPath) as! CalorieCounterOptionsCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            cell.caloryLabel.text = "\(GlobalVariables.sharedManager.bmrValue) cal/day"
            return cell
        }
        else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterOptionsCell2Id", for: indexPath) as! CalorieCounterOptionsCell2
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterOptionsCell3Id", for: indexPath) as! CalorieCounterOptionsCell3
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if indexPath.section == 0{
            //do nothing
        }
        else if indexPath.section == 1{
    
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let detailsVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterSearchScreenId") as? CalorieCounterSearchScreen
            self.navigationController?.pushViewController(detailsVC!, animated: true)
            
        } else{
            //move to my daily cout
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterCalorieCalculatorId") as? CalorieCounterCalorieCalculator
            navigationController?.pushViewController(nextVC!, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            
            return 210.0
        }else{
            
            return 120.0
        }
    }
    
    
    //MARK: Navigation Item Buttons
    @IBAction func backButtonClicked(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
    

}
