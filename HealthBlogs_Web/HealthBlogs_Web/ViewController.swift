//
//  ViewController.swift
//  HealthBlogs_Web
//
//  Created by mallikarjun on 13/08/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

 
    @IBOutlet weak var webViewInstance: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadBlogs()
    }

    func loadBlogs(){
        
        let url = URL (string: "https://vidalhealth.com/blog/")
        let myRequest = URLRequest(url: url!)
        webViewInstance.load(myRequest)
    
    }

}










