//
//  Movie.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 10.02.21.
//

import Foundation
import UIKit

class MovieModel {
    let title: String
    let popularity: Double?
    let id: Int
    let language: String?
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    
    var posterImage: UIImage? = nil
    var backdropImage: UIImage? = nil
    var thumbnail: UIImage? = nil
    
    
    //if i use codable model, UIImage must be repalce with Data
    /*
    func getImage(from img: Data) -> UIImage? {
            return UIImage(data: img)
    }
 */
    
    init(title: String?, popularity: Double?, id: Int?, backdropPath: String?, posterPath: String?, overview: String?, voteAverage: Double?, releaseDate: String?, language: String?) {
          
            self.popularity = popularity
            self.id = id ?? 0
            self.title = title ?? ""
            self.backdropPath = backdropPath
            self.posterPath = posterPath
            self.overview = overview ?? ""
            self.voteAverage = voteAverage ?? 0
            self.releaseDate = releaseDate ?? ""
            self.language = language
        }
    /*
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case overview = "overview"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
      }
 */
func getThunmbail() {
    MovieAPIRequests.shared.getImage(path: self.backdropPath ?? "", size: MovieImageSize.small, completion: {img in
          if (self.backdropPath == nil || self.backdropPath == "") {
              self.thumbnail = UIImage(named: "no-image.png")
          }
          else if let img = img {
              self.thumbnail = UIImage(data: img)
          }
      })
  }
  
  func getImages(completion: @escaping () -> ()) {
    MovieAPIRequests.shared.getImage(path: self.backdropPath ?? "", size: MovieImageSize.big, completion: {img in
          if (self.backdropPath == nil || self.backdropPath == "") {
              self.backdropImage = UIImage(named: "no-image.png")
          }
          else if let img = img {
              self.backdropImage = UIImage(data: img)
          }

      })
    MovieAPIRequests.shared.getImage(path: self.posterPath ?? "", size: MovieImageSize.original, completion: {img in
          if let img = img {
              self.posterImage = UIImage(data: img)
          }
          completion()
      })
  }
}
enum MovieKey: String, CaseIterable {

    case title = "title"
    case popularity = "popularity"
    case id = "id"
    case backdropPath = "backdrop_path"
    case posterPath = "poster_path"
    case overview = "overview"
    case voteAverage = "vote_average"
    case releaseDate = "release_date"
    case language = "original_language"
}

struct MovieMaker {
    var results: NSMutableArray
    
    init(results: NSArray) {
        self.results = NSMutableArray(object: MovieModel.self) 
        for i in results{
            self.results.add((i as! NSDictionary).mapToMovie())
        }
    }
    
}



