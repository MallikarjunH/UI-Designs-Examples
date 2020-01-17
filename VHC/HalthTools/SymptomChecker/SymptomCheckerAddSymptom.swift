//
//  SymptomCheckerAddSymptom.swift
//  VidalHealth
//
//  Created by mallikarjun on 25/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class SymptomCheckerAddSymptom: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
   

    @IBOutlet weak var addYourSymptomLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var mainSearchView: UIView!
    @IBOutlet weak var seachTextField: UITextField!
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var symptomArray = ["Multiple Myeloma","Echolalia","Melanoma","Postpartum Depression","Lack of Facial Expressions", "Hyperactivity","Psoriatic Arthritis","Bipolar Disorder","Intestine Cancer"]
    
    var selectedSymptom:String = ""
    var symptomsTagArray = ["test"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
      self.mainTableView.isHidden = true
      mainCollectionView.isHidden = true
        
      self.mainSearchView.layer.cornerRadius = 3.0 //5.0
      self.mainSearchView.clipsToBounds = true
        
      addYourSymptomLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
      descriptionLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
      descriptionLabel.text = "Add as many Symptoms as you can for the most accurate results"
      mainCollectionView.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return symptomArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SymptomSearchCell = tableView.dequeueReusableCell(withIdentifier: "SymptomSearchCellId", for: indexPath) as! SymptomSearchCell
        
        cell.symptomLabel.text = symptomArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedSymptom = symptomArray[indexPath.row]
        
        if !selectedSymptom.isEmpty{
            
            reloadView()
        }
        else{
            
        }
    }
    
    func reloadView(){
        
        DispatchQueue.main.async {
            self.seachTextField.text = self.selectedSymptom
            self.mainTableView.isHidden = true
            self.symptomsTagArray.append(self.selectedSymptom)
            self.mainCollectionView.isHidden = false
            self.mainCollectionView.reloadData()
        }
    }
    
    
    //MARK: CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // print(symptomsTagArray)
        return symptomArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SymptomtagListCollectionViewId", for: indexPath) as! SymptomtagListCollectionView
        
        cell.contentView.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1)
        cell.symptomTagLabel.text = symptomArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Clicked on :\(indexPath.item) item and Value is: \(symptomArray[indexPath.item])")
        symptomArray.remove(at:indexPath.item)
        mainCollectionView.reloadData()
        mainTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        /* var cellSize: CGSize
         
         let screenRect = collectionViewInstance.bounds
         let screenWidth = screenRect.size.width - 30
         
         cellSize = CGSize(width: screenWidth / 3.0, height: 35)
         
         return cellSize */
        // return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 20), height: CGFloat(100))
        
        let label = UILabel(frame: CGRect.zero)
        label.text = symptomArray[indexPath.item]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 20 , height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top:0, left: 2, bottom: 2, right: 2)
    }

    //MARK: TextFeild Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.mainTableView.isHidden = true
        self.mainCollectionView.isHidden = false
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        descriptionLabel.isHidden = true
        self.mainTableView.isHidden = false
        self.mainCollectionView.isHidden = true
        return true
    }
    
  /*  func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    } */
    
    //MARK: Navigation and Bottom Button Actions
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "HealthTools", bundle: nil)
        let symptomsDetailsVC = storyBoard.instantiateViewController(withIdentifier: "SymptomDetailsScreenId") as? SymptomDetailsScreen
        navigationController?.pushViewController(symptomsDetailsVC!, animated: true)
    }
    
}
