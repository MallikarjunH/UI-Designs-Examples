//
//  ViewController.swift
//  TEst
//
//  Created by EOO61 on 23/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //UIInterfaceOrientation.landscapeLeft.rawValue
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    override var shouldAutorotate: Bool {
        return true
    }
}

