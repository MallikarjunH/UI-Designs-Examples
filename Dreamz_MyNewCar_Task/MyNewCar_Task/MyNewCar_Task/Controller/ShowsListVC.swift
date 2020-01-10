//
//  ShowsListVC.swift
//  MyNewCar_Task
//
//  Created by mallikarjun on 09/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import UIKit

class ShowsListVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    let itemsArray = ["Cell 1", "Cell 2","Cell 3","Cell 4","Cell 5","Cell 6","Cell 7","Cell 8","Cell 8","Cell 10","Cell 11","Cell 12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getAllShowsListAPICall()
    }
    
    //MARK: API Call
    func getAllShowsListAPICall(){
        
            guard let url = URL(string: "http://api.tvmaze.com/search/shows?q=girls") else {return}
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                      error == nil else {
                      print(error?.localizedDescription ?? "Response Error")
                      return }
                do{
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                                           dataResponse, options: [])
                    
                  //  print("JSON Response: \(jsonResponse)") //Response result
                    
                    //get the data from dictionary
                    
                    guard let jsonArray = jsonResponse as? [[String: Any]] else {
                          return
                    }
        
                    print("JSON Array: \(jsonArray)")
                    
                  /*  if jsonArray.count > 0{
                        
                        self.idArray = []
                        self.titleArray = []
                        
                        for dictData:Dictionary<String,Any> in jsonArray{
                            
                            let idValue:Int = dictData["id"] as? Int ?? 0
                            let title:String = dictData["title"] as? String ?? "Not Title"
                    
                            self.idArray.append(idValue)
                            self.titleArray.append(title)
                        }
                        
                        print("Id Array is: \(self.idArray)")
                        print("Title Array is: \(self.idArray)")
                        
                    }else{
                        //array is empty
                    } */
                    
                 } catch let parsingError {
                    print("Error", parsingError)
               }
            }
            task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowsListCellId", for: indexPath) as! ShowsListCell
        
        cell.showNameLabel.text = itemsArray[indexPath.item]
        cell.showImageView.image = UIImage(named: "78286.jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size: CGSize = CGSize(width: self.view.frame.width/3, height: 214)
        return size
        
//        var cellSize: CGSize
//
//                let screenRect = UIScreen.main.bounds
//                let screenWidth = screenRect.size.width
//
//                cellSize = CGSize(width: screenWidth / 3.0, height: 214)
//
//            return cellSize
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    
}
