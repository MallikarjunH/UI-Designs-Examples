//
//  Topic_Selection_View.swift
//  VidalHealth
//
//  Created by swathi.nandy on 20/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class Topic_Selection_View: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
  
    var topicsArray = ["Fitness", "Health", "Heart", "Food", "Cancer", "Diet"]
    var topicsSelectedArray = ["0", "0", "0", "0", "0", "0"]
  @IBOutlet weak var ProceedButton: UIButton!
 @IBOutlet weak var topicCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
   // let color = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
     self.view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        
    self.topicCollectionView.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)

       topicCollectionView.delegate = self
       topicCollectionView.dataSource = self
       topicCollectionView.reloadData()
        
    }
    // MARK: UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width  = (view.frame.width-50)/2
        return CGSize(width: width, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topicsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "topic_Section_reuse_identifier"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! TopicSelectionCollectionCell
        cell.topicButton.setTitle(topicsArray[indexPath.item], for: .normal)
        cell.topicButton.tag = indexPath.row
        cell.topicButton.addTarget(self, action: #selector(selectButtonAction(sender:)), for: .touchUpInside)
       
        if(topicsSelectedArray[indexPath.item] == "1")
        {
            let color = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
             cell.topicButton.layer.borderColor = color.cgColor
        }
        else
        {
             cell.topicButton.layer.borderColor = UIColor.white.cgColor
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print()
        
    }
    @objc func selectButtonAction(sender:UIButton)
    {
        if(topicsSelectedArray[sender.tag] == "1")
        {
            topicsSelectedArray[sender.tag] = "0"
        }
        else if(topicsSelectedArray[sender.tag] == "0")
        {
            topicsSelectedArray[sender.tag] = "1"
        }
        validateProceedButtonAction()
        topicCollectionView.reloadData()
    }
    func validateProceedButtonAction()
    {
        if(topicsSelectedArray.contains("1"))
        {
             self.ProceedButton.backgroundColor = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
        }
        else
        {
            self.ProceedButton.backgroundColor = UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
        }
    }
    @IBAction func proceedButtonAction(sender: UIButton) {
        if(!topicsSelectedArray.contains("1"))
        {
             return
        }
        else if(topicsSelectedArray.contains("1"))
        {
            
            let storyBoard = UIStoryboard.init(name: "HealthBlogs", bundle: nil)
            let healthBlog = storyBoard.instantiateViewController(withIdentifier: "HealthBlogsSegmentBaseView") as! HealthBlogsSegmentBaseView
            if ((self.navigationController?.topViewController?.isKind(of: HealthBlogsSegmentBaseView.classForCoder()))!) {
                return
            }
            else
            {
                self.navigationController?.pushViewController(healthBlog, animated: true)
            }
        }
    }
    
    @IBAction func backButtonAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
}
