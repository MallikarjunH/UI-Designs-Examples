//
//  OverviewController.swift
//  calorie-counter
//
//  Created by Sabin on 22/08/2019.
//  Copyright © 2019 Sabin. All rights reserved.
//

import UIKit
import FirebaseAuth

extension OverviewViewController: Storyboarded {
    static var storyboardName: String { return "Main"}
}

class OverviewViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set navigation bar title
        self.title = "Overview"
        
    }

    @IBAction func signOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
        } catch let err {
            print(err)
        }
    }
    
    @IBAction func toSearch(_ sender: Any) {
        coordinator?.toSearch()
    }
}
