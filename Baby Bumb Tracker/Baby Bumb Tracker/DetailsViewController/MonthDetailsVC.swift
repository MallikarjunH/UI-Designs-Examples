//
//  MonthDetailsVC.swift
//  Baby Bumb Tracker
//
//  Created by mallikarjun on 04/07/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class MonthDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthDetailsCell1Id", for: indexPath) as! MonthDetailsCell1
            
            cell.demoImageView.isHidden = true
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthDetailsCell2Id", for: indexPath) as! MonthDetailsCell2
            
            cell.descriptionLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
            return cell
            
        }
    }


}
