//
//  CalorieCounterSearchToAddFood.swift
//  VidalHealth
//
//  Created by mallikarjun on 10/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCounterSearchToAddFood: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var selectedValueFromSearchTable = ""
    let searchFoodArray = ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5", "Food 6", "Food 7", "Food 8"]
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchMainView: UIView!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var searchAddFoodSuggestionView: UIView!
    @IBOutlet weak var searchAddFoodSuggestionLabel: UILabel!
    
    @IBOutlet weak var addFoodSuggestionButton: UIButton!
    
    @IBOutlet weak var searchFoodTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchMainView.layer.cornerRadius = 3
        searchAddFoodSuggestionView.layer.cornerRadius = 3
        
        searchFoodTableView.isHidden = true
        searchAddFoodSuggestionView.isHidden = true
        searchAddFoodSuggestionLabel.isHidden = false
    }
    
    
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchFoodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCounterSearchToAddFoodCellId", for: indexPath) as! CalorieCounterSearchToAddFoodCell
        
        cell.foodLabel.text = searchFoodArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        selectedValueFromSearchTable =  searchFoodArray[indexPath.row]
        self.updateViews1()
    }
    
    func updateViews1(){
        
        DispatchQueue.main.async {
            self.searchFoodTableView.isHidden = true
            self.searchAddFoodSuggestionLabel.isHidden = true
            self.searchTextField.text = self.selectedValueFromSearchTable
           
        }
    }
    
    func updateViews2(){
        DispatchQueue.main.async {
            self.searchFoodTableView.isHidden = false
            self.searchResultLabel.isHidden = true
            
        }
    }
    
    
    //MARK: TextField Methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.updateViews2()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.searchFoodTableView.isHidden = true
        return true
    }
    
    @IBAction func backButtonCliked(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
    

}
