//
//  Parser.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 18.02.21.
//

import Foundation
extension String{
    func toDictionary() -> NSDictionary? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension NSDictionary {
    func mapToMovie() -> MovieModel{
        return MovieModel(title: self.value(forKeyPath: MovieKey.title.rawValue) as? String,
                          popularity: self.value(forKeyPath: MovieKey.popularity.rawValue) as? Double,
                          id: self.value(forKeyPath: MovieKey.id.rawValue) as? Int,
                          backdropPath: self.value(forKeyPath: MovieKey.backdropPath.rawValue) as? String,
                          posterPath: self.value(forKeyPath: MovieKey.posterPath.rawValue) as? String,
                          overview: self.value(forKeyPath: MovieKey.overview.rawValue) as? String,
                          voteAverage: self.value(forKeyPath: MovieKey.voteAverage.rawValue) as? Double,
                          releaseDate: self.value(forKeyPath: MovieKey.releaseDate.rawValue) as? String,
                          language: self.value(forKeyPath: MovieKey.language.rawValue) as? String)
    }
}
