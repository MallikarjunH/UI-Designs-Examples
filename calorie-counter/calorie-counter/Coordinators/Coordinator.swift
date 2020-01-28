//
//  Coordinator.swift
//  calorie-counter
//
//  Created by Sabin on 22/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import UIKit

typealias ErrorAlert = ErrorPresenting & ServerErrorPresenting

protocol Coordinator: ErrorAlert {
    var childCoordinators: [Coordinator] { get set }
    var baseViewController: UIViewController { get }
    
    func kill(_ coordinator: Coordinator)
    
    func start()
}

extension Coordinator {
    func kill(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

extension Coordinator {
    func showUnknownErrorAlert() {
        showGenericErrorAlert(on: baseViewController)
    }
    func showAlert(error: ServerError) {
        showAlert(error: error, on: baseViewController)
    }
    
}
