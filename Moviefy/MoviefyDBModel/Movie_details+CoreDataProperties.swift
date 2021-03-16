//
//  Movie_details+CoreDataProperties.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 16.03.21.
//
//

import Foundation
import CoreData


extension Movie_details {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie_details> {
        return NSFetchRequest<Movie_details>(entityName: "Movie_details")
    }

    @NSManaged public var movie_id: Int32
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var releaseData: String?
    @NSManaged public var voteAverage: String?
    @NSManaged public var backdropImage: Data?
    @NSManaged public var posterImage: Data?

}

extension Movie_details : Identifiable {

}
