//
//  AppDelegate+Container.swift
//  calorie-counter
//
//  Created by Sabin on 27/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import UIKit

extension AppDelegate {
    func setupContainer() {
        let container = ContainerViewController()
        
        coordinator = AppCoordinator(container: container)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = container
        window?.makeKeyAndVisible()
    }
}
