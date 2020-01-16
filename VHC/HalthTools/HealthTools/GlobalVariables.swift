//
//  GlobalVariables.swift
//  VidalHealth
//
//  Created by mallikarjun on 10/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import Foundation

class GlobalVariables {
    
    //username
    var loggedUserName:String = ""
    
    //patinet slug
    var patientSlug:String = ""
    
    //BBT
    var babyMonth:String?
    var babyMonthImg:String?
    var patientInfoDataDictionary:[String:Any]?
    // var uploadedImageFoTheMonth:Data?
    var babyImgUrl:String?
    
    //BFC
    var genderTypeForBFC:String?
    // var userDataArrayForBFC:[String]?
    var fitnessResult:String = ""
    var totalBodyFatPercentageValue:Double = 0.0
    
    //HP
    var heightArrayOfFatherAndMotherForHp:[String]?
    
    //calorie counter
    var bmrValue:String = ""
    var foodName:String = ""
    var foodNdbno:String = ""
    
    //Health Logs
    var fromVCNameInHealthBlogs:String?
    
    //bp
    var dateForBPArray:[String]?
    //  var riskLevelForBPArray:[String]?
    // var imageUrlForBPArray:[String]?
    var systolicBpArray:[Double]?
    var diastolicBpArray:[Double]?
    var heartRateArray:[Double]?
    
    //bs
    var dateForBSArray:[String]?
    var fastingArray:[Double]?
    var randomBpArray:[Double]?
    var postPrandialArray:[Double]?
    
    //thyroid
    var dateForThyroidArray:[String]?
    var serumThyroxineArray:[Double]?
    var serumTriodothyronineArray:[Double]?
    var serumThyrotropinArray:[Double]?
    
    //Lipid Profile
    var dateForLipidProfileArray:[String]?
    var totalCholesterolArray:[Double]?
    var hdlArray:[Double]?
    var ldlArray:[Double]?
    
    //data to send view logs
    var dateValue:String = ""
    var logValue1:String = ""
    var logValue2:String = ""
    var logValue3:String = ""
    
    //consult online
    var isFromSeatchOrClinicVC:String = ""
    var clinicPermalink:String = ""
    var consultationType:String = ""
    
    var selectedDoctorsFullName:String = ""
    var selectedDoctorsQualification:String = ""
    var selectedDoctorsSpecialityType:String = ""
    var selectedDoctorsPofilePicture:String = ""
    var selectedDoctorsSpecialistSlugValue:String = ""
    
    var selectedDateForOnlineConsult:String = ""
    var selectedTimeSlotForOnlineConsult:String = ""
    
    var appointmentForOpdOrOnline:String = ""

    var slotsAvailableForTextConsult:String = ""
    var slotsAvailableForAudioConsult:String = ""
    var slotsAvailableForVideoConsult:String = ""
    
    var onlineConsultationFees:String = ""
    
    var specialityTypeForOnlineConsult:String = ""
    
    //Talk now
    var isCameForTalkNowOptionInOnlineConsult:String = ""
    
    var talkNowAvailabilityForAudioConsult:Int = 2
    var talkNowAvailabilityForVideoConsult:Int = 2
    
    var talkNowOnlineConsultChatRate:String = ""
    var talkNowOnlineConsultAudioRate:String = ""
    var talkNowOnlineConsultVideoRate:String = ""
    
    var reasonForConsultationOnline:String = ""
    
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
    
  
    
  
    
}

