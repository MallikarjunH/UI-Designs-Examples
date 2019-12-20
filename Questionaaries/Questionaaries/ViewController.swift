//
//  ViewController.swift
//  Questionaaries
//
//  Created by mallikarjun on 20/12/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var yesButtonOutlet: UIButton!
    @IBOutlet weak var noButtonOutlet: UIButton!
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var questionIndex = 0
    
    let arrayOfQuestions = ["Are you currently taking any medications?", "Do you have any allergies?", "Do you have diabetes, hypertension or other conditions?","Have you been hospitalised for any surgery or ailment before?", "Have you had any other significant health issues in the past?", "Do you smoke cigarettes?","Do you consume alcohol?", "Does anyone in your family have a previous history of diabetes, high blood pressure, heart disease?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainTableView.isHidden = true
        questionLabel.text = arrayOfQuestions[questionIndex]
        
    }
    

    @IBAction func yesButtonClicked(_ sender: Any) {
    
        //naviagate to the add descriptions VC
    }
    
    @IBAction func noButtonClicked(_ sender: Any) {
        questionIndex = questionIndex + 1
        
        //questionLabel.text = arrayOfQuestions[questionIndex]
        
       /* for (index, que) in arrayOfQuestions.enumerated() {

          // print("Question \(index): \(que)")
        } */
        
        updateQuestion(indexQue: questionIndex)
    }
    
    func updateQuestion(indexQue: Int){
        
        DispatchQueue.main.async {
            
            self.questionLabel.text = self.arrayOfQuestions[indexQue]
        }
    }
    
    
}

