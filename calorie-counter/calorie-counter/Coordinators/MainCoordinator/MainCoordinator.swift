//
//  MainCoordinator.swift
//  calorie-counter
//
//  Created by Sabin on 22/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var baseViewController: UIViewController { return navigationController}
    
    let navigationController: UINavigationController
    
    init() {
        let overviewVC = OverviewViewController.instantiate()
        navigationController = UINavigationController(rootViewController: overviewVC)
        overviewVC.coordinator = self
    }
    
    func start() {
    }
    
    func toSearch() {
        let searchVC = SearchViewController.instantiate()
        navigationController.pushViewController(searchVC, animated: true)
        searchVC.coordinator = self
    }
    
    func toAddFood() {
        let addFoodVC = AddFoodViewController.instantiate()
        navigationController.pushViewController(addFoodVC, animated: true)
        
        addFoodVC.coordinator = self
    }
    
}
