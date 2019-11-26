//
//  ViewController.swift
//  ExapandViewTest
//
//  Created by mallikarjun on 26/11/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var view2HeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var expandButton: UIButton!
   
    var isExpandded:Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view2HeightConstraint.constant = 80
    }

    @IBAction func expandButtonClick(_ sender: Any) {
     
        if !isExpandded {
            isExpandded = true
            print("Exapanded")
            self.updateViewHeight1()
        }else{
            isExpandded = false
            print("Not Exapanded")
            self.updateViewHeight2()
        }
        
    }
    
    func updateViewHeight1(){
        
        DispatchQueue.main.async {
            self.view2HeightConstraint.constant = CGFloat(20)
            self.expandButton.setTitle("Show details",for: .normal)
        }
    }
    
    func updateViewHeight2(){
        
        DispatchQueue.main.async {
            self.view2HeightConstraint.constant = CGFloat(80)
            self.expandButton.setTitle("Show less",for: .normal)

        }
    }
    
    
}

