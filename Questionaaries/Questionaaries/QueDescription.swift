//
//  QueDescription.swift
//  Questionaaries
//
//  Created by mallikarjun on 20/12/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class QueDescription: UIViewController, UITextFieldDelegate {

    var indexValue:String = ""
    
    @IBOutlet weak var nameOfMedicationTextField: UITextField!
    @IBOutlet weak var coureseDecriptionTextField: UITextField!
    @IBOutlet weak var courseDurationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Index is: \(indexValue)")
    }
    
    
    //MARK: Save button clicked
    @IBAction func saveButtonClicked(_ sender: Any) {
   
        let dataAnsDict:[String:String] = ["medication_name":nameOfMedicationTextField.text!, "medication_description":coureseDecriptionTextField.text!,"medication_description":courseDurationTextField.text!]
        
        
    }
    
    //MARK: TextField Delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    

}
