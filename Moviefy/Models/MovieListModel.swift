//
//  MovieListModel.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 24.02.21.
//

import Foundation



class MovieListModel{
    
    class func getMovies(with resources: MovieAPIResources,language: MovieAPIFormat, callback: @escaping (_ response: [MovieModel]) -> Void){
       
        MovieAPIRequests.shared.fetchMovies(with: resources.rawValue,
                                              parameters:["language": language.rawValue]){
            (result) in
            switch result{
            case .success(let data):
                
                callback(data.results)
            case .failure(let error):
                print(error)
                }
        }
    }
    class func getMoviesByKeyword( with keyword: String, callback: @escaping (_ response: [MovieModel]) -> Void){
        MovieAPIRequests.shared.fetchMoviesByKeyword(parameters: ["query": keyword] ){
            (result) in
            switch result{
            case .success(let data):
                callback(data.results)
            case .failure(let error):
                print(error)
                }
        }
    }
   
}
