//
//  CalorieCalculator_Breakfast_View.swift
//  VidalHealth
//
//  Created by mallikarjun on 11/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCalculator_Breakfast_View: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let foodItemNames = ["Apple", "Banana", "Poha", "Idali", "Dosa", "Carrots","Pinaple"]
    let foodQty = ["1 Whole", "2 Whole", "1 Plate", "4 Whole", "1 Whole", "4 Pieces","3 Pieces"]
    let foodCalory = ["25 Cal", "88 Cal", "17 Cal", "132 Cal", "98 Cal", "13 Cal","154 Cal"]
    
    @IBOutlet weak var mainTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return foodItemNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCalculatorFoodTypeCellId", for: indexPath) as! CalorieCalculatorFoodTypeCell
       
         cell.selectionStyle = UITableViewCellSelectionStyle.none;
         cell.foodTypeNameLabel.text = foodItemNames[indexPath.row]
         cell.foodTypeQauntityLabel.text = foodQty[indexPath.row]
         cell.foodCalorieCountLabel.text = foodCalory[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90.0
    }



}
