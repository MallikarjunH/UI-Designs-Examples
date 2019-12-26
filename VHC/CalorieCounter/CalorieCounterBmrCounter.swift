//
//  CalorieCounterBmrCounter.swift
//  VidalHealth
//
//  Created by mallikarjun on 08/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCounterBmrCounter: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var mainTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: TableView Mwthods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
           let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterBmrCounterCell1Id", for: indexPath) as! CalorieCounterBmrCounterCell1
            cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
            cell.caloryLabel.text = "\(GlobalVariables.sharedManager.bmrValue) cal/day"
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterBmrCounterCell2Id", for: indexPath) as! CalorieCounterBmrCounterCell2
             cell.selectionStyle = UITableViewCellSelectionStyle.none;
            
           // cell.tipDescriptionLabel.text = ""
            return cell
        }
    }

    
    //MAR: Nivigation and Botton buttons
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterOptionsId") as? CalorieCounterOptions
        self.navigationController?.pushViewController(detailsVC!, animated: true)
        
    }
    
}
