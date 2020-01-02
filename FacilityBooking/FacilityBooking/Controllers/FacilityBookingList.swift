//
//  FacilityBookingList.swift
//  FacilityBooking
//
//  Created by mallikarjun on 02/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import UIKit

class FacilityBookingList: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var boookingFacilitiesNameArray = ["Club house", "Tennis Court"]
    var boookingFacilitiesImgArray = ["clubHouse", "tenis.jpg"]
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Tableview Datasource and Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return boookingFacilitiesNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FacilityBookingTableViewCellId", for: indexPath) as! FacilityBookingTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        
        cell.facilityNameLabel.text = boookingFacilitiesNameArray[indexPath.row]
        cell.facilityImage.image = UIImage(named: boookingFacilitiesImgArray[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 115.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        let slotsDetails = self.storyboard!.instantiateViewController(withIdentifier: "FacilityDetailsVCId") as? FacilityDetailsVC
        slotsDetails?.tileString = boookingFacilitiesNameArray[indexPath.row]
        
        if (navigationController?.topViewController is FacilityDetailsVC) {
            return
        } else {
            navigationController?.pushViewController(slotsDetails!, animated: true)
        }
    }
}
