//
//  Feed_Detailed_ViewController.swift
//  VidalHealth
//
//  Created by swathi.nandy on 25/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class Feed_Detailed_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var feedDataTableView: UITableView!
    @IBOutlet weak var tagFeedButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        
        feedDataTableView.delegate = self
        feedDataTableView.dataSource = self
        feedDataTableView.separatorStyle = .none
        feedDataTableView.allowsSelection = true
        feedDataTableView.estimatedRowHeight = 270
        feedDataTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    //MARK: Button Actions
    @IBAction func backButtonAction(sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func likeButtonAction(sender: UIButton) {
       
    }
    @IBAction func commentButtonAction(sender: UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "HealthBlogs", bundle: nil)
        let healthBlog = storyBoard.instantiateViewController(withIdentifier: "Feed_Comments_view") as! Feed_Comments_view
        if ((self.navigationController?.topViewController?.isKind(of: Feed_Comments_view.classForCoder()))!) {
            return
        }
        else
        {
            self.navigationController?.pushViewController(healthBlog, animated: true)
        }
        
    }
    @IBAction func shareButtonAction(sender: UIButton) {
        
    }
    @IBAction func tagButtonAction(sender: UIButton) {
        
    }
    @IBAction func emergencyButtonAction(sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(emergencyVC, animated: true)
        }
    }
    
    @IBAction func notificationButtonAction(sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let notificationVC = storyBoard.instantiateViewController(withIdentifier: "Notifications") as! Notifications
        if ((self.navigationController?.topViewController?.isKind(of: Notifications.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
    }
    @IBAction func searchButtonAction(sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let searchVC: SearchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        if ((self.navigationController?.topViewController?.isKind(of: SearchViewController.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
     //MARK: tableview methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return  UITableViewAutomaticDimension
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
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
           if(indexPath.row == 0)
           {
                let feedCellIdentifier = "FeedDetailedFirstCellIdentifier"
                let feedCell : FeedDetailedFirstCell = tableView.dequeueReusableCell(withIdentifier: feedCellIdentifier, for: indexPath) as! FeedDetailedFirstCell
                feedCell.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
                return feedCell
          }
         else
         {
                let feedCellIdentifier = "FeedDetailedSecondCellIdentifier"
                let feedCell : FeedDetailedSecondCell = tableView.dequeueReusableCell(withIdentifier: feedCellIdentifier, for: indexPath) as! FeedDetailedSecondCell
                feedCell.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
                return feedCell
        }
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
