//
//  Movie.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//

import Foundation
import UIKit

public struct MovieModel: Codable {
    
    public let id: Int
    public let title: String
    public let backdropPath: String?
    public let posterPath: String?
    public let overview: String
    public let releaseDate: String
    public let voteAverage: Double
    //public let genres: [MovieGenre]?  //had problem with parsing nested genres. Will be fixed soon
    public var posterURL: URL? {
      guard let str = posterPath else {
          return URL(string: "https://postimg.cc/CzRpLyCb")!
      }
      return URL(string: "https://image.tmdb.org/t/p/w300\(str)")
    }
    
    public var backdropURL: URL? {
      guard let str = backdropPath else {
          return URL(string: "https://postimg.cc/CzRpLyCb")!
      }
      return URL(string: "https://image.tmdb.org/t/p/w500\(str)")
    }
  public var backdropImage: Data?
  public var posterImage:Data?
  
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
      //  case genres = "genre_ids"
       }
}

//public struct MovieGenre: Codable {
 //   let name: String
//}

public struct MoviesResponse: Codable {
    public let page: Int
    public let results: [MovieModel]
    public let totalPages: Int
    public let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
           case page = "page"
           case results = "results"
           case totalPages = "total_pages"
           case totalResults = "total_results"
       }
}





