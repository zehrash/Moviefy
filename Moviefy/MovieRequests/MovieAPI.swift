//
//  MovieReq.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 16.02.21.
//

import Foundation
import UIKit


struct MovieAPIRequests{
    typealias Handler = (Result<MoviesResponse, MovieError>) -> Void
    typealias MovieDetailsHandler = (Result<MovieModel, MovieError>) -> Void
    
    let api_key = "25ade48746a03a4c0a91070686e7b028"
    let jsonDecoder = JSONDecoder()
    
    private init() {}
   
    static let shared = MovieAPIRequests()
    private let imageBaseURL = "https://image.tmdb.org/t/p/" //needed for getImage()
    
    let session = URLSession.shared
  
    var urlComponents: URLComponents {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.themoviedb.org"
        return urlComponents
        }

 /*
     This method can be used for requesting images instead of loading with Nuke
    
    func getImage(path: String, size: MovieImageSize, completion: @escaping (Data?) -> ()) {
            guard let url = URL(string: imageBaseURL + size.rawValue + path) else {
                NSLog("E: MovieStore -- getPoster url error")
                return
            }
            session.dataTask(with: url) { (data, response, error) in
                if (error != nil) {
                    NSLog("E: MovieStore -- getPoster dataTask error")
                    completion(nil)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    NSLog("E: MovieStore -- getPoster httpResponse error")
                    completion(nil)
                    return
                }
                if (httpResponse.statusCode < 200 && httpResponse.statusCode >= 300) {
                    NSLog("E: MovieStore -- getPoster httpResponse <200 >300")
                    completion(nil)
                    return
                }
                guard let data = data else {
                    NSLog("E: MovieStore -- getPoster data error")
                    completion(nil)
                    return
                }
                completion(data)
            }.resume()
        }
     */
    func fetchMovies(with resources: String, parameters: [String: String],
                       then handler: @escaping Handler){
        
    
     
       var urlComponents = self.urlComponents
       urlComponents.path = "/3/movie/\(resources)"
        urlComponents.setQueryItems(with: parameters)
        
           guard let url = urlComponents.url else {
            handler(.failure(.invalidEndpoint))
               return
           }
        print(url)
           session.dataTask(with: url) { (data, response, error) in
               if error != nil {
                self.handleError(errorHandler: handler, error: .apiError)
                   return
               }
               
               guard let data = data else {
                   self.handleError(errorHandler: handler, error: .noData)
                   return
               }
              
               do {
                   let moviesResponse = try jsonDecoder.decode(MoviesResponse.self, from: data)
                   DispatchQueue.main.async {
                    handler(.success(moviesResponse))
                   }
             } catch {
                   self.handleError(errorHandler: handler, error: .serializationError)
               }
           }.resume()
       }
    
    func fetchMovieDetails(with movieID: Int, parameters: [String: String],
                           then handler: @escaping MovieDetailsHandler){
     
        var urlComponents = self.urlComponents
        urlComponents.path = "/3/movie/\(movieID)"
        urlComponents.setQueryItems(with: parameters)
            guard let url = urlComponents.url else {
             handler(.failure(.invalidEndpoint))
                return
            }
            session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                 self.handleMovieError(errorHandler: handler, error: .apiError)
                    return
                }
                                
                guard let data = data else {
                    self.handleMovieError(errorHandler: handler, error: .noData)
                    return
                }
               
                do {
                    let movieModelResponse = try jsonDecoder.decode(MovieModel.self, from: data)
                    DispatchQueue.main.async {
                     handler(.success(movieModelResponse))
                    }
              } catch {
                    self.handleMovieError(errorHandler: handler, error: .serializationError)
                }
            }.resume()
        
    }
    
    func fetchMoviesByKeyword(parameters: [String: String],then handler: @escaping Handler){
        var urlComponents = self.urlComponents
        urlComponents.path = "/3/search/movie"
        urlComponents.setQueryItems(with: parameters)
            guard let url = urlComponents.url else {
             handler(.failure(MovieError.invalidEndpoint))
                return
            }
        
        print(url)
        session.dataTask(with: url) { (data, response, error) in
            if error != nil {
             self.handleError(errorHandler: handler, error: .apiError)
                return
            }
        
            
            guard let data = data else {
                self.handleError(errorHandler: handler, error: .noData)
                return
            }
           
            do {
                let moviesResponse = try jsonDecoder.decode(MoviesResponse.self, from: data)
                DispatchQueue.main.async {
                 handler(.success(moviesResponse))
                }
          } catch {
                self.handleError(errorHandler: handler, error: .serializationError)
            }
        }.resume()
    }
    
    private func handleError(errorHandler: @escaping Handler, error: MovieError) {
           DispatchQueue.main.async {
            errorHandler(.failure(error))
           }
    }
    private func handleMovieError(errorHandler: @escaping MovieDetailsHandler, error: MovieError) {
           DispatchQueue.main.async {
            errorHandler(.failure(error))
           }
    }
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        
        var items = [URLQueryItem(name: "api_key", value: MovieAPIRequests.shared.api_key)]
        
        for (key,value) in parameters{
            items.append(URLQueryItem(name: key, value: value))
        }
        self.queryItems = items.map {
            URLQueryItem(name: $0.name, value: $0.value)
            
        }
    }
}
