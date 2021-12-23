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

    
    var showsNameArray:[String] = []
    var showsLanguageArray:[String] = []
    var showsSummaryArray:[String] = []
    var showsRatingArray:[Double] = []
    var showsImageArray:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TV Shows"
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
        
                  //  print("JSON Array: \(jsonArray)")
                    
                   if jsonArray.count > 0{
                    
                    self.showsNameArray = []
                    self.showsLanguageArray = []
                    self.showsSummaryArray = []
                    self.showsRatingArray = []
                    self.showsImageArray = []
                    
                    for jsonDataDict:Dictionary<String,Any> in jsonArray{
                       
                        if let showDict:Dictionary<String,Any> = jsonDataDict["show"] as? [String:Any] {
                            
                            let showName:String = showDict["name"] as? String ?? "No Name"
                            let showLanguage:String = showDict["language"] as? String ?? "No Language"
                            let showSummary:String = showDict["summary"] as? String ?? "No Summary Found"
                            
                            self.showsNameArray.append(showName)
                            self.showsLanguageArray.append(showLanguage)
                            self.showsSummaryArray.append(showSummary)
                            
                            if let ratingDict:Dictionary<String,Any> = showDict["rating"] as? [String:Any] {
                                
                                let showRating:Double = ratingDict["average"] as? Double ?? 0.0
                                self.showsRatingArray.append(showRating)
                            }
                            
                            if let imageDict:Dictionary<String,Any> = showDict["image"] as? [String:Any] {
                                
                                let showImageLink:String = imageDict["medium"] as? String ?? ""
                                self.showsImageArray.append(showImageLink)
                            } // original
                            else{
                                self.showsImageArray.append("")
                            }
                        }
                        
                    }
                    

                    DispatchQueue.main.async {
                    
                        self.mainCollectionView.reloadData()
                    }
                    
                    
                   }
                   else{
                    
                     //JSON Count is zero
                    //show message Data Not Found
                    }
                    
                 } catch let parsingError {
                    print("Error", parsingError)
               }
            }
            task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (self.showsNameArray.count == 0) {
            self.mainCollectionView.setEmptyMessage("No Data Found")
        } else {
             self.mainCollectionView.restore()
        }
        return showsNameArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowsListCellId", for: indexPath) as! ShowsListCell
        
        cell.showNameLabel.text = showsNameArray[indexPath.item]
        
        if self.showsImageArray[indexPath.item] != ""{
            AppUtilitiesSwift.getData(from: self.showsImageArray[indexPath.item] as String) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    cell.showImageView.image = UIImage(data: data)
                }
            }
        }
        else{
            cell.showImageView.image = UIImage(named: "imageNotFound.png")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // print(indexPath.item)
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowsDetailsVCId") as! ShowsDetailsVC
        
        detailsVC.showName = self.showsNameArray[indexPath.item]
        detailsVC.showImage = self.showsImageArray[indexPath.item]
        detailsVC.showRating = self.showsRatingArray[indexPath.item]
        detailsVC.showLanguage = self.showsLanguageArray[indexPath.item]
        detailsVC.showSummary = self.showsSummaryArray[indexPath.item]
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size: CGSize = CGSize(width: self.view.frame.width/3, height: 214)
        return size
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    
}

