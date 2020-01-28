//
//  AppCoordinator+AuthCoordinatorDelegate.swift
//  calorie-counter
//
//  Created by Sabin on 27/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import Foundation

extension AppCoordinator: AuthCoordinatorDelegate {
    func hide(_ coordinator: AuthCoordinator) {
        let mainCoordinator = MainCoordinator()
        childCoordinators.remove(at: 0) // remove Auth Coordinator
        childCoordinators.append(mainCoordinator)
        container.show(mainCoordinator.baseViewController, coordinator: mainCoordinator)
    }
    
    
}
