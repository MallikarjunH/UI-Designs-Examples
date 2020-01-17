//
//  CalorieCounterIntroScreen.swift
//  VidalHealth
//
//  Created by mallikarjun on 08/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCounterIntroScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: TableView Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounteIntroScreenCellId", for: indexPath) as! CalorieCounteIntroScreenCell
         cell.selectionStyle = UITableViewCellSelectionStyle.none;
         cell.helloUserNameLabel.text = "Hello \(GlobalVariables.sharedManager.loggedUserName)!"
        
        return cell
    }
    
    //MARK: NAvigation and Bottom Buttons Actions
    @IBAction func backButtonClicked(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func keepLogsButtonAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "CalorieCounterUserDetailsId") as? CalorieCounterUserDetails
        self.navigationController?.pushViewController(detailsVC!, animated: true)
    }
    

}
