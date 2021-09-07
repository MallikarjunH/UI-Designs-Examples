//
//  CalorieCounterCalorieCalculator.swift
//  VidalHealth
//
//  Created by mallikarjun on 10/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCounterCalorieCalculator: UIViewController {

    var progressPercentageValue = 0.0
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var calorieProgressView: UIProgressView!
    @IBOutlet weak var caloriValueLabel: UILabel!
    
    @IBOutlet weak var carbValueLabel: UILabel!
    @IBOutlet weak var fatValueLabel: UILabel!
    @IBOutlet weak var proteinValueLabel: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainCardView.layer.cornerRadius = 5
        
        self.calorieProgressView.progress = Float(0.7)
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        calorieProgressView.transform = transform
        calorieProgressView.clipsToBounds = true
        calorieProgressView.layer.cornerRadius = 3

    }
    
    

    @IBAction func plusButtonClicked(_ sender: Any) {
        
     /*   let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterFoodDetailsId") as? CalorieCounterFoodDetails
        navigationController?.pushViewController(nextVC!, animated: true) */
        
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterSearchScreenId") as? CalorieCounterSearchScreen
        self.navigationController?.pushViewController(detailsVC!, animated: true)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
}
