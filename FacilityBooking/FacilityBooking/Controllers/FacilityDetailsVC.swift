//
//  FacilityDetailsVC.swift
//  FacilityBooking
//
//  Created by mallikarjun on 02/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import UIKit

class FacilityDetailsVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var bookSlotButtonOutlet: UIButton!
    

    var tileString:String = ""
    
    var slotsForClubHouse = ["10 AM - 11 AM", "11 AM - 12 PM","12 PM - 13 PM","13 PM - 14 PM","14 PM - 15 PM","15 PM - 16 PM", "16 PM - 17 PM","17 PM - 18 PM","18 PM - 19 PM","19 PM - 20 PM","20 PM - 21 PM","21 PM - 22 PM"]
    var slotsForTenisCourtHouse = ["10 AM - 11 AM", "11 AM - 12 PM","12 PM - 13 PM","13 PM - 14 PM","14 PM - 15 PM","15 PM - 16 PM", "16 PM - 17 PM","17 PM - 18 PM","18 PM - 19 PM","19 PM - 20 PM","20 PM - 21 PM","21 PM - 22 PM"]
    

    var selectedSlotString:String? = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = tileString
        
        bookSlotButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREY_COLOR)
        
    }
    
    
    //MARK: CollectionView Delegate mthods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.tileString == "Club house"{
            
            if (self.slotsForClubHouse.count == 0) {
                self.mainCollectionView.setEmptyMessage("No slots are available")
            } else {
                self.mainCollectionView.restore()
            }
            return self.slotsForClubHouse.count
        }
        else{
            
            if (self.slotsForTenisCourtHouse.count == 0) {
                    self.mainCollectionView.setEmptyMessage("No slots are available")
                } else {
                    self.mainCollectionView.restore()
                }
                return self.slotsForTenisCourtHouse.count
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size: CGSize = CGSize(width: (self.view.frame.width - 60)/3, height: 40)
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeSelectionCollectionCellId", for: indexPath) as! TimeSelectionCollectionCell
        
        if self.tileString == "Club house"{
            
            cell.timeButton.setTitle(self.slotsForClubHouse[indexPath.item], for:.normal)
        }
        else{
            cell.timeButton.setTitle(self.slotsForTenisCourtHouse[indexPath.item], for:.normal)
        }
        
       // cell.timeButton.setTitle(self.slotsForClubHouse[indexPath.item], for:.normal)
        cell.timeButton.tag = indexPath.row
        cell.timeButton.addTarget(self, action: #selector(slotSelectionAction(sender:)), for: .touchUpInside)
        
        let greyColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.TEXT_GREY_COLOR)
        let greenColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.BUTTON_GREEN_COLOR)
        
        
        if(selectedSlotString == self.slotsForClubHouse[indexPath.row]  || selectedSlotString == self.slotsForTenisCourtHouse[indexPath.row])
        {
            cell.timeButton.layer.borderColor = greenColor.cgColor
            cell.timeButton.setTitleColor(greenColor, for: .normal)
        }
        else
        {
            cell.timeButton.layer.borderColor = greyColor.cgColor
            cell.timeButton.setTitleColor(greyColor, for: .normal)
        }
        
        return  cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.mainCollectionView.reloadData()
    }
    

    //MARK: Slot selection action methods
    @objc func slotSelectionAction(sender: UIButton)
    {
        if self.tileString == "Club house"{
            
            print("Selected Slot is: \(self.slotsForClubHouse[sender.tag])")
            
            
            if(selectedSlotString == self.slotsForClubHouse[sender.tag])
            {
                selectedSlotString = "0"
            }
            else
            {
                selectedSlotString = self.slotsForClubHouse[sender.tag]
                
                if GlobalVariables.sharedManager.selectedSlotsArrayForClub.count > 0 {
                    
                    if GlobalVariables.sharedManager.selectedSlotsArrayForClub.contains(selectedSlotString!) {
                        
                        AppUtilitiesSwift.showAlert(title: "Opps! Booking Failed", message: "This slot is already booked", vc: self)
                        selectedSlotString = "0"
                    }
                    else{
                        
                        GlobalVariables.sharedManager.selectedSlotsArrayForClub.append(selectedSlotString!)
                    }
                }
                else{
        
                    GlobalVariables.sharedManager.selectedSlotsArrayForClub.append(selectedSlotString!)
                }
            }
            
        }
        else{
            print("Selected Slot is: \(self.slotsForTenisCourtHouse[sender.tag])")
            
            if(selectedSlotString == self.slotsForTenisCourtHouse[sender.tag])
            {
                selectedSlotString = "0"
            }
            else
            {
                selectedSlotString = self.slotsForTenisCourtHouse[sender.tag]
                //GlobalVariables.sharedManager.selectedSlotsArrayForTennisCourt?.append(selectedSlotString!)
                
                if GlobalVariables.sharedManager.selectedSlotsArrayForTennisCourt.count > 0 {
                    

                    if GlobalVariables.sharedManager.selectedSlotsArrayForTennisCourt.contains(selectedSlotString!) {
                        
                        AppUtilitiesSwift.showAlert(title: "Opps! Booking Failed", message: "This slot is already booked", vc: self)
                        selectedSlotString  = "0"
                    }
                    else{
                        
                        GlobalVariables.sharedManager.selectedSlotsArrayForTennisCourt.append(selectedSlotString!)
                    }
                }
                else{

                    GlobalVariables.sharedManager.selectedSlotsArrayForTennisCourt.append(selectedSlotString!)
                }
                
            }
        }
        
        self.mainCollectionView.reloadData()
        validateSlotSelectionButton()
    }
    
    func validateSlotSelectionButton()
    {
        if  selectedSlotString != "0"
        {
            bookSlotButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREEN_COLOR)
        }
        else
        {
            bookSlotButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREY_COLOR)
        }
    }
    
    
    
    @IBAction func bookSlotButtonClicked(_ sender: Any) {
   
        print("Slot is selected")
        // AppUtilitiesSwift.showAlert(title: "Success", message: "Slot is selected successfully", vc: self)
        // self.showAlertWithAction(message: "Slot is selected successfully.")
        
        if self.tileString == "Club house"{
            
            if (selectedSlotString?.hasPrefix("16"))! || (selectedSlotString?.hasPrefix("17"))! || (selectedSlotString?.hasPrefix("18"))! || (selectedSlotString?.hasPrefix("19"))! || (selectedSlotString?.hasPrefix("20"))! {
                
                //Rs.500 per hour
                 self.showAlertWithAction(message: "Slot is selected successfully. Rs. 500") //single slot selection
            }
            else{
                //Rs. 100 per hour
                self.showAlertWithAction(message: "Slot is selected successfully. Rs. 100")  //single slot selection
            }
        }
        else{
            
            self.showAlertWithAction(message: "Slot is selected successfully. Rs. 50") //single slot selection
        }
       
    }
    
    func showAlertWithAction(message:String)
       {
           let alert: UIAlertController = UIAlertController.init(title: "Success", message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (actionSheetController) -> Void in
               
               self.navigationController?.popViewController(animated: true)
           }))
           self.present(alert, animated: true, completion: nil)
       }
}



extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Roboto", size: 14)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
