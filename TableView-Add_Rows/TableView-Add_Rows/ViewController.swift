//
//  ViewController.swift
//  TableView-Add_Rows
//
//  Created by mallikarjun on 27/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var dataArray:[String] = ["File 1", "File 2"]
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.mainTableView!.tableFooterView = UIView()
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if dataArray.count > 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = dataArray.count //1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      //  var numOfSections: Int = 0
        
        if section == 0 {
            
            return dataArray.count
        }
            
        else if section == 1 {
            
            return 1
        }
        else{
            
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell1Id", for: indexPath) as!  TableViewCell1
            cell.fileNameLabel.text = self.dataArray[indexPath.row]
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell2Id", for: indexPath) as!  TableViewCell2
            
            cell.addButton.addTarget(self, action: #selector(selectFileButton(sender:)), for: .touchUpInside)
            
            return cell
            
        }
    }
    
    
     @objc func selectFileButton(sender:UIButton){
        
        self.dataArray.append("File Data")
        self.mainTableView.reloadData()
    }

}

