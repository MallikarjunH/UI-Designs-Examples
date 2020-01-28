//
//  AuthorizationCoordinator+LoginViewControllerDelegate.swift
//  divco
//
//  Created by Irina Butaru on 22/08/2019.
//  Copyright © 2019 Irina Butaru. All rights reserved.
//

import Foundation

extension AuthCoordinator: LoginViewControllerDelegate {
    func didLogInSuccessfully(on viewController: LoginViewController) {
        self.baseViewController.dismiss(animated: true, completion: nil)
        delegate?.hide(self)
    }
}
