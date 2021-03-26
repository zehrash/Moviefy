//
//  MovieDetails+CoreDataProperties.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 25.03.21.
//
//

import Foundation
import CoreData


extension MovieDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetails> {
        return NSFetchRequest<MovieDetails>(entityName: "MovieDetails")
    }

    @NSManaged public var posterImage: Data?
    @NSManaged public var backdropImage: Data?
    @NSManaged public var movieID: Int32
    @NSManaged public var voteAverage: Double
    @NSManaged public var releaseDate: String?
    @NSManaged public var overview: String?
    @NSManaged public var title: String?

}

extension MovieDetails : Identifiable {

}
