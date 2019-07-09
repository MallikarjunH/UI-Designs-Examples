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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell1Id", for: indexPath) as! TableViewCell1
            
            
            return cell
        }
        
        else if(indexPath.section == 1){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell2Id", for: indexPath) as! TableViewCell2
            
            cell.descriptionLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standardum is simply dummy text of the printing and typesetting industry."
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell3Id", for: indexPath) as! TableViewCell3
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 2{
            
            return 300
        }
        else{
       
             return UITableView.automaticDimension
            
        }
    }



}

