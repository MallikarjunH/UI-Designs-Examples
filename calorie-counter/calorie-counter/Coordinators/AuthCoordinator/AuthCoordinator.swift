//
//  AuthCoordinator.swift
//  calorie-counter
//
//  Created by Sabin on 22/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import Foundation
import UIKit

protocol AuthCoordinatorDelegate: class {
    func hide(_ coordinator: AuthCoordinator)
}

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    weak var delegate: AuthCoordinatorDelegate?
    var baseViewController: UIViewController { return navigationController }
    
    let navigationController: UINavigationController
    
    init() {
        let loginVC = LoginViewController.instantiate()
        navigationController = UINavigationController(rootViewController: loginVC)
        loginVC.navigationDelegate = self
        loginVC.coordinator = self
    }
    
    func start() {
    }

    func toRegister() {
        let registerVC = RegisterViewController.instantiate()
        navigationController.pushViewController(registerVC, animated: true)
        registerVC.navigationDelegate = self
    }
    
}
