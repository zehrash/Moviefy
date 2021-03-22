//
//  Users+CoreDataProperties.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 22.03.21.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?

}

extension Users : Identifiable {

}
