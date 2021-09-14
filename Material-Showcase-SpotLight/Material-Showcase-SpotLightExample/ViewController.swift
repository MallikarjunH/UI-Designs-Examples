//
//  ViewController.swift
//  Material-Showcase-SpotLightExample
//
//  Created by EOO61 on 01/04/21.
//

/* //Other Exampples
https://github.com/aromajoin/material-showcase-ios
https://github.com/yukiasai/Gecco
https://github.com/aleksandrshoshiashvili/AwesomeSpotlightView
*/


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
    
    
    @IBOutlet weak var mySignatureView: UIView!
    @IBOutlet weak var waitingForOtherView: UIView!
    @IBOutlet weak var declinedView: UIView!
    @IBOutlet weak var recalledView: UIView!
    @IBOutlet weak var completedView: UIView!
    
    var sequence = MaterialShowcaseSequence()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mySignatureView.layer.cornerRadius = 5
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
        //showcase1.setTargetView(button: mySignatureButton, tapThrough: false)
        showcase1.setTargetView(view: mySignatureView)
        showcase1.primaryText = "Action 1"
        showcase1.secondaryText = "Click here to go check My Signature documents"
        showcase1.shouldSetTintColor = false // It should be set to false when button uses image.
        showcase1.backgroundPromptColor = UIColor.blue
        showcase1.isTapRecognizerForTargetView = true
        
        let showcase2 = MaterialShowcase()
       // showcase2.setTargetView(button: waitingForOthersButton, tapThrough: false)
        showcase2.setTargetView(view: waitingForOtherView)
        showcase2.primaryText = "Action 2"
        showcase2.secondaryText = "Click here to go Waiting for others documents details"
        showcase2.shouldSetTintColor = false // It should be set to false when button uses image.
        showcase2.backgroundPromptColor = UIColor.blue
        showcase2.isTapRecognizerForTargetView = true
        
        let showcase3 = MaterialShowcase()
       // showcase3.setTargetView(button: declineButton, tapThrough: false)
        showcase3.setTargetView(view: declinedView)
        showcase3.primaryText = "Action 3"
        showcase3.secondaryText = "Click here to go Declined documents details"
        showcase3.shouldSetTintColor = false // It should be set to false when button uses image.
        showcase3.backgroundPromptColor = UIColor.blue
        showcase3.isTapRecognizerForTargetView = true
        
        let showcase4 = MaterialShowcase()
        //showcase4.setTargetView(button: recalledButton, tapThrough: false)
        showcase4.setTargetView(view: recalledView)
        showcase4.primaryText = "Action 4"
        showcase4.secondaryText = "Click here to go Recalled documents details"
        showcase4.shouldSetTintColor = false // It should be set to false when button uses image.
        showcase4.backgroundPromptColor = UIColor.blue
        showcase4.isTapRecognizerForTargetView = true
        
        let showcase5 = MaterialShowcase()
        //showcase5.setTargetView(button: completedButton, tapThrough: false)
        showcase5.setTargetView(view: completedView)
        showcase5.primaryText = "Action 5"
        showcase5.secondaryText = "Click here to go completed documents details"
        showcase5.shouldSetTintColor = false // It should be set to false when button uses image.
        showcase5.backgroundPromptColor = UIColor.blue
        showcase5.isTapRecognizerForTargetView = true
        
        
        let showcase6 = MaterialShowcase()
        showcase6.setTargetView(button: dashboardButton2, tapThrough: false)
        showcase6.primaryText = "Action 6"
        showcase6.secondaryText = "Click here to see Dashboard Content"
        showcase6.shouldSetTintColor = false // It should be set to false when button uses image.
        showcase6.backgroundPromptColor = UIColor.blue
        showcase6.isTapRecognizerForTargetView = true
        
        let showcase7 = MaterialShowcase()
        showcase7.setTargetView(button: uploadButton2, tapThrough: false)
        showcase7.primaryText = "Action 7"
        showcase7.secondaryText = "Click here to go Online Signing"
        showcase7.shouldSetTintColor = false // It should be set to false when button uses image.
        showcase7.backgroundPromptColor = UIColor.blue
        showcase7.isTapRecognizerForTargetView = true
        
        let showcase8 = MaterialShowcase()
        showcase8.setTargetView(button: selectFormButton3, tapThrough: false)
        showcase8.primaryText = "Action 8"
        showcase8.secondaryText = "Click here to go Workflow Initiation"
        showcase8.shouldSetTintColor = false // It should be set to false when button uses image.
        showcase8.backgroundPromptColor = UIColor.blue
        showcase8.isTapRecognizerForTargetView = false
        
       /* let showcase9 = MaterialShowcase()
        showcase4.setTargetView(barButtonItem: sideMenuLeftButton)
        showcase4.primaryText = "Action 4"
        showcase4.secondaryText = "Click here to go into details"
        showcase4.isTapRecognizerForTargetView = false */
        
        showcase1.delegate = self
        showcase2.delegate = self
        showcase3.delegate = self
        showcase4.delegate = self
        showcase5.delegate = self
        showcase6.delegate = self
        showcase7.delegate = self
        showcase8.delegate = self
        
        // With one key, the showcase sequence only shows one time
        // So, for this demo, it is better to create a random key
        let oneTimeKey = UUID().uuidString
        sequence.temp(showcase1).temp(showcase2).temp(showcase3).temp(showcase4).temp(showcase5).temp(showcase6).temp(showcase7).temp(showcase8).setKey(key: oneTimeKey).start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
      sequence.showCaseWillDismis()
    }
}
