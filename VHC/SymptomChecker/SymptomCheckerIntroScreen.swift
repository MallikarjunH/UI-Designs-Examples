//
//  SymptomCheckerIntroScreen.swift
//  VidalHealth
//
//  Created by mallikarjun on 25/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class SymptomCheckerIntroScreen: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SymptomCheckerIntroScreenCell = tableView.dequeueReusableCell(withIdentifier: "SymptomCheckerIntroScreenCellId", for: indexPath) as! SymptomCheckerIntroScreenCell
        
        return cell
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func startButtonClicked(_ sender: Any) {
        //print("Clicked on start button")
        
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let addSymptomVC = storyBoard.instantiateViewController(withIdentifier: "SymptomCheckerAddSymptomId") as? SymptomCheckerAddSymptom
        
        navigationController?.pushViewController(addSymptomVC!, animated: true)
        
    }
}
