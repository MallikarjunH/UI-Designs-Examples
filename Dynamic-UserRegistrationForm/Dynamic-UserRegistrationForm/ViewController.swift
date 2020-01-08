//
//  ViewController.swift
//  Dynamic-UserRegistrationForm
//
//  Created by mallikarjun on 08/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var i = 1
    var y = 136
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.manageLabel()
        self.manageTextField()
    }

    //MARK: Function for Creating TextField
    
    func manageTextField(){
        
        for i in 1...5{
            
            let myTextField: UITextField = UITextField(frame: CGRect(x: 23, y: y, width: 340, height: 30))
            myTextField.borderStyle = .roundedRect
            self.view.addSubview(myTextField)
            
            y = y + 52
            
            if i == 1{
                myTextField.placeholder = "First Name"
                myTextField.tag = 1
            }
            else if i == 2{
                myTextField.placeholder = "Last Name"
                myTextField.tag = 2
            }
            else if i == 3{
                myTextField.placeholder = "Email"
                myTextField.tag = 3
            }
            else if i == 4{
                myTextField.placeholder = "Job Role"
                myTextField.tag = 4
            }
            else if i == 5{
                myTextField.placeholder = "Experience"
                myTextField.tag = 5
            }
        }
        
    }
    
    //MARK: Function for creating Label
    
    func manageLabel(){
        
        let myLabel:UILabel = UILabel(frame: CGRect(x: 16, y: 80, width: 343, height: 22))
        myLabel.text = "Registration Form"
        myLabel.textAlignment = .center
        myLabel.textColor = UIColor.black
        
        self.view.addSubview(myLabel)
    }
     
    
}

