//
//  AppUtilitiesSwift.swift
//  VidalHealth
//
//  Created by swathi.nandy on 07/06/19.
//  Copyright © 2019 Clean Bill of Health Private Limited. All rights reserved.
//

import UIKit

class AppUtilitiesSwift: NSObject {
    
    static let FILTER_TYPE_DISTANCE = "By Distance"
    static let FILTER_TYPE_COST = "Cost"
    static let FILTER_TYPE_SPECIALITIES = "Specialities"
    
    
    static let PATIENT_TYPE_SELF = "self"
    static let PATIENT_TYPE_OTHER = "other"
    static let PATIENT_TYPE_SOMEONEELSE = "Some one else"
    
    static let PAYMENT_ONLINE = "online Payment"
    static let PAYMENT_AT_HOSPITAL = "Payment at hospital"
    
    
    static let K_PATIENT_FIRST_NAME_BA = "K_PATIENT_FIRST_NAME_BA"
    static let K_PATIENT_LAST_NAME_BA = "K_PATIENT_LAST_NAME_BA"
    static let K_PATIENT_DOB_BA = "K_PATIENT_DOB_BA"
    static let K_PATIENT_GENDER_BA = "K_PATIENT_GENDER_BA"
    static let K_PATIENT_PHONE_NUMBER_BA = "K_PATIENT_PHONE_NUMBER_BA"
    static let K_PATIENT_EMAIL_BA = "K_PATIENT_EMAIL_BA"
    static let K_PATIENT_SLUG_BA = "K_PATIENT_SLUG_BA"
    
    
    
    var selfVCPatientObject: VCPatient?
    var patientInfoObject:[String:Any] = [:]
    var appointmentBookingFor: String?
     var OPD_OTP: String?
    var selected_lat_long: String?
    var selectedDoctorData:[String:Any] = [:]
    var appointmentDateAndTime: String?
    var appoitmentResponse:[String:Any] = [:]
    
    //MARK: - hexa colors
    static let BUTTON_GREEN_COLOR = "#72bf43"
    static let TEXT_GREY_COLOR = "#4a4a4a"
    static let BUTTON_GREY_COLOR = "#bcc0d0"
    static let RED_COLOR = "#ef2121"
    static let LIGHT_GREY_BACKGROUND_COLOR = "#f3f4f8"
    
    
    let heightValuesArray:[String] =  ["4'0\"","4'1\"","4'2\"","4'3\"","4'4\"","4'5\"","4'6\"","4'7\"","4'8\"","4'9\"","4'10\"","4'11\"","5'0\"","5'1\"","5'2\"","5'3\"","5'4\"","5'5\"","5'6\"","5'7\"","5'8\"","5'9\"","5'10\"","5'11\"","6'0\"","6'1\"","6'2\"","6'3\"","6'4\"","6'5\"","6'6\"","6'7\"","6'8\"","6'9\"","6'10\"","6'11\"","7'0\"","7'1\"","7'2\"","7'3\"","7'4\"","7'5\""]
    
    static let sharedUtilityInstance: AppUtilitiesSwift? = {
        var instance = AppUtilitiesSwift()
        return instance
    }()
    
    class func sharedUtility() -> AppUtilitiesSwift? {
        return sharedUtilityInstance
    }
    
    
    
    class func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        var valid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        if valid {
            valid = !email.contains("Invalid email id")
        }
        return valid
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    class func get_Height_array() -> [String] {
        return AppUtilitiesSwift.sharedUtility()!.heightValuesArray
    }
    
    
    class func saveSelectedPatientDetails(info: [String:Any]?)
    {
        AppUtilitiesSwift.sharedUtility()!.patientInfoObject = info!
    }
    class func getSelectedPatientDetails() -> [String:Any]? {
        return AppUtilitiesSwift.sharedUtility()!.patientInfoObject
        
        
    }
    class func saveSelectedAppoitmentDateAndTime(dateAndTime: String?) {
        AppUtilitiesSwift.sharedUtility()!.appointmentDateAndTime = dateAndTime
    }
    class func getSelectedAppoitmentDateAndTime() -> String? {
        return AppUtilitiesSwift.sharedUtility()!.appointmentDateAndTime
    }
    
    //#MARK --------- save Other/self/dependent -------------
    class func save_other_self_dependent(type: String?) {
        AppUtilitiesSwift.sharedUtility()!.appointmentBookingFor = type
    }
    
    class func get_other_self_dependent() -> String? {
        return AppUtilitiesSwift.sharedUtility()!.appointmentBookingFor
    }
    
    //#Mark --------- save OPD OTP -----------
    class func save_OPD_OTP(OTP: String?) {
           AppUtilitiesSwift.sharedUtility()!.OPD_OTP = OTP
       }
       
       class func get_OPD_OTP() -> String? {
           return AppUtilitiesSwift.sharedUtility()!.OPD_OTP
       }
    
    //#MARK --------- save Other/self/dependent -------------
    class func save_selected_place_lat_long(lat_lon: String?) {
        AppUtilitiesSwift.sharedUtility()!.selected_lat_long = lat_lon
    }
    
    class func get_selected_place_lat_long() -> String? {
        return AppUtilitiesSwift.sharedUtility()!.selected_lat_long
    }
    
    class func convertDateFormateFrom(fromFormate: String?, toFormate: String?, dateSring: String?) -> String?
    {
        let dateFormatterFrom = DateFormatter()
        dateFormatterFrom.dateFormat = fromFormate
        
        let dateFormatterTo = DateFormatter()
        dateFormatterTo.dateFormat = toFormate
        
        let dateRequired: NSDate? = dateFormatterFrom.date(from: dateSring!) as NSDate?
        return   dateFormatterTo.string(from: dateRequired! as Date)
        
    }
    
    class func nextAvaiableTimeTODisplay(dateOfSlot: String?) -> String?
    {
        let dateOfSlotStrim = self.convertDateFormateFrom(fromFormate: "yyyy-MM-dd HH:mm:ss", toFormate: "yyyy-MM-dd", dateSring:dateOfSlot)
        
        let TodayDAte = Date()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        let TodayDAteString = dateFormatterPrint.string(from: TodayDAte)
        var textTODisplay = ""
        
        
        let tomorrowDate = TodayDAte.tomorrow!
        
        if(TodayDAteString == dateOfSlotStrim)
        {
            textTODisplay = "today" + " " + self.convertDateFormateFrom(fromFormate: "yyyy-MM-dd HH:mm:ss", toFormate: "hh:mm a", dateSring:dateOfSlot)!
        }
        else if(dateFormatterPrint.string(from: tomorrowDate) == dateOfSlotStrim)
        {
            textTODisplay = "tomorrow" + " " + self.convertDateFormateFrom(fromFormate: "yyyy-MM-dd HH:mm:ss", toFormate: "hh:mm a", dateSring:dateOfSlot)!
        }
        else
        {
            textTODisplay = self.convertDateFormateFrom(fromFormate: "yyyy-MM-dd HH:mm:ss", toFormate: "dd/MM/yyyy hh:mm a", dateSring:dateOfSlot)!
        }
        
        return    "Next appointment available is " + textTODisplay
        
    }
    
    
    class func getGenderToDisplay(genderCode: String?) -> String?
    {
        if(genderCode == "M")
        {
            return "Male"
        }
        else if(genderCode == "F")
        {
            return "Female"
        }
        else if(genderCode == "O")
        {
            return "Other"
        }
        else
        {
            return ""
        }
        
    }
    
    
    
    //#MARK --------- save selected Doctor  deatils -------------
    
    class func saveSelectedDoctorDetails(aDoctor: [String:Any]?) {
        AppUtilitiesSwift.sharedUtility()!.selectedDoctorData = aDoctor!
    }
    
    class func getSelectedDoctorDetails() -> [String:Any]? {
        return AppUtilitiesSwift.sharedUtility()!.selectedDoctorData
    }
    
    
    class func saveAppoitmentResponse(response: [String:Any]?) {
        AppUtilitiesSwift.sharedUtility()!.appoitmentResponse = response!
    }
    
    class func getAppoitmentResponse() -> [String:Any]? {
        return AppUtilitiesSwift.sharedUtility()!.appoitmentResponse
    }
    class func getData(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        var imageURL:String = url // valid
        
        if(imageURL.character(at: 1) == "/")
        {
            imageURL = String(imageURL .dropFirst())
        }
        
        let imgFullUrl = AppUtilities.getBaseURL() + imageURL //form full URL
        let imgURL = URL(string: imgFullUrl)
        
        URLSession.shared.dataTask(with: imgURL!, completionHandler: completion).resume()
    }

    
    //    class func getDayOfWeek(today:String) -> Int? {
    //        let formatter  = DateFormatter()
    //        formatter.dateFormat = "yyyy-MM-dd"
    //        guard let todayDate = formatter.date(from: today) else { return nil }
    //        let myCalendar = Calendar(identifier: .gregorian)
    //        let weekDay = myCalendar.component(.weekday, from: todayDate)
    //        return weekDay
    //    }
    
    class func getDayOfWeekString(today:String)->String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let todayDate = formatter.date(from: today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
            let myComponents = myCalendar.components(.weekday, from: todayDate)
            let weekDay = myComponents.weekday
            switch weekDay {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                return ""
            }
        } else {
            return nil
        }
    }
    
}

extension Date {
    
    var tomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    var dayAfterTomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 2, to: self)
    }
    var thiredDay: Date? {
        return Calendar.current.date(byAdding: .day, value: 3, to: self)
    }
    var fourthDay: Date? {
        return Calendar.current.date(byAdding: .day, value: 4, to: self)
    }
    var fifthDay: Date? {
        return Calendar.current.date(byAdding: .day, value: 5, to: self)
    }
    var sixthDay: Date? {
        return Calendar.current.date(byAdding: .day, value: 6, to: self)
    }
    var seventhDay: Date? {
        return Calendar.current.date(byAdding: .day, value: 7, to: self)
    }
}



//extension Date {
//    func dayNumberOfWeek() -> Int? {
//        return Calendar.current.dateComponents([.weekday], from: self).weekday
//    }
//}
