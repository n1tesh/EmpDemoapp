//
//  Employee.swift
//  EmpDemoApp
//
//  Created by Nitesh on 29/04/22.
//

import Foundation
import CoreData

struct EmployeeDetails: Codable {
    let memberID: Int
    let memberName: String
//        profilePhoto, mobileNo, organizationid: String
//    let organizationName, address, memberDescription, firstName: String
//    let middleName, lastName, name: String
//    let isChatBlock: Bool

    enum CodingKeys: String, CodingKey {
        case memberID = "MemberId"
        case memberName = "MemberName"
//        case profilePhoto = "ProfilePhoto"
//        case mobileNo = "MobileNo"
//        case organizationid = "Organizationid"
//        case organizationName = "OrganizationName"
//        case address = "Address"
//        case memberDescription = "Description"
//        case firstName = "FirstName"
//        case middleName = "MiddleName"
//        case lastName = "LastName"
//        case name = "Name"
//        case isChatBlock = "IsChatBlock"
    }
}

extension EmployeeDetails: Equatable{
    static func == (lhs: EmployeeDetails, rhs: EmployeeDetails) -> Bool {
        return lhs.memberID == rhs.memberID
        
    }
}
