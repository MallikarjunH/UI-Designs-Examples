//
//  ShowsDetailsVC.swift
//  MyNewCar_Task
//
//  Created by mallikarjun on 09/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import UIKit

class ShowsDetailsVC: UIViewController {

    var showImage:String = ""
    var showName:String = ""
    var showRating:Double = 0.0
    var showLanguage:String = ""
    var showSummary:String = ""
    
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showLanguageLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
    @IBOutlet weak var showSummaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.updateUI()
    }
    
    func updateUI(){
        
        self.showNameLabel.text = showName
        self.showLanguageLabel.text = showLanguage
        self.showRatingLabel.text = "\(showRating)"
        self.showSummaryLabel.text = showSummary
        
        if self.showImage != ""{
            AppUtilitiesSwift.getData(from: self.showImage as String) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.showImageView.image = UIImage(data: data)
                }
            }
        }
        else{
            self.showImageView.image = UIImage(named: "imageNotFound.png")
        }
        
    }

}
