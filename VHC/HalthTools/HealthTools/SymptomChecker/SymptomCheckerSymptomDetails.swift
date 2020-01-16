//
//  SymptomCheckerSymptomDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 25/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class SymptomCheckerSymptomDetails: UIViewController,UITableViewDataSource, UITableViewDelegate {
   
    
    var selectedRowNumber = 100
    var isAnyOptionIsSelected = false
    
    @IBOutlet weak var symptomName: UILabel!

    @IBOutlet weak var skipButtonOutlet: UIButton!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var symptomDetailsOptionsArray = ["Fever below 104f","Fever 103 to 104f","Melanoma","Recurring Fever","Cinstant fever with varrying temperatures"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        symptomName.text = "Fever" //NavigationBar Label Name
        
        skipButtonOutlet.backgroundColor = UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
        addButtonOutlet.backgroundColor = UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }
        else{
            return symptomDetailsOptionsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell: SymptomCheckerSymptomDetailsCell1 = tableView.dequeueReusableCell(withIdentifier: "SymptomCheckerSymptomDetailsCell1Id", for: indexPath) as! SymptomCheckerSymptomDetailsCell1
            
            cell.symptomQuestionLabel.text = "What kind of Typhoid Fever?"

            return cell
        }
        else{
            
            let cell: SymptomCheckerSymptomDetailsCell2 = tableView.dequeueReusableCell(withIdentifier: "SymptomCheckerSymptomDetailsCell2Id", for: indexPath) as! SymptomCheckerSymptomDetailsCell2
           
            cell.symptomsDetailsOptionLabel.text = symptomDetailsOptionsArray[indexPath.row]
            
            if indexPath.row == selectedRowNumber {
                    cell.symptomRadioImage.image = UIImage(named: "Radiobutton_On")
                    addButtonOutlet.backgroundColor =  UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
            }else {
                   cell.symptomRadioImage.image = UIImage(named: "Radiobutton_Off")
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        //  print("Selected Item is: \(symptomDetailsOptionsArray[indexPath.row])")
        isAnyOptionIsSelected = true
        selectedRowNumber = indexPath.row
        self.reload()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       
       //  print("De-selected Item is: \(symptomDetailsOptionsArray[indexPath.row])")
         self.reload()
    }
    
    func reload(){
        
        DispatchQueue.main.async{
            self.mainTableView.reloadData()
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func skipButtonClickAction(_ sender: Any) {
        //naviagte to some screen
    }
    
    @IBAction func addButtonClickAction(_ sender: Any) {
        
        if isAnyOptionIsSelected{
           // print("Perform any - after clicking on Add Button")
            
            let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
            // for moving to PossibleConditions VC
           //   let nextVC = storyBoard.instantiateViewController(withIdentifier: "SymptomCheckerPossibleConditionsId") as? SymptomCheckerPossibleConditions
            
            // for moving to SymptomQuestions VC
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "SymptomCheckerSymptomQuestionsId") as? SymptomCheckerSymptomQuestions

            navigationController?.pushViewController(nextVC!, animated: true)
            
        }else{
            // print("Show an alert that ...first select an any option")
            showAlert(message: "Please choose any one option", title: "Alert")
            
        }
    }
    
    func showAlert(message:String , title:String)
    {
        let alert: UIAlertController = UIAlertController.init(title:title, message:message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
