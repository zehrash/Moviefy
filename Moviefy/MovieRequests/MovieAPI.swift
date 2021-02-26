//
//  MovieReq.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 16.02.21.
//

import Foundation
import UIKit


struct MovieAPIRequests{
    typealias Handler = (Result<MoviesResponse, Error>) -> Void
    
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
            handler(.failure(MovieError.invalidEndpoint))
               return
           }
           session.dataTask(with: url) { (data, response, error) in
               if error != nil {
                self.handleError(errorHandler: handler, error: MovieError.apiError)
                   return
               }
               
               guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                   self.handleError(errorHandler: handler, error: MovieError.invalidResponse)
                   return
               }
               
               guard let data = data else {
                   self.handleError(errorHandler: handler, error: MovieError.noData)
                   return
               }
              
               do {
                   let moviesResponse = try jsonDecoder.decode(MoviesResponse.self, from: data)
                   DispatchQueue.main.async {
                    handler(.success(moviesResponse))
                   }
             } catch {
                   self.handleError(errorHandler: handler, error: MovieError.serializationError)
               }
           }.resume()
       }
    
    private func handleError(errorHandler: @escaping Handler, error: Error) {
           DispatchQueue.main.async {
            errorHandler(.failure(error))
           }
    }
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
            
        }
    }
}
