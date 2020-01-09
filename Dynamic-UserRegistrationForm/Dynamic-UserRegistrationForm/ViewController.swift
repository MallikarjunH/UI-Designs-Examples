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
        self.manageButton()
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
     
    //MARK: Function for creating Button
    
    func manageButton(){
        
        let myButton:UIButton = UIButton(frame: CGRect(x: 141, y: 430, width: 105, height: 30))
        myButton.setTitle("Register", for: .normal)
        myButton.setTitleColor(#colorLiteral(red: 0.05951015346, green: 0.9978423367, blue: 1, alpha: 1), for: .normal)
        myButton.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        myButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        self.view.addSubview(myButton)
    }
    
    @objc func registerButtonClicked(){
        
        print("Clicked on Register Button")
    }
    
}

