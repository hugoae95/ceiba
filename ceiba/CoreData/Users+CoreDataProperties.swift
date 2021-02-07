//
//  Users+CoreDataProperties.swift
//  ceiba
//
//  Created by Macbook on 7/02/21.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var phone: String?

}

extension Users : Identifiable {

}
