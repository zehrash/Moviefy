//
//  User_watch_later_list+CoreDataProperties.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 16.03.21.
//
//

import Foundation
import CoreData


extension User_watch_later_list {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User_watch_later_list> {
        return NSFetchRequest<User_watch_later_list>(entityName: "User_watch_later_list")
    }

    @NSManaged public var movie_id: Movie_details?
    @NSManaged public var username: Users?

}

extension User_watch_later_list : Identifiable {

}
