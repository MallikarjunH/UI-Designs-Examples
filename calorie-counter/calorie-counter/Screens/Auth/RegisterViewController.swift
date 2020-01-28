//
//  RegisterController.swift
//  calorie-counter
//
//  Created by Sabin on 22/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol RegisterViewControllerDelegate {
    func didSignUpSuccessfully(on viewController: RegisterViewController)
}

extension RegisterViewController: Storyboarded {
    static var storyboardName: String { return "Auth"}
}

class RegisterViewController: UIViewController {
    
    weak var coordinator: AuthCoordinator?
    weak var navigationDelegate: (RegisterViewControllerDelegate & ErrorAlert)?

    @IBOutlet weak var emailField: JMAuthTextField!
    @IBOutlet weak var passwordField: JMAuthTextField!
    @IBOutlet weak var confirmPasswordField: JMAuthTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // Actions
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        if let emailText = emailField.text,
        let passwordText = passwordField.text,
        let confirmPasswordText = confirmPasswordField.text {
            if !emailText.isValidEmail() {
                emailError()
                return
            }
            if passwordText != confirmPasswordText {
                passwordError()
                return
            }
            registerUser(email: emailText, password: passwordText)
        }
    }
    
    // Firebase Register
    
    private func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.registerError()
                return
            }
        }
        
        // Sign Up Succes => go to main
        navigationDelegate?.didSignUpSuccessfully(on: self)
        
    }
    
    
    private func passwordError() {
        navigationDelegate?.showNoTitleAlert(withMessage: "Passwords doesn't match", on: self)
    }
    
    private func emailError() {
        navigationDelegate?.showNoTitleAlert(withMessage: "Email is not valid", on: self)
    }
    
    private func registerError() {
        navigationDelegate?.showNoTitleAlert(withMessage: "Something went wrong", on: self)
    }
}
