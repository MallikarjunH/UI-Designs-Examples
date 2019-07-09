//
//  HeightPickerPopUp.swift
//  Baby Height Predictor
//
//  Created by mallikarjun on 05/07/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit

protocol HeightSelectionPopUpVCDelegate: class {
    func SuggistionPopUpSelected(_ index: Int, _ selectedOption: String)
}

class HeightPickerPopUp: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet  weak var maintableView: UITableView!
    
    weak var suggistionPopUpDelegate: HeightSelectionPopUpVCDelegate?
    
    var heightValueArray: [String] = ["1","2","3","4","5"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // It's required to set content size of popup.
        contentSizeInPopup = CGSize(width: 300, height: 400)
        landscapeContentSizeInPopup = CGSize(width: 400, height: 200)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.maintableView.reloadData()
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeightSelectionPopUpCell1Id", for: indexPath) as! HeightSelectionPopUpCell1
        cell.heightLabel.text = heightValueArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heightValueArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let str : String = heightValueArray[indexPath.row]
        
        self.suggistionPopUpDelegate?.SuggistionPopUpSelected(indexPath.row, str)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

}
