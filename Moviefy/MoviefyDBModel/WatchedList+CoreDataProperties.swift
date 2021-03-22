//
//  WatchedList+CoreDataProperties.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 22.03.21.
//
//

import Foundation
import CoreData


extension WatchedList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchedList> {
        return NSFetchRequest<WatchedList>(entityName: "WatchedList")
    }

    @NSManaged public var username: Users?
    @NSManaged public var movieList: MovieDetails?

}

extension WatchedList : Identifiable {

}
