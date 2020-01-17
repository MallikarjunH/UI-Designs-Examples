//
//  HealthBlogs_Feed_View.swift
//  VidalHealth
//
//  Created by swathi.nandy on 24/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class HealthBlogs_Feed_View: UIViewController, UITableViewDelegate,UITableViewDataSource{
 @IBOutlet weak var feedTableView: UITableView!
 @IBOutlet weak var searchbar: UISearchBar!
 var feedArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
         self.feedTableView.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.separatorStyle = .none
        feedTableView.allowsSelection = true
        
        feedArray.append("")
        feedArray.append("")
        feedArray.append("")
        feedArray.append("")
        // Do any additional setup after loading the view.
    }
    

    
    //MARK: Table methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 145
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.feedArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let TopicFeedCellCellIdentifier = "TopicFeedCellIdentifier"
        
        let feedCell : TopicFeedCell = tableView.dequeueReusableCell(withIdentifier: TopicFeedCellCellIdentifier, for: indexPath) as! TopicFeedCell
        
       feedCell.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
      
        
        return feedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        NotificationCenter.default.post(name: Notification.Name("selectedFeedFromFeedTab"), object: nil)
        
        
    }
    

}
