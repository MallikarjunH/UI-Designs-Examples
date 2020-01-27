//
//  TestQuesions.swift
//  VidalHealth
//
//  Created by mallikarjun on 18/12/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class TestQuesions: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
   

}
