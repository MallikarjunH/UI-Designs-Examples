//
//  ThreeRowsThreeColumns.swift
//  TestTableData
//
//  Created by mallikarjun on 06/08/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class ThreeRowsThreeColumns:  UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeRowsThreeColumnsCell", for: indexPath) as! ThreeRowsThreeColumnsCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 297.0
    }

}
