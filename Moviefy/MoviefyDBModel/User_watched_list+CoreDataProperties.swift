//
//  User_watched_list+CoreDataProperties.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 16.03.21.
//
//

import Foundation
import CoreData


extension User_watched_list {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User_watched_list> {
        return NSFetchRequest<User_watched_list>(entityName: "User_watched_list")
    }

    @NSManaged public var username: Users?
    @NSManaged public var movie_id: Movie_details?

}

extension User_watched_list : Identifiable {

}
