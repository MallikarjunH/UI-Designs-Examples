//
//  AddFoodViewController.swift
//  calorie-counter
//
//  Created by Sabin on 27/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import UIKit

extension AddFoodViewController: Storyboarded {
    static var storyboardName: String { return "Main"}
}

class AddFoodViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // set navigation bar title
        self.title = "Add Food"
    }
    


}
