//
//  ViewController.swift
//  AllControlsTest
//
//  Created by EOO61 on 17/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sampleTableView: UITableView!
    
    var numberOfControls = 3
    
    var nameDataTextFieldArr:[String] = []
    var selectedRadioButtonIndex = -1
    var selectedCheckBoxArr:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedCheckBoxArr = [-1, -1]
        
        nameDataTextFieldArr = ["", ""]
        
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        
        //print()
        print("Check box details: \(selectedCheckBoxArr)")
        print("Selcted Radio Button is: \(self.selectedRadioButtonIndex)")
        
       // sampleTableView.reloadSections(IndexSet(integer: 0), with: .none)
       // print("All Names Are: \(nameDataTextFieldArr)")
        
        for (index,name) in nameDataTextFieldArr.enumerated() {
            let cell: TextFieldTableViewCell = sampleTableView.cellForRow(at: NSIndexPath(row: index, section: 0) as IndexPath) as! TextFieldTableViewCell
            print("Entered Value: \(cell.dataTextField.text)")
        }
    
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return numberOfControls
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 2
        }
        else if section == 1 {
            
            return 2
        }
        else if section == 2 {
            return 3
        }
        else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            
            cell.dataTextField.text = nameDataTextFieldArr[indexPath.row]
            nameDataTextFieldArr[indexPath.row] = cell.dataTextField.text ?? ""
            return cell
        }
        else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxTableViewCell", for: indexPath) as! CheckBoxTableViewCell
            
            //check //uncheck
            let checkBoxChecked =  self.selectedCheckBoxArr[indexPath.row]
            if checkBoxChecked == -1 {
                cell.checkBoxImg.image = UIImage(named: "uncheck")
            }else{
                cell.checkBoxImg.image = UIImage(named: "check")
            }
            
            return cell
        }
        else { //2
            let cell = tableView.dequeueReusableCell(withIdentifier: "RadioButtonTableViewCell", for: indexPath) as! RadioButtonTableViewCell
            
            //self.selectedRadioButtonIndex //Radiobutton_On // Radiobutton_Off
            if indexPath.row == self.selectedRadioButtonIndex {
                cell.radioImg.image = UIImage(named: "Radiobutton_On")
            }
            else{
                cell.radioImg.image = UIImage(named: "Radiobutton_Off")
            }
            return cell
        }
    }
    
   /* @objc func checkBoxImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
         print("clicked on check box")

    }

    */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Clicked index: \(indexPath.row) from Section: \(indexPath.section)")
        
        if indexPath.section == 0 {
            

        }
        else if indexPath.section == 1 {
            if self.selectedCheckBoxArr[indexPath.row] == indexPath.row {
                self.selectedCheckBoxArr[indexPath.row] = -1
            }else{
                self.selectedCheckBoxArr[indexPath.row] = indexPath.row
            }
            
            tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }else{
            self.selectedRadioButtonIndex = indexPath.row
            tableView.reloadSections(IndexSet(integer: 2), with: .none)
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 76.0
        }
        else if indexPath.section == 1 {
            
            return 44.0
        }
        else{
            return  44.0
        }
    }
    
}
