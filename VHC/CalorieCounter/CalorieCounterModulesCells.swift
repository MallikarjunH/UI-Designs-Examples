//
//  CalorieCounterModulesCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 08/07/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class CalorieCounteIntroScreenCell: UITableViewCell {

    @IBOutlet weak var helloUserNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        helloUserNameLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        descriptionLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class CalorieCounteUsersDetailsCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var plzEnterYourDetailsLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var activityLevelTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nameTextField.tag = 5
        weightTextField.tag = 6
        heightTextField.tag = 7
        genderTextField.tag = 8
        dateOfBirthTextField.tag = 9
        activityLevelTextField.tag = 10
    
        
        //adding image icon to textField - right side
        
        // For Weight TextField
        weightTextField.rightViewMode = UITextFieldViewMode.always
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 6))
        let image1 = UIImage(named: "down_arrow_Tpa")
        imageView1.image = image1
        weightTextField.rightView = imageView1
        
        // For Height TextField
        heightTextField.rightViewMode = UITextFieldViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 6))
        let image2 = UIImage(named: "down_arrow_Tpa")
        imageView2.image = image2
        heightTextField.rightView = imageView2
        
        // For Gender TextField
        genderTextField.rightViewMode = UITextFieldViewMode.always
        let imageView3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 6))
        let image3 = UIImage(named: "down_arrow_Tpa")
        imageView3.image = image3
        genderTextField.rightView = imageView3
        
        // For DOB TextField
        dateOfBirthTextField.rightViewMode = UITextFieldViewMode.always
        let imageView4 = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        let image4 = UIImage(named: "Calendar_Tpa")
        imageView4.image = image4
        dateOfBirthTextField.rightView = imageView4
        
        //Activity Lavel TextField
        activityLevelTextField.rightViewMode = UITextFieldViewMode.always
        let imageView5 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 6))
        let image5 = UIImage(named: "down_arrow_Tpa")
        imageView5.image = image5
        activityLevelTextField.rightView = imageView5
     
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class CalorieCounterBmrCounterCell1:UITableViewCell{

    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var caloryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainCardView.layer.cornerRadius = 5
        let shadow0 = UIView(frame: CGRect(x: 0, y: 0, width: 328, height: 126))
        shadow0.clipsToBounds = false
        shadow0.layer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.10).cgColor
        shadow0.layer.shadowOpacity = 0.1
        shadow0.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainCardView.addSubview(shadow0)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
    
       // Configure the view for the selected state
   }
}


class CalorieCounterBmrCounterCell2:UITableViewCell{

    
    @IBOutlet weak var tipDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tipDescriptionLabel.lineBreakMode = .byWordWrapping
        tipDescriptionLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class CalorieCounterOptionsCell1: UITableViewCell{
    
    @IBOutlet weak var helloUserNameLabel: UILabel!
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var caloryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        helloUserNameLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        mainCardView.layer.cornerRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}


class CalorieCounterOptionsCell2: UITableViewCell{
    
    @IBOutlet weak var calorieCalculatorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        calorieCalculatorLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class CalorieCounterOptionsCell3: UITableViewCell{
    
    @IBOutlet weak var myDailyCountLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        myDailyCountLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}


class CalorieCounterCalculatorInfoCell:UITableViewCell{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class SearchFoodInCalorieCounterCell: UITableViewCell{
    
    @IBOutlet weak var foodMainLabel: UILabel!
    @IBOutlet weak var foodSubLabel: UILabel!
    @IBOutlet weak var foodCalorieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        foodCalorieLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        foodSubLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        foodCalorieLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class CalorieCounterEditFoodDetailsCell1: UITableViewCell,UITextFieldDelegate{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

class CalorieCounterEditFoodDetailsCell2: UITableViewCell,UITextFieldDelegate{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class CalorieCounterEditFoodDetailsCell3: UITableViewCell,UITextFieldDelegate{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class CalorieCounterSearchToAddFoodCell: UITableViewCell{
    
    @IBOutlet weak var foodLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class CalorieCalculatorFoodTypeCell:UITableViewCell{
    
    
    @IBOutlet weak var foodTypeNameLabel: UILabel!
    
    @IBOutlet weak var foodTypeQauntityLabel: UILabel!
    @IBOutlet weak var foodCalorieCountLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class CalorieCounterFoodDetailsCell1:UITableViewCell{
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class CalorieCounterFoodDetailsCell2:UITableViewCell{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class CalorieCounterFoodDetailsCell3:UITableViewCell{
    

    @IBOutlet weak var servingValueLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class CalorieCounterFoodDetailsCell4:UITableViewCell{
    
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var proteinValueLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Do any additional setup after loading the view, typically from a nib.
       // let circularProgress = CircularProgress(frame: CGRect(x: 95.0, y: 10.0, width: 134.0, height: 134.0))
        let circularProgress = CircularProgress(frame: CGRect(x: 0.0, y: 10.0, width: 134.0, height: 134.0))
        // circularProgress.layer.borderWidth = 5
        // circularProgress.backgroundColor = UIColor.white
        circularProgress.progressColor =  UIColor(red: 0.00, green: 0.78, blue: 0.71, alpha: 1)
        circularProgress.trackColor = UIColor.white //UIColor(red: 52.0/255.0, green: 141.0/255.0, blue: 252.0/255.0, alpha: 0.6)
        //Adding shadow effect
        circularProgress.layer.shadowColor = UIColor.gray.cgColor
        circularProgress.layer.shadowOpacity = 0.3
        circularProgress.layer.shadowOffset = CGSize.zero
        circularProgress.layer.shadowRadius = 6
        
        circularProgress.tag = 101
      
         // circularProgress.center = containerView.center
     
         circularProgress.frame.origin.x = containerView.frame.origin.x + 120
         circularProgress.frame.origin.y = containerView.frame.origin.y + 10
        
         containerView.addSubview(circularProgress)
        
         //Protenin Label
         proteinLabel.center = circularProgress.center
        
         //Protenin value label
         proteinValueLabel.center = circularProgress.center

         let positionOfProtenLabel = proteinValueLabel.frame.origin.y
         proteinValueLabel.frame.origin.y =  positionOfProtenLabel + 25
        
        //animate progress
        self.perform(#selector(animateProgress), with: nil, afterDelay: 0.3)
        
    }
    
    @objc func animateProgress() {
          let cp = containerView.viewWithTag(101) as! CircularProgress
     //   let cp = self.view.viewWithTag(101) as! CircularProgress
        cp.setProgressWithAnimation(duration: 1.0, value: 0.8)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class CalorieCounterFoodDetailsCell5:UITableViewCell{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

