//
//  LoginController.swift
//  calorie-counter
//
//  Created by Sabin on 21/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol LoginViewControllerDelegate {
    func didLogInSuccessfully(on viewController: LoginViewController)
}

extension LoginViewController: Storyboarded {
    static var storyboardName: String { return "Auth"}
}

class LoginViewController: UIViewController {

    weak var navigationDelegate: (LoginViewControllerDelegate & ErrorAlert)?
    weak var coordinator: AuthCoordinator?
    
    @IBOutlet weak var emailField: JMAuthTextField!
    @IBOutlet weak var passwordField: JMAuthTextField!
    @IBOutlet weak var toRegisterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initToRegisterLabelInteraction()
    }
    
    
    // Actions
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if let emailText = emailField.text,
            let passwordText = passwordField.text {
            signInFirebase(email: emailText, password: passwordText)
        }
        
    }
    
    @objc func toRegisterLabelTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        coordinator?.toRegister()
        
    }
    
    // Firebase Sign In
    
    private func signInFirebase(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed to sign user in with error: ", error.localizedDescription)
                self.signInError()
                return
            }
            // Sign In SUCCES
            // Move to Main Storyboard
            self.navigationDelegate?.didLogInSuccessfully(on: self)
            
        }
    }
    
    private func signInError() {
//        navigationDelegate?.showErrorAlert(withMessage: "Bad Credentials", on: self)
        navigationDelegate?.showNoTitleAlert(withMessage: "Bad Credentials", on: self)
        
    }
    
    // Init
    
    private func initToRegisterLabelInteraction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toRegisterLabelTapped(tapGestureRecognizer:)))
        toRegisterLabel.isUserInteractionEnabled = true
        toRegisterLabel.addGestureRecognizer(tapGesture)
    }
    
}
