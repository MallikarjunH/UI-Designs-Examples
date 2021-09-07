//
//  ConsultOnlineCells.swift
//  VidalHealth
//
//  Created by mallikarjun on 17/10/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import Foundation
import UIKit

class ConsultOnlineCell1: UITableViewCell {
    
    
    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainBGView.layer.cornerRadius = 5.0 //check
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class SearchDetailsSpcialityCell: UICollectionViewCell {
    
    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var labelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainBGView.layer.cornerRadius = 5.0
    }
    
}

class TimeSelectionCollectionCell1: UICollectionViewCell{
    
    @IBOutlet weak var timeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let greyColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.TEXT_GREY_COLOR)
        
        timeButton.layer.borderColor = greyColor.cgColor
        timeButton.layer.borderWidth = 2
        timeButton.titleLabel?.textColor = greyColor
        
    }
}

class TimeSelectionCollectionCell2: UICollectionViewCell{
    
    @IBOutlet weak var timeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let greyColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.TEXT_GREY_COLOR)
        
        timeButton.layer.borderColor = greyColor.cgColor
        timeButton.layer.borderWidth = 2
        timeButton.titleLabel?.textColor = greyColor
        
    }
}

class TimeSelectionCollectionCell3: UICollectionViewCell{
    
    @IBOutlet weak var timeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let greyColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.TEXT_GREY_COLOR)
        
        timeButton.layer.borderColor = greyColor.cgColor
        timeButton.layer.borderWidth = 2
        timeButton.titleLabel?.textColor = greyColor
        
    }
}

class DoctorsListCell: UITableViewCell {
    
    @IBOutlet weak var mainBGVIew1: UIView!
    @IBOutlet weak var mainBGVIew2: UIView!
    
    @IBOutlet weak var doctorsImage: UIImageView!
    @IBOutlet weak var doctorsNameLabel: UILabel!
    @IBOutlet weak var doctorsSpecialityLabel: UILabel!
    @IBOutlet weak var doctorsEducationLabel: UILabel!
    @IBOutlet weak var doctorsExperienceLabel: UILabel!
    @IBOutlet weak var availableForLabel: UILabel!
    
    @IBOutlet weak var availableForTextImgView: UIImageView!
    @IBOutlet weak var availableForCallImgView: UIImageView!
    @IBOutlet weak var availableForVideoImgView: UIImageView!
    
    @IBOutlet weak var doctorsAvailableTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainBGVIew1.roundTop(radius: 5.0)
        mainBGVIew2.roundBottom(radius: 5.0)
        
        doctorsNameLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
        doctorsSpecialityLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        doctorsEducationLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        doctorsExperienceLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        availableForLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        
        doctorsAvailableTimeLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class TalkeNowTextMsgCell: UITableViewCell {
    
    @IBOutlet weak var textMsgImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class TalkeNowAudioCallCell: UITableViewCell {
    
    @IBOutlet weak var audioCallImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class TalkeNowVideoCallCell: UITableViewCell {
    
    @IBOutlet weak var videoCallImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class MyPrescriptionCell: UITableViewCell {
    
    @IBOutlet weak var mainBGView: UIView!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var consultedByLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var viewButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainBGView.layer.cornerRadius = 5.0
        
        patientNameLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
        consultedByLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        doctorNameLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        dateLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class MyPrescriptionDetailCell1: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class OnlineConsultHistoryListCell: UITableViewCell {
    
    @IBOutlet weak var mainBGView1: UIView!
    @IBOutlet weak var mainBGView2: UIView!
    
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorsSpecialityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var consultationTypeImage: UIImageView!
    
    @IBOutlet weak var consultFeeLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    
    @IBOutlet weak var labelForTalkNow: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainBGView1.roundTop(radius: 5.0)
        mainBGView2.roundBottom(radius: 5.0)
        
        doctorNameLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
        doctorsSpecialityLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        timeLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        consultFeeLabel.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        feeLabel.textColor = UIColor(red: 0.45, green: 0.75, blue: 0.26, alpha: 1)
        labelForTalkNow.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class OnlineConsultSearchCell: UITableViewCell {
    
    @IBOutlet weak var searchLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class OnlineConsultSearchResultCell: UITableViewCell {
    
    @IBOutlet weak var specialistTypeLabel: UILabel!
    @IBOutlet weak var descriptionLabel1: UILabel!
    @IBOutlet weak var descriptionLabel2: UILabel!
    @IBOutlet weak var descriptionLabel3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        specialistTypeLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.87)
        
        descriptionLabel1.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        descriptionLabel2.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        descriptionLabel3.textColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 0.70)
        
        descriptionLabel1.lineBreakMode = .byWordWrapping
        descriptionLabel2.lineBreakMode = .byWordWrapping
        descriptionLabel3.lineBreakMode = .byWordWrapping
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class ConsultOnlinePaymentSuccessCell1: UITableViewCell {
    
    
    @IBOutlet weak var sucessOrFailureImg: UIImageView!
    
    @IBOutlet weak var appointmentStatusLabel: UILabel!
    @IBOutlet weak var messageDescriptionLabel: UILabel!
    @IBOutlet weak var consultationFeeLabel: UILabel!
    
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientMobileNumber: UILabel!
    @IBOutlet weak var patientEmailLabel: UILabel!
    
    
    @IBOutlet weak var consultationFeeTitleLabel: UILabel!
    @IBOutlet weak var payOnlineLabel: UILabel!
    @IBOutlet weak var patientDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // descriptionLabel1.lineBreakMode = .byWordWrapping
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class ConsultOnlinePaymentSuccessCell2: UITableViewCell {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var answerQuestionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // descriptionLabel1.lineBreakMode = .byWordWrapping
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class ConsultOnlineSummaryCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // descriptionLabel1.lineBreakMode = .byWordWrapping
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class UploadFilesInHistoryCell1: UITableViewCell {
    
    
    @IBOutlet weak var fileImage: UIImageView!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileUploadedTimeLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class UploadFilesInHistoryCell2: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}


extension UIView {
    
    func roundTop(radius:CGFloat = 5){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundBottom(radius:CGFloat = 5){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
}
