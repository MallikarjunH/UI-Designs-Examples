//
//  ContainerViewController.swift
//  divco
//
//  Created by Irina Butaru on 20/08/2019.
//  Copyright © 2019 Irina Butaru. All rights reserved.
//

import PromiseKit
import UIKit

typealias Contained = (viewController: UIViewController, coordinator: Coordinator?)

class ContainerViewController: UIViewController {
    private var currentViewController: UIViewController?
    private var nextViewControllers = [Contained]()

    convenience init(initialViewController viewController: UIViewController, coordinator: Coordinator? = nil) {
        self.init()
        self.addChild(viewController)
        viewController.view.frame = self.view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.willMove(toParent: self)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        viewController.view.alpha = 0.0

        if !self.nextViewControllers.isEmpty {
            self.nextViewControllers.append((viewController: viewController, coordinator: coordinator))
        } else {
            self.nextViewControllers.append((viewController: viewController, coordinator: coordinator))
            self.present(viewController)
        }
    }

    func `switch`(to viewController: UIViewController, coordinator: Coordinator?) {
        nextViewControllers = []

        self.addChild(viewController)
        viewController.view.frame = self.view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.willMove(toParent: self)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        if let currentViewController = self.currentViewController {
            currentViewController.willMove(toParent: nil)
            currentViewController.view.removeFromSuperview()
            currentViewController.didMove(toParent: nil)
            currentViewController.removeFromParent()
        }
        currentViewController = viewController

        coordinator?.start()
    }

    func show(_ viewController: UIViewController, coordinator: Coordinator?) {
        DispatchQueue.main.async {
            self.addChild(viewController)
            viewController.view.frame = self.view.frame
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            viewController.willMove(toParent: self)
            self.view.addSubview(viewController.view)
            viewController.didMove(toParent: self)

            viewController.view.alpha = 0.0

            if !self.nextViewControllers.isEmpty {
                self.nextViewControllers.append((viewController: viewController, coordinator: coordinator))
            } else {
                self.nextViewControllers.append((viewController: viewController, coordinator: coordinator))
                self.present(viewController, coordinator: coordinator)
            }
        }
    }
    private func present(_ viewController: UIViewController, coordinator: Coordinator? = nil) {
        if let currentViewController = self.currentViewController {
            UIView.promise(animateWithDuration: 0.7, delay: 0.0, options: .curveEaseInOut) {
                viewController.view.alpha = 1.0
                }.done(on: .main) { _ in
                    currentViewController.willMove(toParent: nil)
                    currentViewController.view.removeFromSuperview()
                    currentViewController.didMove(toParent: nil)
                    currentViewController.removeFromParent()
                    self.nextViewControllers.removeFirst()
                    coordinator?.start()
                    if let next = self.nextViewControllers.first {
                        self.present(next.viewController, coordinator: next.coordinator)
                    }
            }
        } else {
            viewController.view.alpha = 1.0
            self.nextViewControllers.removeFirst()
            if let next = self.nextViewControllers.first {
                self.present(next.viewController, coordinator: next.coordinator)
            }
        }
        self.currentViewController = viewController
    }
}

