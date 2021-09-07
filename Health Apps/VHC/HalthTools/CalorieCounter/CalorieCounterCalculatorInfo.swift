//
//  CalorieCounterCalculatorInfo.swift
//  VidalHealth
//
//  Created by mallikarjun on 08/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCounterCalculatorInfo: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterCalculatorInfoCellId", for: indexPath) as! CalorieCounterCalculatorInfoCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 300.0
    }
    
    //MARK: Navigation Buttons
    @IBAction func backButtonClicked(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func nextVCClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterSearchScreenId") as? CalorieCounterSearchScreen
        self.navigationController?.pushViewController(detailsVC!, animated: true)
        
    }
    
}
