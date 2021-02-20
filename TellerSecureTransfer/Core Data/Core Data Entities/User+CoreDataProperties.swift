//
//  User+CoreDataProperties.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userId: Int32
    @NSManaged public var userName: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var email: String?
    @NSManaged public var dataOfBirth: String?

}

extension User : Identifiable {

}
