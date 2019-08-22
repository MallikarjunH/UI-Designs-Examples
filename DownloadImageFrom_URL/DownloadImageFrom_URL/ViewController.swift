//
//  ViewController.swift
//  DownloadImageFrom_URL
//
//  Created by mallikarjun on 22/08/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sampleImageVIew: UIImageView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let imgURL = NSURL(string: "http://10.1.6.63:8000/media/health_tools_media/bbt/9zpYBkc0Rl/tibor-moskovits-square.jpg")
         self.downloadImage(from: imgURL! as URL)
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                  self.sampleImageVIew.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    


}

