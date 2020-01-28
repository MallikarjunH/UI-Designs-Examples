//
//  AppCoordinator.swift
//  calorie-counter
//
//  Created by Sabin on 27/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import UIKit
import FirebaseAuth


class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var baseViewController: UIViewController { return container }
    var container: ContainerViewController
    
    init(container: ContainerViewController) {
        self.container = container
    }

    func start() {
        // logic auth/main
        let currentUser = Auth.auth().currentUser
        let isUserLoggedIn = currentUser != nil
        
        startingCoordinators(isUserLoggedIn)
    }
    
    func startingCoordinators(_ isUserLoggedIn: Bool) {
        if (isUserLoggedIn) {
            let mainCoordinator = MainCoordinator()
            self.childCoordinators.append(mainCoordinator)
            self.container.show(mainCoordinator.baseViewController, coordinator: mainCoordinator)
        } else {
            let authCoordinator = AuthCoordinator()
            authCoordinator.delegate = self
            self.childCoordinators.append(authCoordinator)
            self.container.show(authCoordinator.baseViewController, coordinator: authCoordinator)
        }
    }
    
}

extension AppCoordinator: ServerErrorPresenting, ErrorPresenting {}
