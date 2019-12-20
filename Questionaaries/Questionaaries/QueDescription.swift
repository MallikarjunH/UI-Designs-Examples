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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Index is: \(indexValue)")
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
