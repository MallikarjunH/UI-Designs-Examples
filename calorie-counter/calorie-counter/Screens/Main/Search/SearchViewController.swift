//
//  SearchViewController.swift
//  calorie-counter
//
//  Created by Sabin on 27/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import UIKit

extension SearchViewController: Storyboarded {
    static var storyboardName: String { return "Main"}
}

class SearchViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?

    @IBOutlet weak var searchTextField: JMSearchTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set navigation bar title
        self.title = "Search for Food"
    }
    
    @IBAction func toAddFood(_ sender: Any) {
        coordinator?.toAddFood()
    }
    
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        // Call viewModel method and pass searchTextField.text
    }
    
}
