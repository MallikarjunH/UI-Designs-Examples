//
//  ConsultOnlineSlots_Video.swift
//  VidalHealth
//
//  Created by mallikarjun on 27/11/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class ConsultOnlineSlots_Video: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var bookAppointmentButtonOutlet: UIButton!
    
    var selectedSlotString:String? = "0"
    var slotsArrayForTheDay:[String] = ["6:00 pm"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        bookAppointmentButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREY_COLOR)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.preveousDateSelection(notification:)), name: Notification.Name("preveousDateClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.nextDateSelection(notification:)), name: Notification.Name("nextDateClicked"), object: nil)
        
    }
    
    @objc func preveousDateSelection(notification: Notification) {
        
        self.slotsArrayForTheDay = []
        //show preveous slots
        print("Clicked on Preveous Date: I am in Video")
        if let slotsOfArray = notification.userInfo?["slots"] as? NSArray {
            
            // print("Slots of Video Consult: \(slotsOfArray)")
            let slotsArrayForTheDayTemp = slotsOfArray as! [String]
            
            for slots in slotsArrayForTheDayTemp {
                let updatedSlot = slots.replacingOccurrences(of: ".", with: ":")
                self.slotsArrayForTheDay.append(updatedSlot)
            }
        }
        
        if GlobalVariables.sharedManager.slotsAvailableForVideoConsult == "y" {
            
        }else{
             self.slotsArrayForTheDay = []
        }
        self.mainCollectionView.reloadData()
    }
    
    @objc func nextDateSelection(notification: Notification) {
        
        self.slotsArrayForTheDay = []
        //show next slots
        print("Clicked on Next Date: I am in Video")
        if let slotsOfArray = notification.userInfo?["slots"] as? NSArray {
            
            // print("Slots of Video Consult: \(slotsOfArray)")
            let slotsArrayForTheDayTemp = slotsOfArray as! [String]
            
            for slots in slotsArrayForTheDayTemp {
                let updatedSlot = slots.replacingOccurrences(of: ".", with: ":")
                self.slotsArrayForTheDay.append(updatedSlot)
            }
        }
        
        if GlobalVariables.sharedManager.slotsAvailableForVideoConsult == "y" {
            
        }else{
             self.slotsArrayForTheDay = []
        }
        self.mainCollectionView.reloadData()
    }
    
    //MARK: CollectionView Deleegate mthods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (self.slotsArrayForTheDay.count == 0) {
            self.mainCollectionView.setEmptyMessage("No slots are available")
        } else {
             self.mainCollectionView.restore()
        }
        return self.slotsArrayForTheDay.count
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 5, 0, 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeSelectionCollectionCell3Id", for: indexPath) as! TimeSelectionCollectionCell3
        
        cell.timeButton.setTitle(self.slotsArrayForTheDay[indexPath.item], for:.normal)
        cell.timeButton.tag = indexPath.row
        cell.timeButton.addTarget(self, action: #selector(slotSelectionAction(sender:)), for: .touchUpInside)
        
        cell.timeButton.setTitle(self.slotsArrayForTheDay[indexPath.item], for:.normal)
        cell.timeButton.tag = indexPath.row
        cell.timeButton.addTarget(self, action: #selector(slotSelectionAction(sender:)), for: .touchUpInside)
        
        let greyColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.TEXT_GREY_COLOR)
        let greenColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.BUTTON_GREEN_COLOR)
        
        
        if(selectedSlotString == self.slotsArrayForTheDay[indexPath.row])
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
    
    //MARK: Remove Observer
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("nextDateClicked"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("preveousDateClicked"), object: nil)
    }
    
    //MARK: Slot selection action methods
    @objc func slotSelectionAction(sender: UIButton)
    {
        print("Selected Slot is: \(self.slotsArrayForTheDay[sender.tag])")
        GlobalVariables.sharedManager.selectedTimeSlotForOnlineConsult = self.slotsArrayForTheDay[sender.tag]
        
        if(selectedSlotString == self.slotsArrayForTheDay[sender.tag])
        {
            selectedSlotString = "0"
        }
        else
        {
            selectedSlotString = self.slotsArrayForTheDay[sender.tag]
        }
        
        self.mainCollectionView.reloadData()
        validateBookAppoitmentButton()
    }
    
    func validateBookAppoitmentButton()
    {
        if  selectedSlotString != "0"
        {
            bookAppointmentButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREEN_COLOR)
        }
        else
        {
            bookAppointmentButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREY_COLOR)
        }
    }
    
    
    @IBAction func bookAppointmentButtonClicked(_ sender: Any) {
        
        if  selectedSlotString != "0"
        {
            print("Clicked on Book appointment button")
            GlobalVariables.sharedManager.appointmentForOpdOrOnline = "OnlineConsult"
            GlobalVariables.sharedManager.consultationType = "videoConsult"
            GlobalVariables.sharedManager.isCameForTalkNowOptionInOnlineConsult = "n"
            
            NotificationCenter.default.post(name: Notification.Name("moveToUserProfileSelection"), object: nil)
        }
        else
        {
             //slot not selected
        }
    }
    
}
