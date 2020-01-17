//
//  Feed_Comments_view.swift
//  VidalHealth
//
//  Created by swathi.nandy on 25/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class Feed_Comments_view: UIViewController, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var commentsTextView: UIView!
    @IBOutlet weak var commentTextfiled: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var commentsTableview: UITableView!
    @IBOutlet weak var commentsviewLenthFromBottom: NSLayoutConstraint!
    
//    @property(nonatomic,weak)IBOutlet NSLayoutConstraint *LastNameTextFieldHeight;
    
     var feedArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableview.delegate = self
        commentsTableview.dataSource = self
        commentsTableview.allowsSelection = true
        commentsTableview.estimatedRowHeight = 200
        commentsTableview.rowHeight = UITableViewAutomaticDimension
        
        commentsTextView.layer.cornerRadius = 30
        commentsTextView.layer.borderWidth = 1
        commentsTextView.layer.borderColor = UIColor.gray.cgColor
        
        feedArray.append("")
        feedArray.append("")
        feedArray.append("")
        feedArray.append("")
        commentTextfiled.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    //MARK: keyboard methods

    @objc func keyboardWillShow(_ notification:Notification) {
        
        
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
//        if self.view.frame.origin.y == 0{
            commentsviewLenthFromBottom.constant = +keyboardFrame.height
            
            //self.view.frame.origin.y -= keyboardFrame.height
            
          //  self.commentsTableview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - keyboardFrame.height - 130)
       // }
        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            self.commentsTableview.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height+30, 0)
//        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
//        guard let userInfo = notification.userInfo else {return}
//        guard let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {return}
//        let keyboardFrame = keyboardSize.cgRectValue
        
        //if self.view.frame.origin.y != 0{
            
            commentsviewLenthFromBottom.constant = 10
            
            
            //self.view.frame.origin.y += keyboardFrame.height
            
            //self.commentsTableview.frame = CGRect(x: 0, y: 70, width: self.view.frame.width, height: self.view.frame.height - 70 - 60)
        //}
        
//        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
//            self.commentsTableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
//        }
    }
    
   
    
     //MARK: textfied methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

    //MARK: Table methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 160
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.feedArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let feedCommentsCellIdentifier = "FeedCommentsCellIdentifier"
        let feedCell : FeedCommentsCell = tableView.dequeueReusableCell(withIdentifier: feedCommentsCellIdentifier, for: indexPath) as! FeedCommentsCell
        return feedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: button Actions
    @IBAction func backButtonAction(sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func emergencyButtonAction(sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "TPAStoryboard", bundle: nil)
        let emergencyVC: EmergencyScreen = storyBoard.instantiateViewController(withIdentifier: "EmergencyScreen") as! EmergencyScreen
        if ((self.navigationController?.topViewController?.isKind(of: EmergencyScreen.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(emergencyVC, animated: true)
        }
    }
    
    @IBAction func notificationButtonAction(sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let notificationVC = storyBoard.instantiateViewController(withIdentifier: "Notifications") as! Notifications
        if ((self.navigationController?.topViewController?.isKind(of: Notifications.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
    }
    @IBAction func searchButtonAction(sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let searchVC: SearchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        if ((self.navigationController?.topViewController?.isKind(of: SearchViewController.classForCoder()))!) {
            return
        } else {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
