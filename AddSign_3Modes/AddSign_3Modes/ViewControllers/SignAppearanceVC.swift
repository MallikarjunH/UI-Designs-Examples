//
//  SignAppearanceVC.swift
//  AddSign_3Modes
//
//  Created by EOO61 on 30/01/22.
//
//https://medium.com/swlh/how-to-implement-custom-font-with-uifontpickercontroller-in-ios-13-5a06958c73d3



import UIKit

class SignAppearanceVC: UIViewController {
    
    // var lastSignedSignatureImgArray:[String] = [] //base64 string in real time
    let fontSignSelectionArray:[String] = ["Pacifico", "Nothing You Could Do"]
    var lastSignedSignatureImgArray:[String] = ["sampleSignImg1", "sampleSignImg2", "sampleSignImg3"]
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var selectedSection = -1
    var selectedIndexInSection = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.mainTableView.reloadData()
    }
    
}

extension SignAppearanceVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
            return 2
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FontSignSelectionCell", for: indexPath) as! FontSignSelectionCell
            
            cell.signFontLabel.text = "Mallikarjun H" // font 22
            cell.signFontLabel.font = UIFont(name: fontSignSelectionArray[indexPath.row], size: 22)
            
            
            if self.selectedSection == indexPath.section && self.selectedIndexInSection == indexPath.row {
                cell.radioImageOutlet.image = UIImage(named: "Radiobutton_On")
            }else{
                cell.radioImageOutlet.image = UIImage(named: "Radiobutton_Off")
            }
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageSignSelectionCell", for: indexPath) as! ImageSignSelectionCell
            
            cell.signImageOutlet.image = UIImage(named: lastSignedSignatureImgArray[indexPath.row])
            
            
            if self.selectedSection == indexPath.section && self.selectedIndexInSection == indexPath.row {
                cell.radioImageOutlet.image = UIImage(named: "Radiobutton_On")
            }else{
                cell.radioImageOutlet.image = UIImage(named: "Radiobutton_Off")
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedSection = indexPath.section
         selectedIndexInSection = indexPath.row
         self.mainTableView.reloadData()
    }
    
}
