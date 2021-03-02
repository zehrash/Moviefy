//
//  MovieDetailsModel.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 1.03.21.
//

import Foundation


class MovieDetailsModel {
    
    var movieModel:MovieModel?
    
    func getMovieDetails(with movieID: Int, language: MovieAPIFormat, callback: @escaping (_ response: MovieModel) -> Void){
        
          MovieAPIRequests.shared.fetchMovieDetails(with: movieID,
                                                parameters:["language": language.rawValue]){
              [weak self] (result) in
              switch result{
              case .success(let data):
                  self?.movieModel = data
                  callback(self!.movieModel!)
              case .failure(let error):
                  print(error)
                  }
          }
    }
}
