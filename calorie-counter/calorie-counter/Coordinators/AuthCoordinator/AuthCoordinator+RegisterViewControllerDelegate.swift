//
//  AuthCoordinator+RegisterViewController.swift
//  calorie-counter
//
//  Created by Sabin on 27/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import Foundation

extension AuthCoordinator: RegisterViewControllerDelegate {
    func didSignUpSuccessfully(on viewController: RegisterViewController) {
        self.baseViewController.dismiss(animated: true, completion: nil)
        delegate?.hide(self)
    }
}
