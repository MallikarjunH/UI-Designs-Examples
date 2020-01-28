//
//  InboxViewController.swift
//  Faveo Helpdesk Community
//
//  Created by Mallikarjun on 05/01/19.
//  Copyright © 2019 Ladybird Web Solution. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftHEXColors
import RMessage

class DataList{
    let ticketnumber:String
    let username:String
    let useremail:String
    let ticketsubject:String
    let userprofilepicture:URL
    let prioritycolor:String
    let ticketupdateddate:String
    let overduedate:String
    let ticketstatus:String
    let ticketid:Int
    init(ticketNumber:String,userName:String,Emails:String,ticketSubject:String,userProfilePicture:URL,priorityColor:String, ticketUpdatedDate:String, overDueDate:String, ticketStatus:String,ticketId:Int) {
        self.ticketnumber = ticketNumber
        self.username = userName
        self.useremail = Emails
        self.ticketsubject = ticketSubject
        self.userprofilepicture = userProfilePicture
        self.prioritycolor = priorityColor
        self.ticketupdateddate = ticketUpdatedDate
        self.overduedate = overDueDate
        self.ticketstatus = ticketStatus
        self.ticketid = ticketId
    }
    
}

class InboxViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,RMControllerDelegate {
    
    
    //  var page = 1
    
    var selectedPath:IndexPath?
    var selectedTicketId:String?
    var selectedIdCount:Int?
    
    //RMessage
    private let rControl = RMController()
    
    var sampleArray:Array<String> = Array<String>()
    var dataArray = [DataList]()
    var totalDataArray = [DataList]()
    var totalDataArray2 = [DataList]()
    
    var nextPageURL:String?
    var currentPage:Int?
    var totalTickets:Int?
    var totalPages:Int?
    
    
    var nameArray = [String]()
    var idArray = [Int]()
    
    //Priority
    var prioritiesNamesArray = [String]()
    var prioritiesIdArray = [Int]()
    //HelpTopcis
    var helptopicsNamesArray = [String]()
    var helptopicsIdArray = [Int]()
    //Ticket Source
    var ticketSourcesNamesArray = [String]()
    var ticketSourcesIdArray = [Int]()
    //SLA
    var slaNamesArray = [String]()
    var slaIdsArray = [Int]()
    
    //   var ticketIdArray = [String]()
    
    
    //create an instance of the UIRefreshControl class
    private let refreshControl = UIRefreshControl()
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to set black background color mask for Progress view
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.dismiss()
        
        //RMessage
        rControl.presentationViewController = self
        rControl.delegate = self
        
        // Do any additional setup after loading the view.
        setUpSideMenuBar()
        
        //tableViewcell
        tableViewOutlet.register(UINib(nibName: "TicketTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableViewOutlet.refreshControl = refreshControl
        } else {
            tableViewOutlet.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        self.configureRefreshControl()
        
        
        let valueFromRefreshTokenValue: String? = userDefaults.string(forKey: "valueFromRefreshToken")
        let userRoleValue: String? = userDefaults.string(forKey: "userRole")
        
        if userRoleValue == "user"{
            
            userDefaults.set("", forKey: "userRole")
            showLogoutAlert(title: "Access Denied", message: "Your role has beed changed to user. Contact to your Admin and try to login again.", vc: self)
            SVProgressHUD.dismiss()
        }
        else if valueFromRefreshTokenValue == "Method not allowed" || valueFromRefreshTokenValue == "method not allowed"{
            
            userDefaults.set("", forKey: "valueFromRefreshToken")
            showLogoutAlert(title: "Access Denied", message: "Your HELPDESK URL were changed, contact to Admin and please log back in.", vc: self)
            SVProgressHUD.dismiss()
        }
        else if valueFromRefreshTokenValue == "invalid_credentials" || valueFromRefreshTokenValue == "Invalid credential"{
            
            userDefaults.set("", forKey: "valueFromRefreshToken")
            showLogoutAlert(title: "Access Denied", message: "Your Login credentials were changed or Your Account is Deactivated, contact to Admin and please log back in.", vc: self)
            SVProgressHUD.dismiss()
        }
        else{
            SVProgressHUD.show(withStatus: "Getting Tickets")
            // call get ticket api
            getTickets()
            // call get-dependency method api call
            getDependeciesAPICall()
            
        }
        
    } // End of viewDidLoad method
    
    
    //setting up side-menu bar
    func setUpSideMenuBar(){
        
        if revealViewController() != nil{
            
            sideMenuButton.target = revealViewController()
            sideMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            revealViewController()?.rearViewRevealWidth = 320 //280
            // revealViewController()?.rightViewRevealWidth = 160
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
        
    }// End of setUpSideMenuBar method
    
    
    
    
    func getTickets(){
        
        var getInboxTicketsURL = userDefaults.string(forKey: "baseURL")
        getInboxTicketsURL?.append("api/v1/helpdesk/inbox")
        
        let tokenValue = userDefaults.string(forKey:"token")
        // print("token=>",tokenValue!)
        
        requestGETURL(getInboxTicketsURL!, params: ["token":tokenValue as AnyObject ],  success: { (data) in
            
            
            //  print("Inbox JSON is: ",data)
            
            let msg = data["message"].stringValue
            print("Message is: ",msg)
            
            if msg == "Token has expired"{
                
                tokenRefreshMethod()
                self.getTickets()
                // self.getTickets(pageNumber: page)
            }
            else{
                
                self.nextPageURL = data["next_page_url"].stringValue
                self.currentPage = data["current_page"].intValue
                self.totalTickets = data["total"].intValue
                self.totalPages = data["last_page"].intValue
                
                var dataIterator = 0
                
                self.dataArray.removeAll()
                self.totalDataArray.removeAll()
                
                for dataList in data["data"].arrayValue{
                    
                    let ticketSubject = dataList["title"].stringValue
                    let ticketUpdatedDate1 = dataList["updated_at"].stringValue
                    let ticketOverdueDate = dataList["overdue_date"].stringValue
                    let ticketNumber = dataList["ticket_number"].stringValue
                    let firstname = dataList["first_name"].stringValue
                    let lastname = dataList["last_name"].stringValue
                    
                    var userFullName:String
                    
                    if firstname == "" && lastname == ""{
                        userFullName = "Unassigned"
                    }else{
                        userFullName = "\(firstname)\(" ") \(lastname)"
                    }
                    
                    let email = dataList["email"].stringValue
                    let userProfilePic1 = dataList["profile_pic"].url
                    let ticketPriority = dataList["priority_color"].stringValue
                    
                    
                    let ticketId1 = dataList["id"].intValue
                    let ticketStatus1 = dataList["ticket_status_name"].stringValue
                    
                    self.dataArray.append(DataList(ticketNumber: ticketNumber, userName: userFullName, Emails: email, ticketSubject: ticketSubject, userProfilePicture:userProfilePic1!,priorityColor:ticketPriority, ticketUpdatedDate:ticketUpdatedDate1, overDueDate:ticketOverdueDate, ticketStatus:ticketStatus1, ticketId:ticketId1))
                    
                    self.totalDataArray = self.dataArray
                    
                    dataIterator = dataIterator + 1
                    
                    
                } // End - for dataList
                
                
                DispatchQueue.main.async {
                    self.tableViewOutlet.reloadData()
                    self.refreshControl.endRefreshing()
                    SVProgressHUD.dismiss()
                }
                
            } // End of - else of if msg
            
            
            
        }) { (error) in
            
            //Example: After timeout error - The request timed out.
            print("Error From Inbox Tickets List API Call: \(error.localizedDescription)")
            
            showAlert(title: "Faveo Heldesk", message: error.localizedDescription, vc: self)
            SVProgressHUD.dismiss()
            
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        var numberOfSections:Int = 0
        
        if totalDataArray.count == 0{
            
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = NSLocalizedString("No Records..!!!", comment: "")
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
            
        }else{
            
            tableView.separatorStyle = .singleLine
            numberOfSections = 1
            tableView.backgroundView = nil
            
        }
        return numberOfSections
    }
    
    //Tells the data source to return the number of rows in a given section of a table view.
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if totalDataArray.count == 0{
            
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = NSLocalizedString("No Records..!!!", comment: "")
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
            
        }else{
            
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
            
        }
        
        if currentPage == totalPages || totalTickets == totalDataArray.count {
            return totalDataArray.count
        }
        
        return totalDataArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.selectionStyle = .none
        
        print("Array count is: ",totalDataArray.count)
        
        if indexPath.row == totalDataArray.count - 1 {
            print("nextURL is: \(nextPageURL ?? "null")")
            
            if nextPageURL != nil && !nextPageURL!.isEmpty {
                
                // loadMore()
                getNextPageTickets(nextPageUrl: nextPageURL!)
                print("There are more tickets")
            }
            else {
                print("There is no more tickets")
                
                var iconSpec = successSpec
                iconSpec.iconImage = UIImage(named: "SuccessMessageIcon")
                
                self.rControl.showMessage(
                    withSpec: iconSpec,
                    atPosition: .bottom, // .top // .bottom
                    title: "",
                    body: "All Caught Up",
                    viewController: self
                )
                
            }
        }
        
    }
    
    //Get more tickets
    func getNextPageTickets(nextPageUrl:String){
        
        let tokenValue = userDefaults.string(forKey:"token")
        print("token=>",tokenValue!)
        
        var nextURLString = nextPageUrl
        nextURLString.append("&token=")
        nextURLString.append(tokenValue!)
        
        print("Next Page URL is: \(nextURLString)")
        
        requestGETURL(nextURLString, params: nil,  success: { (data) in
            
            //  print(URLRequest.self)
            
            
            //  print("JSON is: ",data)
            
            let msg = data["message"].stringValue
            print("Message is: ",msg)
            
            if msg == "Token has expired"{
                
                tokenRefreshMethod()
                self.getNextPageTickets(nextPageUrl: self.nextPageURL!)
            }
            else{
                
                self.nextPageURL = data["next_page_url"].stringValue
                self.currentPage = data["current_page"].intValue
                self.totalTickets = data["total"].intValue
                self.totalPages = data["last_page"].intValue
                
                var dataIterator = 0
                
                for dataList in data["data"].arrayValue{
                    
                    let ticketSubject = dataList["title"].stringValue
                    let ticketUpdatedDate1 = dataList["updated_at"].stringValue
                    let ticketOverdueDate = dataList["overdue_date"].stringValue
                    let ticketNumber = dataList["ticket_number"].stringValue
                    let firstname = dataList["first_name"].stringValue
                    let lastname = dataList["last_name"].stringValue
                    
                    var userFullName:String
                    
                    if firstname == "" && lastname == ""{
                        userFullName = "Unassigned"
                    }else{
                        userFullName = "\(firstname)\(" ") \(lastname)"
                    }
                    
                    let email = dataList["email"].stringValue
                    let userProfilePic1 = dataList["profile_pic"].url
                    let ticketPriority = dataList["priority_color"].stringValue
                    
                    
                    let ticketId1 = dataList["id"].intValue
                    let ticketStatus1 = dataList["ticket_status_name"].stringValue
                    
                    
                    self.dataArray.append(DataList(ticketNumber: ticketNumber, userName: userFullName, Emails: email, ticketSubject: ticketSubject, userProfilePicture:userProfilePic1!,priorityColor:ticketPriority, ticketUpdatedDate:ticketUpdatedDate1, overDueDate:ticketOverdueDate, ticketStatus: ticketStatus1, ticketId: ticketId1))
                    
                    
                    self.totalDataArray = self.dataArray
                    // self.totalDataArray2 = self.dataArray
                    
                    dataIterator = dataIterator + 1
                    
                    
                } // End - for dataList
                
                
                // self.totalDataArray.append(contentsOf: self.totalDataArray2)
                
                DispatchQueue.main.async {
                    self.tableViewOutlet.reloadData()
                    self.refreshControl.endRefreshing()
                    SVProgressHUD.dismiss()
                }
                
            } // End of - else of if msg
            
            
            
        }) { (error) in
            
            print(error)
        }
        
    }
    
    //Asks the data source for a cell to insert in a particular location of the table view.
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == totalDataArray.count {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCellID") as? LoadingTableViewCell
            if cell == nil {
                var nib = Bundle.main.loadNibNamed("LoadingTableViewCell", owner: self, options: nil)
                cell = nib?[0] as? LoadingTableViewCell
            }
            let activityIndicator = cell?.contentView.viewWithTag(1) as? UIActivityIndicatorView
            activityIndicator?.startAnimating()
            return cell!
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TicketTableViewCell
            
            // print("Data Array is : %@", self.totalDataArray);
            
            cell.ticketNumber.text = totalDataArray[indexPath.row].ticketnumber
            cell.ticketOwnerName.text = totalDataArray[indexPath.row].username
            cell.ticketSubject.text = totalDataArray[indexPath.row].ticketsubject
            cell.setPriorityColor(color: totalDataArray[indexPath.row].prioritycolor)
            cell.timeStampLabel.text = getLocalDateTimeFromUTC(strDate: totalDataArray[indexPath.row].ticketupdateddate)
            
            //username
            let name = totalDataArray[indexPath.row].username
            //Profile Image
            let imageUrl = totalDataArray[indexPath.row].userprofilepicture
            
            if imageUrl.absoluteString.hasSuffix("system.png") || imageUrl.absoluteString.hasSuffix(".jpg") || imageUrl.absoluteString.hasSuffix(".jpeg") || imageUrl.absoluteString.hasSuffix(".png"){
                
                cell.setUserProfileimage(imageUrl: imageUrl)
            }
            else{
                
                cell.userProfilePicture.setImage(string: name, color: UIColor.colorHash(name: name), circular: true)
            }
            
            
            if compareDates(strDate:totalDataArray[indexPath.row].overduedate){
                
                cell.overDue.isHidden = false
                cell.dueToday.isHidden = true
                
            }else{
                cell.overDue.isHidden = true
                cell.dueToday.isHidden = false
            }
            
            return cell
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        GlobalVariables.sharedManager.firstName = totalDataArray[indexPath.row].username
        //   GlobalVariables.sharedManager.lastName = totalDataArray[indexPath.row].ticketnumber
        GlobalVariables.sharedManager.ticketNumber = totalDataArray[indexPath.row].ticketnumber
        GlobalVariables.sharedManager.ticketStatus = totalDataArray[indexPath.row].ticketstatus
        GlobalVariables.sharedManager.ticketId = totalDataArray[indexPath.row].ticketid
        
        GlobalVariables.sharedManager.fromVC = "inboxTickets"
        
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "TicketDetailsViewControllerID") as! TicketDetailsViewController
        
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    
    func getDependeciesAPICall(){
        
        
        var getDependecyValuesUrl = userDefaults.string(forKey: "baseURL")
        getDependecyValuesUrl?.append("api/v1/helpdesk/dependency")
        
        let tokenValue = userDefaults.string(forKey:"token")
        // print("token=>",tokenValue!)
        
        requestGETURL(getDependecyValuesUrl!, params: ["token":tokenValue as AnyObject ],  success: { (data) in
            
            
            //  print("Dependency JSON is: ",data)
            
            let msg = data["message"].stringValue
            print("Message is: ",msg)
            
            if msg == "Token has expired"{
                
                tokenRefreshMethod()
                self.getDependeciesAPICall()
            }
            else if data["error"].exists(){
                
                showAlert(title: "OOPs...", message: "Too Many Attempts. Please try after sometime.", vc: self)
                SVProgressHUD.dismiss()
            }
            else{
                
                
                //Ticket Priority
                let ticketPriorityArray = data["result"]["priorities"].array
                for priorityValue in ticketPriorityArray!{
                    
                    let name = priorityValue["priority"].stringValue
                    let idValue = priorityValue["priority_id"].intValue
                    
                    self.prioritiesNamesArray.append(name)
                    self.prioritiesIdArray.append(idValue)
                }
                
                GlobalVariables.sharedManager.priorityNamesArray = self.prioritiesNamesArray
                GlobalVariables.sharedManager.priorityIdsArray = self.prioritiesIdArray
                
                //Help Topics
                let helpTopicArray = data["result"]["helptopics"].array
                for helpTopicsValue in helpTopicArray!{
                    
                    let topicName = helpTopicsValue["topic"].stringValue
                    let topicId = helpTopicsValue["id"].intValue
                    
                    self.helptopicsNamesArray.append(topicName)
                    self.helptopicsIdArray.append(topicId)
                }
                
                GlobalVariables.sharedManager.helpTopicNamesArray = self.helptopicsNamesArray
                GlobalVariables.sharedManager.helpTopicIdsArray =  self.helptopicsIdArray
                
                //Ticket Source
                let sourcesArray = data["result"]["sources"].array
                
                for sourceValue in sourcesArray!{
                    
                    let sourceName = sourceValue["name"].stringValue
                    let sourceId = sourceValue["id"].intValue
                    
                    self.ticketSourcesNamesArray.append(sourceName)
                    self.ticketSourcesIdArray.append(sourceId)
                    
                }
                
                GlobalVariables.sharedManager.sourceNamesArray = self.ticketSourcesNamesArray
                GlobalVariables.sharedManager.sourceIdsArray =  self.ticketSourcesIdArray
                
                //SLA
                let slasArray = data["result"]["sla"].array
                for slaValue in slasArray!{
                    
                    let slaName = slaValue["name"].stringValue
                    let slaId = slaValue["id"].intValue
                    
                    self.slaNamesArray.append(slaName)
                    self.slaIdsArray.append(slaId)
                    
                }
                GlobalVariables.sharedManager.slaNameArray = self.slaNamesArray
                GlobalVariables.sharedManager.slaIdArray = self.slaIdsArray
                
                
                /*  //Ticket Status
                 let ticketStatusArray = data["result"]["status"].array
                 
                 // print(ticketStatusArray!)
                 
                 for status in ticketStatusArray!{
                 
                 /*    print(status) // it will print each status dictionary
                 //output
                 {
                 "id" : 2,
                 "name" : "Resolved"
                 }
                 
                 */
                 
                 
                 let statusName = status["name"].stringValue
                 //  let idValue = status["id"].intValue
                 
                 if statusName == "Open"{
                 
                 //  print("Open Status id : \(status["id"].intValue)")
                 GlobalVariables.sharedManager.openStatusId = status["id"].intValue
                 }
                 else if statusName == "Resolved"{
                 
                 //   print("Resolved Status id : \(status["id"].intValue)")
                 GlobalVariables.sharedManager.resolvedStatusId = status["id"].intValue
                 }
                 else if statusName == "Closed"{
                 
                 //   print("Closed Status id : \(status["id"].intValue)")
                 GlobalVariables.sharedManager.closedStatusId = status["id"].intValue
                 }
                 else if statusName == "Archived"{
                 
                 //   print("Archived Status id : \(status["id"].intValue)")
                 GlobalVariables.sharedManager.archievedStatusId = status["id"].intValue
                 }
                 else if statusName == "Deleted"{
                 
                 //   print("Deleted Status id : \(status["id"].intValue)")
                 GlobalVariables.sharedManager.deletedStatusId = status["id"].intValue
                 }
                 else if statusName == "Unverified"{
                 
                 //   print("Unverified Status id : \(status["id"].intValue)")
                 GlobalVariables.sharedManager.unverifiedStatusId = status["id"].intValue
                 }
                 else if statusName == "Request Approval"{
                 
                 //   print("Request Approval Status id : \(status["id"].intValue)")
                 GlobalVariables.sharedManager.requestForApprovalStatusId = status["id"].intValue
                 }
                 else{
                 //nothing
                 }
                 
                 //                    if status["Open"].stringValue == "Open"{
                 //
                 //                        print(status["name"].stringValue)
                 //                        print(status["count"].stringValue)
                 //                    }
                 
                 // print(self.nameArray)
                 
                 
                 }
                 */
                
                //Ticket counts
                let ticketsCountArray = data["result"]["tickets_count"].array
                
                for countValue in ticketsCountArray!{
                    
                    let countName = countValue["name"].stringValue
                    
                    //open tickets
                    
                    if countName == "Open"{
                        
                        GlobalVariables.sharedManager.openTicketsCount = countValue["count"].intValue
                        
                    }
                    else if countName == "Closed"{
                        
                        GlobalVariables.sharedManager.closedTicketsCount = countValue["count"].intValue
                        
                    }
                    else if countName == "Deleted"{
                        
                        GlobalVariables.sharedManager.deletedTicketsCount = countValue["count"].intValue
                        
                    }
                    else if countName == "unassigned"{
                        
                        GlobalVariables.sharedManager.unassignedTicketsCount = countValue["count"].intValue
                        
                    }
                    else if countName == "mytickets"{
                        
                        GlobalVariables.sharedManager.myTicketsCount = countValue["count"].intValue
                        
                    }
                    else{
                        
                        //
                    }
                    
                }
                
            }
            
        }) { (error) in
            
            print(error)
        }
        
    }
    
    
    //UIRefresh Control Configuration
    
    func configureRefreshControl(){
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .center
        
        
        let refreshing = NSAttributedString(string: NSLocalizedString("Refreshing", comment: ""), attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.paragraphStyle:paragraphStyle,
            NSAttributedString.Key.foregroundColor: UIColor.white
            ])
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        refreshControl.backgroundColor =  UIColor(red:0.46, green:0.8, blue:1.0, alpha:1.0)
        
        refreshControl.attributedTitle = refreshing
        refreshControl.tintColor = UIColor.white
        
    }
    
    
    @objc private func refreshTableView() {
        
        DispatchQueue.main.async {
            
            print("Refresh TableView Called")
            self.getTickets()
            
        }
    }
    
    
    
}



