//
//  HealthBlogs_Topics_View.swift
//  VidalHealth
//
//  Created by swathi.nandy on 24/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class HealthBlogs_Topics_View: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var topicsArray = ["Fitness", "Health", "Heart", "Food", "Cancer", "Diet"]
    var topicsSelectedArray = ["0", "0", "0", "0", "0", "0"]
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var topicCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // let color = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        
        self.topicCollectionView.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
         self.saveButton.backgroundColor = UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
        topicCollectionView.delegate = self
        topicCollectionView.dataSource = self
        topicCollectionView.reloadData()
        
        // Do any additional setup after loading the view.
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
            self.saveButton.backgroundColor = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
        }
        else
        {
            self.saveButton.backgroundColor = UIColor(red: 0.74, green: 0.75, blue: 0.82, alpha: 1)
        }
    }
    @IBAction func saveButtonAction(sender: UIButton) {
        if(!topicsSelectedArray.contains("1"))
        {
            return
        }
        else if(topicsSelectedArray.contains("1"))
        {
            
           
        }
    }
    
  

}
