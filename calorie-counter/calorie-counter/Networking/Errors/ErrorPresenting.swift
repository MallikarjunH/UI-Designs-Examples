//
//  UnknownErrorPresenting.swift
//  divco
//
//  Created by Irina Butaru on 19/08/2019.
//  Copyright © 2019 Irina Butaru. All rights reserved.
//

import UIKit

protocol ErrorPresenting: class {
    
    func showGenericErrorAlert(on viewController: UIViewController)
    func showErrorAlert(withMessage: String, on viewController: UIViewController)
    func showNoTitleAlert(withMessage: String, on viewController: UIViewController)
}

extension ErrorPresenting {
    func showGenericErrorAlert(on viewController: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController.simpleAlert(title: "An error occurred",
                                                      message: "Please try again later.",
                                                      buttonTitle: "OK")
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func showErrorAlert(withMessage: String, on viewController: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController.simpleAlert(title: "An error occurred",
                                                      message: withMessage,
                                                      buttonTitle: "OK")
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func showNoTitleAlert(withMessage: String, on viewController: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController.simpleAlert(title:"",
                                                      message: withMessage,
                                                      buttonTitle: "OK")
            viewController.present(alert, animated: true, completion: nil)
        }
    }

}

