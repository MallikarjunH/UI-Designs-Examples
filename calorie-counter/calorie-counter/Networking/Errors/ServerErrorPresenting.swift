//
//  ServerErrorPresenting.swift
//  divco
//
//  Created by Irina Butaru on 19/08/2019.
//  Copyright © 2019 Irina Butaru. All rights reserved.
//

import UIKit

protocol ServerErrorPresenting: class {
    func showAlert(error: ServerError)
    func showAlert(error: ServerError, on viewController: UIViewController)
}

extension ServerErrorPresenting {
    func showAlert(error: ServerError, on viewController: UIViewController) {
        DispatchQueue.main.async {
            let message: String = {
                if let message = error.serverMesssage {
                    return message
                } else {
                    return "Please try again later."
                }
            }()
            let alert = UIAlertController.simpleAlert(title: "An error occurred",
                                                      message: message,
                                                      buttonTitle: "OK")
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
