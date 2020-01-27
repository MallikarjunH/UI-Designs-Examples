//
//  ConsultOnline_SearcScreen.swift
//  VidalHealth
//
//  Created by mallikarjun on 21/11/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class ConsultOnline_SearcScreen: UIViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
    
    var searchFromVC = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    
    //   var searchData:[String] = []
    
    var searchLabelsArray:[String] = []
    
    //MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.mainTableView!.tableFooterView = UIView()
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: TableView Datasource and Delegate method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchLabelsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlineConsultSearchCellId", for: indexPath) as! OnlineConsultSearchCell
        // cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        cell.searchLabel.text = searchLabelsArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //  print(searchLabelsArray[indexPath.row])
        
        let storyBoard = UIStoryboard(name: "OnlineConsultation", bundle: nil)
        let searchResultScreen = storyBoard.instantiateViewController(withIdentifier: "SearchResultScreenId") as? SearchResultScreen
        
        searchResultScreen?.getFilterType = "keyword"
        searchResultScreen?.getClinicSlugID = searchLabelsArray[indexPath.row]
        searchResultScreen?.getNavigationTitle = searchLabelsArray[indexPath.row]
        searchResultScreen?.scheduleConsultationClinicSlug = searchLabelsArray[indexPath.row]
        
        if (navigationController?.topViewController is SearchResultScreen) {
            return
        }else {
            navigationController?.pushViewController(searchResultScreen!, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchForCondition()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let cs = CharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_NAME_ONLY_CHAR).inverted
        let filtered = text.components(separatedBy: cs).joined(separator: "")
        return text == filtered
        
    }
    
    
    //MARK: Back Button
    @IBAction func backButtonClicked(_ sender: Any) {
        searchBar.resignFirstResponder()
        
        if self.searchFromVC == "fromClinicListsVC"{
            
            self.navigationController?.popViewController(animated: true)
            
        }else{
            
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: ConsultOnlineClinicLists.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }
        
    }
    
    //MARK: Search API Call
    func searchForCondition(){
        
        if searchBar.text?.count == 0 {
            searchLabelsArray.removeAll()
            mainTableView.reloadData()
        } else {
            
            let str = searchBar.text!.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
            
            let urlString = kSearchForConditionAPIPath + (str ?? "")
            let params:[String:Any] = [:]
            
            APIRequester_New.fireGetMethod(URLString: urlString, aParams: params as [AnyHashable : Any]) { response ,error in
                
                if(error == nil)
                {
                    if let is_success:Bool = response!["SUCCESS"] as? Bool
                    {
                        if (is_success)
                        {
                            self.searchLabelsArray.removeAll()
                            
                            if let responseDataDict = response as NSDictionary?{
                                
                                if let keywordsArray = responseDataDict.object(forKey: "keywords") as? [[String:String]]{
                                    
                                    if keywordsArray.count > 0{
                                        
                                        self.searchLabelsArray = []
                                        
                                        for keywordsDict:Dictionary<String,String> in keywordsArray{
                                            
                                            let searchValue:String = keywordsDict["name"] ?? "Not Found"
                                            
                                            self.searchLabelsArray.append(searchValue)
                                        }
                                        
                                    } //end searhArray
                                }else{
                                    // keywordsArray is not present with keyword object
                                }
                                
                            }else{
                                // repons is not responseDataDict type
                            }
                            
                            DispatchQueue.main.async {
                                self.mainTableView.reloadData()
                            }
                            
                            
                        } //not success
                        else
                        {
                            if let message:String = response?["message"] as? String
                            {
                                showAlert(title: "Alert", message: message, vc: self)
                            }
                        }
                    }
                    else{
                        
                        self.searchLabelsArray.removeAll()
                        self.mainTableView.reloadData()
                    }
                    
                    
                }
                
            } //end APIRequester_New method
            
        } //end else main
        
    } //end searchForCondition
    
    
}

