//
//  Users+CoreDataProperties.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 25.03.21.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var isLogged: Bool
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension Users : Identifiable {

}
