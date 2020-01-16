//
//  SymptomCheckerPossibleConditions.swift
//  VidalHealth
//
//  Created by mallikarjun on 25/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class SymptomCheckerPossibleConditions: UIViewController,UITableViewDelegate, UITableViewDataSource {
   

    var conditiosArray = ["Influenza (FLU) Adult", "Common cold", "Asthma (Teens Adult)", "Acne Sinusitis", "Viral Pneumonia"]
    var percentageArray = [60,30,87,76,51]
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return conditiosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell : SymptomsPossiblesCell = tableView.dequeueReusableCell(withIdentifier: "SymptomsPossiblesCellId", for: indexPath) as! SymptomsPossiblesCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        cell.possibleConditionLabel.text = conditiosArray[indexPath.row]
        cell.percentagesLabel.text = "\(percentageArray[indexPath.row])%"
        
        let percentageValue:Int = percentageArray[indexPath.row]
        
        let percentageInFloat = CGFloat(percentageValue)
        cell.progressViewOutlet.progress = Float(0.01 * percentageInFloat)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "SymptomDetailsScreenId") as? SymptomDetailsScreen
      // let nextVC = storyBoard.instantiateViewController(withIdentifier: "SymptomCheckerPossibleConditionDetailsId") as? SymptomCheckerPossibleConditionDetails
        navigationController?.pushViewController(nextVC!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }

    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
