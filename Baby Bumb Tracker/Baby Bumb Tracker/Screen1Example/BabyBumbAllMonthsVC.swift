//
//  BabyBumbAllMonthsVC.swift
//  Baby Bumb Tracker
//
//  Created by mallikarjun on 03/07/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class BabyBumbAllMonthsVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var monthArray = ["1st Month","2nd Month","3rd Month","4th Month","5th Month","6th Month","7th Month","8th Month","9th Month"]
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return monthArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BabyBumbAllMonthsCellId", for: indexPath) as! BabyBumbAllMonthsCell
        
        cell.monthLabel.text = monthArray[indexPath.item]
        cell.monthLabel.textColor = UIColor.black
      //  cell.gradientView.addSubview(cell.monthLabel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("clicked")
       //move to next VC
       let storyBoard = UIStoryboard(name: "Main", bundle: nil)
       let detailsVC = storyBoard.instantiateViewController(withIdentifier: "MonthDetailsVCId") as! MonthDetailsVC
        GlobalVariables.sharedManager.babyMonth = monthArray[indexPath.item]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        var cellSize: CGSize

        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width - 40
        
        cellSize = CGSize(width: screenWidth / 2.0, height: 235)
        
        return cellSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 13, bottom: 10, right: 13)
    }
    
}
