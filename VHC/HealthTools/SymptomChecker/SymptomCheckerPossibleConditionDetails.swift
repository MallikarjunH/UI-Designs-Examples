//
//  SymptomCheckerPossibleConditionDetails.swift
//  VidalHealth
//
//  Created by mallikarjun on 26/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class SymptomCheckerPossibleConditionDetails: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var someSampleDescription = "The earliest known human remains in South Asia date to about 30,000 years ago.[27] Nearly contemporaneous human rock art sites have been found in many parts of the Indian subcontinent, including at the Bhimbetka rock shelters in Madhya Pradesh.[28] After 6500 BCE, evidence for domestication of food crops and animals, construction of permanent structures, and storage of agricultural surplus, appeared in Mehrgarh and other sites in what is now Balochistan.[29]"
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SymptomCheckerPossibleConditionDetailsCell = tableView.dequeueReusableCell(withIdentifier: "SymptomCheckerPossibleConditionDetailsCellId", for: indexPath) as! SymptomCheckerPossibleConditionDetailsCell
        
        cell.possibleConditionDetailsLabel.text = someSampleDescription
        return cell
    }
    
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
      
       self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        //
    }
    
}
