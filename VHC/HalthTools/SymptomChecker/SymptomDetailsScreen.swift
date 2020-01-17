//
//  SymptomDetailsScreen.swift
//  VidalHealth
//
//  Created by mallikarjun on 27/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class SymptomDetailsScreen: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var symptomNameNavigationLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    
    var titleNamesArray = ["Diagnosed By","Treatment","Taking care of yourself","Prevention"]
    var descriptionDetailsArray = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s","Lorem Ipsum is simply dummy text of the printing and typesetting industry.","Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s","Lorem Ipsum is simply dummy text"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SymptomDetailsScreenCell = tableView.dequeueReusableCell(withIdentifier: "SymptomDetailsScreenCellId", for: indexPath) as! SymptomDetailsScreenCell
        
        cell.titleLabel.text = titleNamesArray[indexPath.row]
        cell.descriptionLabel.text = descriptionDetailsArray[indexPath.row]
        
        return cell
    }


    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        
    }
    
}
