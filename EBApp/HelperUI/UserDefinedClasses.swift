//
//  UserDefinedClasses.swift
//  EBApp
//
//  Created by Md. Afzal Hossain on 8/31/21.
//

import Foundation


public var NotificationCount: Int = 0
public var baseUrl: String = "http://27.147.159.194:33910"

public var  email: String = "maruf.alam@banglalink.net"
public var subject: String = "EB App Crash Report"
public var ReceiverFCMToken = "ased"

let legacyServerKey = "AAAAlxP0xJg:APA91bEKigiUYGa"

struct defaultsKeys {
    static let User_Id = "User_Id"
    static let Login_Name = "Login_Name"
    static let User_Name = "User_Name"
    static let User_Status = "User_Status"
    static let Is_Locked = "Is_Locked"
    static let Is_Internal = "Is_Internal"
    static let Role_Name = "Role_Name"
    static let Role_Name_Full = "Role_Name_Full"
    static let Access_Key = "Access_Key"
    static let Business_Name = "Business_Name"
    static let Last_Login_Time = "Last_Login_Time"
    static let Login_Status = "Login_Status"
    static let isDark = "isDark"
}

public var UserResults = [UserData]()
public struct UserData: Codable {
    let User_Id: Int
    let Login_Name: String
    let User_Name: String
    let User_Status: String
    let Is_Locked: String
    let Is_Internal: String
    let Role_Name: String
    let Role_Name_Full: String
    let Hash_Password: String
    let Access_Key: String
    let Business_Name: String
    let Last_Login_Time: String
    let Login_Status: String
    let success: Bool
}

public var CompanyTypeList = [CompanyTypeInfo]()
public struct CompanyTypeInfo: Decodable {
    let COMPANY_TYPE_ID: Int
    let COMPANY_TYPE_NAME: String
}

public var CompanyList = [CompanyInfo]()
public struct CompanyInfo: Codable {
    let ID: Int
    let COMPANY_NAME: String
    let COMPANY_ADDRESS: String
    let COMPANY_TYPE_ID: Int
}


public var VisitPurposeList = [VisitPurpose]()
public struct VisitPurpose: Codable {
    let ID: Int
    let VISIT_PURPOSE: String
}

public var VisitOutcomeList = [VisitOutcome]()
public struct VisitOutcome: Codable {
    let ID: Int
    let VISIT_OUTCOME: String
}

public var CheckInList = [CheckinInfo]()
public var LastCheckIn = [CheckinInfo]()
public struct CheckinInfo: Decodable {
    let SL: Int
    let COMPANY_TYPE_ID: Int
    let COMPANY_TYPE: String
    let COMPANY_ID: Int
    let COMPANY_NAME: String
    let COMPANY_ADDRESS: String
    let CHECK_IN_STATUS: Int
    let CHECK_IN_DATE: String
    
    let CHECK_IN_LATITUDE: Double
    let CHECK_IN_LONGITUDE: Double
    let CHECK_IN_ADDRESS: String
    let VISIT_PURPOSE_ID: Int
    let VISIT_PURPOSE: String
    let CHECK_OUT_STATUS: Int
    let CHECK_OUT_DATE: String?
    let CHECK_OUT_LATITUDE: Double?
    let CHECK_OUT_LONGITUDE: Double?
    let CHECK_OUT_ADDRESS: String?
    let VISIT_OUTCOME_ID: Int
    let VISIT_OUTCOME: String?
    let CHECK_OUT_REMARKS: String?
    let SUCCCESS: Bool
}

public struct CheckinInfoX: Codable {
    let COMPANY_TYPE_ID: Int
    let COMPANY_TYPE: String
    let COMPANY_ID: Int
    let COMPANY_NAME: String
    let COMPANY_ADDRESS: String
    let CHECK_IN_STATUS: Int
    let CHECK_IN_DATE: String
    
    let CHECK_IN_LATITUDE: Double
    let CHECK_IN_LONGITUDE: Double
    let CHECK_IN_ADDRESS: String
    let VISIT_PURPOSE_ID: Int
    let VISIT_PURPOSE: String
    let CHECK_OUT_STATUS: Int
    let CHECK_OUT_DATE: String?
    let CHECK_OUT_LATITUDE: Double?
    let CHECK_OUT_LONGITUDE: Double?
    let CHECK_OUT_ADDRESS: String?
    let VISIT_OUTCOME_ID: Int
    let VISIT_OUTCOME: String?
    let CHECK_OUT_REMARKS: String?
    let SUCCCESS: Bool
}


public struct CheckInHistoryX: Codable {
    let COMPANY_TYPE_ID: Int
    let COMPANY_TYPE: String
    let COMPANY_ID: Int
    let COMPANY_NAME: String
    let COMPANY_ADDRESS: String
    let CHECK_IN_STATUS: Int
    let CHECK_IN_DATE: String
    
    let CHECK_IN_LATITUDE: Double
    let CHECK_IN_LONGITUDE: Double
    let CHECK_IN_ADDRESS: String
    let VISIT_PURPOSE_ID: Int
    let VISIT_PURPOSE: String?
    let CHECK_OUT_STATUS: Int
    let CHECK_OUT_DATE: String?
    let CHECK_OUT_LATITUDE: Double?
    let CHECK_OUT_LONGITUDE: Double?
    let CHECK_OUT_ADDRESS: String?
    let VISIT_OUTCOME_ID: Int
    let VISIT_OUTCOME: String?
    let CHECK_OUT_REMARKS: String?
}

public struct SaveInfo: Codable{
    let success: Bool
    let message: String
}

public var KpiInfoList = [KpiInfo]()
public struct KpiInfo: Decodable {
    var SL: Int
    let KPI_NAME: String
    let INDICATOR: Int
    let TARGET: Double
    let ACHIEVEMENT: Double
    let ACHIEVEMENT_PERCENTAGE: Double
    let GROWTH_PERCENTAGE: Double
}

public struct KpiInfoX: Codable {
    let KPI_NAME: String
    let INDICATOR: Int
    let TARGET: Double
    let ACHIEVEMENT: Double
    let ACHIEVEMENT_PERCENTAGE: Double
    let GROWTH_PERCENTAGE: Double
}

public var UserGiftList = [UserGiftInfo]()
public struct UserGiftInfo: Decodable {
    var SL: Int
    let DEPARTMENT_NAME: String
    let PRODUCT_CODE: String
    let PRODUCT_NAME: String
    let PRODUCT_TYPE: String
    let PRODUCT_COUNT: Int
}

public struct UserGiftInfoX: Codable {
    let DEPARTMENT_NAME: String
    let PRODUCT_CODE: String
    let PRODUCT_NAME: String
    let PRODUCT_TYPE: String
    let PRODUCT_COUNT: Int
}

public var SalsePipelineList = [SalsePipeline]()
public struct SalsePipeline: Decodable {
    let SL: Int
    let COMPANY_ID: Int
    let COMPANY_NAME: String
    let COMPANY_TYPE: String
    let TOTAL_MSISDN_COUNT: Double
    let EXPECTED_REVENUE: Double
    let TEAM: String
    let ACTIVATION_MATURE_MONTH: String
}

public struct SalsePipelineX: Codable {
    let COMPANY_ID: Int
    let COMPANY_NAME: String
    let COMPANY_TYPE: String
    let TOTAL_MSISDN_COUNT: Double
    let EXPECTED_REVENUE: Double
    let TEAM: String
    let ACTIVATION_MATURE_MONTH: String
}


public var AgreementList = [AgreementInfo]()
public struct AgreementInfo: Decodable {
    let SL: Int
    let COMPANY_ID: Int
    let COMPANY_NAME: String
    let COMPANY_SEGMENT: String
    let TOTAL_MSISDN_COUNT: Int
    let BTRC_APPROVAL_STATUS: String
}

public struct AgreementInfoX: Codable {
    let COMPANY_ID: Int
    let COMPANY_NAME: String
    let COMPANY_SEGMENT: String
    let TOTAL_MSISDN_COUNT: Int
    let BTRC_APPROVAL_STATUS: String
}


public var CompanyVisitList = [CompanyVisit]()
public struct CompanyVisit: Decodable {
    let SL: Int
    let COMPANY_ID: Int
    let COMPANY_NAME: String
    let NO_OF_VISIT: Int
}
public struct CompanyVisitX: Codable {
    let COMPANY_ID: Int
    let COMPANY_NAME: String
    let NO_OF_VISIT: Int
}

public struct ZeroCompany: Decodable {
    let SL: Int
    let COMPANY_ID: Int
    let COMPANY_NAME: String
}

public struct ZeroCompanyX: Codable {
    let COMPANY_ID: Int
    let COMPANY_NAME: String
}


public struct VisitTypeInfo: Decodable {
    let VISIT_TYPE_ID: Int
    let VISIT_TYPE_NAME: String
}

public struct NotificationInfo: Decodable {
    let SL: Int
    let COMPANY_NAME: String
    let OCCASION_DETAIL: String
    let OCCASION_DATE: String
}

public struct NotificationInfoX: Codable {
    let COMPANY_NAME: String
    let OCCASION_DETAIL: String
    let OCCASION_DATE: String
}


//Afzal Hossain

import SwiftUI

struct PopUpButton : View {
    
    var title : String
    
    var body: some View{
        
        HStack(spacing: 15){
            
            Text(title).font(.system(size: 14))
                .foregroundColor(Color("IconColor"))
                .padding(.leading,10)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical,12)
    }
}


struct PopUpButtonImg : View {
    
    var title : String
    
    var body: some View{
        
        HStack(spacing: 15){
            
            Image(systemName: title)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundColor(Color("IconColor"))
            
            Text(title).font(.system(size: 14))
                .foregroundColor(Color("IconColor"))
            
            Spacer(minLength: 0)
        }
        .padding(.vertical,12)
    }
}


func formatPoints(from: Int) -> String {

    let number = Double(from)
    let thousand = number / 1000
    let million = number / 1000000
    //let billion = number / 1000000000

//    if billion >= 1.0 {
////        return "\(round(billion*10)/10)B"
//        return String(format: "%.1f", ((billion*10)/10))+"B"
//    } else
    if million >= 1.0 {
        return String(format: "%.1f", ((million*10)/10))+"M"
//        return "\(round(million*10)/10)M"
    } else if thousand >= 1.0 {
        return String(format: "%.1f", ((thousand*10)/10))+"K"
//        return ("\(round(thousand*10/10))K")
    } else {
        return "\(Int(number))"
    }
}
