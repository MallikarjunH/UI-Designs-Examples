//
//  ViewController.swift
//  Body Fat Calculator
//
//  Created by mallikarjun on 20/06/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var mainTablevIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if(indexPath.section == 0){
            
            let cell : TableViewCell1 = tableView.dequeueReusableCell(withIdentifier: "TableViewCell1", for: indexPath) as! TableViewCell1
            
            return cell
        }
        else if(indexPath.section == 1){
            
            let cell : TableViewCell2 = tableView.dequeueReusableCell(withIdentifier: "TableViewCell2", for: indexPath) as! TableViewCell2
            
            return cell
        }
        else{
            
            let cell : TableViewCell3 = tableView.dequeueReusableCell(withIdentifier: "TableViewCell3", for: indexPath) as! TableViewCell3
            
            return cell
            
        }
    }
    


}

