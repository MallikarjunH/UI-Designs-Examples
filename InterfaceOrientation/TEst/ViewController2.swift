//
//  ViewController2.swift
//  TEst
//
//  Created by EOO61 on 23/12/20.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }

    override var shouldAutorotate: Bool {
        return true
    }
   
    
    @IBAction func backButtonClicked(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}

/*
if UIDevice.current.orientation.isLandscape {

    } else if UIDevice.current.orientation.isFlat {

    } else if UIDevice.current.orientation.isPortrait {

    } else if UIDevice.current.orientation.isValidInterfaceOrientation {

    }
 
 //UIDevice.currentDevice().orientation
*/
