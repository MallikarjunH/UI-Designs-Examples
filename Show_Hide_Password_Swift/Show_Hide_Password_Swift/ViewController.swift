//
//  ViewController.swift
//  Show_Hide_Password_Swift
//
//  Created by mallikarjun on 09/09/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UILabel!
  
    @IBOutlet weak var passwordTextField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let hideShow = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        hideShow.setImage(UIImage(named: "show"), for: .normal)
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = hideShow
        passwordTextField.rightViewMode = .always
        hideShow.addTarget(self, action: #selector(hideShow(_:)), for: .touchUpInside)
        
    }

    
    @objc func hideShow(_ sender: Any?) {
        let hideShow = passwordTextField.rightView as? UIButton
        
        if !passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = true
            hideShow?.setImage(UIImage(named: "show"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = false
            hideShow?.setImage(UIImage(named: "hide"), for: .normal)
        }
        passwordTextField.becomeFirstResponder()
    }

    
    @IBAction func loginButtonClicked(_ sender: Any) {

        print("Login Button Clicked")
        //API call
    
    }
    
}

