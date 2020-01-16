//
//  SymptomCheckerIntroScreenCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 25/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

//MARK: SymptomChecker - Screen 1 - TableViewCell - Intro Screen

class SymptomCheckerIntroScreenCell: UITableViewCell {

    @IBOutlet weak var helloNameLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        helloNameLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        
        detailsLabel.numberOfLines = 0
        detailsLabel.lineBreakMode = .byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK: SymptomChecker - Screen 2 - TableViewCell - Add Symptom

class SymptomSearchCell: UITableViewCell {
    
    @IBOutlet weak var symptomLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         symptomLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.50)
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

//MARK: SymptomChecker - Screen 3 - TableViewCell - Symptom Details

class SymptomCheckerSymptomDetailsCell1: UITableViewCell {
    
    @IBOutlet weak var symptomQuestionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        symptomQuestionLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        
        symptomQuestionLabel.numberOfLines = 0
        symptomQuestionLabel.lineBreakMode = .byWordWrapping
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

class SymptomCheckerSymptomDetailsCell2: UITableViewCell {
    
    
     @IBOutlet weak var symptomRadioImage: UIImageView!
     @IBOutlet weak var symptomsDetailsOptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        symptomsDetailsOptionLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        symptomsDetailsOptionLabel.numberOfLines = 0
        symptomsDetailsOptionLabel.lineBreakMode = .byWordWrapping
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class SymptomsPossiblesCell:UITableViewCell{
    
    
    @IBOutlet weak var possibleConditionLabel: UILabel!
    @IBOutlet weak var percentagesLabel: UILabel!

    @IBOutlet weak var progressViewOutlet: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        percentagesLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.50)
        
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        progressViewOutlet.transform = transform
        progressViewOutlet.layer.cornerRadius = 4
        progressViewOutlet.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class SymptomCheckerPossibleQuestionsCell1:UITableViewCell{
    
    @IBOutlet weak var questionLabel1: UILabel!
    @IBOutlet weak var firstYesButton: UIButton!
    @IBOutlet weak var firstNoButton: UIButton!
    
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        questionLabel1.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        yesLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        noLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}


class SymptomCheckerPossibleQuestionsCell2:UITableViewCell{
    
    @IBOutlet weak var questionLabel2: UILabel!
    @IBOutlet weak var secondYesButton: UIButton!
    @IBOutlet weak var secondNoButton: UIButton!
    
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        questionLabel2.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        yesLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        noLabel.textColor =  UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}



class SymptomCheckerPossibleQuestionsCell3:UITableViewCell{
    
    @IBOutlet weak var questionLabel3: UILabel!
    @IBOutlet weak var thirdYesButton: UIButton!
    @IBOutlet weak var thirdNoButton: UIButton!
    
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         questionLabel3.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
         yesLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
         noLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class SymptomCheckerPossibleQuestionsCell4: UITableViewCell{
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
     var selectGenderButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectGenderButton = UIButton(type: UIButtonType.system)
        let  TextFrame:CGRect = self.genderTextField.frame
        selectGenderButton.frame = CGRect(x: TextFrame.origin.x, y: TextFrame.origin.y, width: TextFrame.size.width, height: TextFrame.size.height)
        selectGenderButton.backgroundColor = .clear
        self.contentView.addSubview(selectGenderButton)
        
        ageTextField.tag = 11
        genderTextField.tag = 12
        
        ageTextField.text = ""
        genderTextField.text = ""
        
        ageTextField.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        genderTextField.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class SymptomCheckerPossibleConditionDetailsCell: UITableViewCell{
    
    @IBOutlet weak var possibleConditionDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       possibleConditionDetailsLabel.numberOfLines = 0
       possibleConditionDetailsLabel.lineBreakMode = .byWordWrapping
       possibleConditionDetailsLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class SymptomDetailsScreenCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.textColor = UIColor(red: 0.18, green: 0.22, blue: 0.28, alpha: 1)
        descriptionLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class SymptomtagListCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var symptomTagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 15
       
    }

}
