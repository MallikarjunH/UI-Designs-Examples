//
//  ViewController.swift
//  Material-Showcase-SpotLightExample
//
//  Created by EOO61 on 01/04/21.
//

import UIKit
import MaterialShowcase

class ViewController: UIViewController,MaterialShowcaseDelegate {

    @IBOutlet weak var sideMenuLeftButton: UIBarButtonItem!

    @IBOutlet weak var dashboardButton: UIButton!
    @IBOutlet weak var dashboardButton2: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var uploadButton2: UIButton!
    
    @IBOutlet weak var selectFormButton: UIButton!
    @IBOutlet weak var selectFormButton3: UIButton!
    
    var sequence = MaterialShowcaseSequence()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
      /*  let showcase2 = MaterialShowcase()
        //showcase2.setTargetView(button: dashboardButton, tapThrough: false)
        showcase2.setTargetView(button: dashboardButton2, tapThrough: false)
        showcase2.primaryText = "Action 1"
        showcase2.secondaryText = "Click here to go into details"
        showcase2.show(completion: {
            // You can save showcase state here
            // Later you can check and do not show it again
            print("Action 1 completed")
        }) */
        
        let showcase1 = MaterialShowcase()
        showcase1.setTargetView(button: dashboardButton2, tapThrough: false)
        showcase1.primaryText = "Action 1"
        showcase1.secondaryText = "Click here to go into details"
        showcase1.shouldSetTintColor = false // It should be set to false when button uses image.
        showcase1.backgroundPromptColor = UIColor.blue
        showcase1.isTapRecognizerForTargetView = true
        
        let showcase2 = MaterialShowcase()
        showcase2.setTargetView(button: uploadButton2, tapThrough: false)
        showcase2.primaryText = "Action 1.1"
        showcase2.secondaryText = "Click here to go into details"
        showcase2.isTapRecognizerForTargetView = true
        
        let showcase3 = MaterialShowcase()
        showcase3.setTargetView(button: selectFormButton3, tapThrough: false)
        showcase3.primaryText = "Action 3"
        showcase3.secondaryText = "Click here to go into details"
        showcase3.isTapRecognizerForTargetView = false
        
        let showcase4 = MaterialShowcase()
        showcase4.setTargetView(barButtonItem: sideMenuLeftButton)
        showcase4.primaryText = "Action 4"
        showcase4.secondaryText = "Click here to go into details"
        showcase4.isTapRecognizerForTargetView = false
        
        showcase1.delegate = self
        showcase2.delegate = self
        showcase3.delegate = self
        showcase4.delegate = self
        
        // With one key, the showcase sequence only shows one time
        // So, for this demo, it is better to create a random key
        let oneTimeKey = UUID().uuidString
        sequence.temp(showcase1).temp(showcase2).temp(showcase3).temp(showcase4).setKey(key: oneTimeKey).start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
      sequence.showCaseWillDismis()
    }
}
