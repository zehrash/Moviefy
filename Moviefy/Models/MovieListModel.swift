//
//  MovieListModel.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 24.02.21.
//

import Foundation



class MovieListModel{
    
    public init(){
        movieList = [MovieModel]()
    }
    var movieList: [MovieModel]
    
    func getMovies(with resources: MovieAPIResources,format: MovieAPIFormat, language: MovieAPIFormat, callback: @escaping (_ response: [MovieModel]) -> Void){
       // DispatchQueue.main.async {
      
        MovieAPIRequests.shared.fetchMovies(with: resources.rawValue,
                                              parameters:["api_key": format.rawValue,
                                                         "language": language.rawValue]){
            [weak self] (result) in
            switch result{
            case .success(let data):
                self?.movieList.append(contentsOf: data.results)
                callback(self!.movieList)
            case .failure(let error):
                print(error)
                }
            //}
        }
    }
   
}
