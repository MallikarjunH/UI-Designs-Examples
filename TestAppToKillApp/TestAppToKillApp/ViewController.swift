//
//  ViewController.swift
//  TestAppToKillApp
//
//  Created by EOO61 on 11/06/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func exitAppFunction(_ sender: Any) {
        
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            sleep(2)
            exit(0)
    }
    
}

