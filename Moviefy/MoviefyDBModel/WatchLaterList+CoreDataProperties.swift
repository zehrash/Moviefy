//
//  WatchLaterList+CoreDataProperties.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 25.03.21.
//
//

import Foundation
import CoreData


extension WatchLaterList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchLaterList> {
        return NSFetchRequest<WatchLaterList>(entityName: "WatchLaterList")
    }

    @NSManaged public var user: Users?
    @NSManaged public var movieList: MovieDetails?

}

extension WatchLaterList : Identifiable {

}
