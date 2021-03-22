//
//  MovieDetails+CoreDataProperties.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 22.03.21.
//
//

import Foundation
import CoreData


extension MovieDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetails> {
        return NSFetchRequest<MovieDetails>(entityName: "MovieDetails")
    }

    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var backdropImage: Data?
    @NSManaged public var posterImage: Data?
    @NSManaged public var voteAverage: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var movieID: Int32

}

extension MovieDetails : Identifiable {

}
