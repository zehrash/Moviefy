//
//  MovieReq.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 16.02.21.
//

import Foundation
import UIKit

enum MovieAPIResources: String{
    case popular,
         top_rated,
         upcoming,
         now_playing
}

enum MovieAPIFormat:String{
    case api_key = "25ade48746a03a4c0a91070686e7b028",
         language = "en-US"
}
enum MovieImageSize: String {
    case small = "w92"
    case medium = "w185"
    case big = "w500"
    case original = "original"
}

struct MovieAPIRequests{
    
    private init() {}
   
    static let shared = MovieAPIRequests()
    private let imageBaseURL = "https://image.tmdb.org/t/p/"
    
    let session = URLSession.shared
    //let url = URL(string: "...")!
    
    var urlComponents: URLComponents {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.themoviedb.org"
        return urlComponents
        }
    
    
    func fetchPopularMovies(with resources: MovieAPIResources, format: MovieAPIFormat,language :MovieAPIFormat,completion: @escaping(Data?, Error?) -> Void){
        fetch(with: resources, parameters: ["api_key": format.rawValue,
                                            "language": language.rawValue
        ], completion: completion)
    }
    
    
    func fetchTopRatedMovies(with resources: MovieAPIResources, format: MovieAPIFormat,language :MovieAPIFormat,completion: @escaping(Data?, Error?) -> Void){
        fetch(with: resources, parameters: ["api_key": format.rawValue,
                                            "language": language.rawValue
        ], completion: completion)
        
    }
    
    func fetchTrendingMovies(with resources: MovieAPIResources, format: MovieAPIFormat,language :MovieAPIFormat, completion: @escaping(Data?, Error?) -> Void){
        fetch(with: resources, parameters: ["api_key": format.rawValue,
                                            "language": language.rawValue
        ], completion: completion)
      print(  MovieAPIRequests.shared.urlComponents.url?.absoluteString)
    }
    
    func fetchUpcomingMovies(with resources: MovieAPIResources, format: MovieAPIFormat,language :MovieAPIFormat,completion: @escaping(Data?, Error?) -> Void){
        fetch(with: resources, parameters: ["api_key": format.rawValue,
                                            "language": format.rawValue
        ], completion: completion)
        
        
    }
    private func fetch(with resources: MovieAPIResources, parameters: [String: String], completion: @escaping(Data?, Error?) -> Void) {
           var urlComponents = self.urlComponents
           urlComponents.path = "/3/movie/\(resources)"
         urlComponents.setQueryItems(with: parameters)
        
           guard let url = urlComponents.url else {
               completion(nil, NSError(domain: "", code: 100, userInfo: nil))
               return
           }
           session.dataTask(with: url) { (data, _, error) in
               completion(data, error)
           }.resume()
        
        print( url.absoluteURL)
       }
    
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
}

func getTrendingMovies() ->MovieMaker? {
    var response: MovieMaker? = nil
    MovieAPIRequests.shared.fetchTrendingMovies(with: .now_playing, format: .api_key.self, language: .language.self){
        (data, error) in
        
        if (error != nil) {
                        NSLog("E: MovieAPI -- error != nil")
                        return
                    }
                    if (data == nil) {
                        NSLog("E: MovieStore -- data returned nil")
                        return
                    }
                    let responseString = String(data: data!, encoding: .utf8)!
                    guard let dictionary = responseString.toDictionary() else {
                        NSLog("E: MovieStore -- String().toDictionary() returned nil")
                        return
                    }
                    let results = dictionary.value(forKeyPath: "results") as? NSArray
                    //print(results?.count)
                    let response: MovieMaker = MovieMaker(results: results!)
        
                        //If i use Codable
        /*
        if let data = data{
           //let dataString = String(data: data, encoding: .utf8) {
           //let jsonData = dataString.data(using: .utf8)!//{
                let decoder = JSONDecoder()

                do {
                    let movies = try decoder.decode([MovieModel].self, from: data)
                    print(movies[0].title)
                } catch {
                    print(error.localizedDescription)
                }
        }
 */
        
    }
    return response
}

func getPopularMovies()->MovieMaker? {
    var response: MovieMaker? = nil
    MovieAPIRequests.shared.fetchPopularMovies(with: .popular, format: .api_key.self, language: .language.self){
        (data, error) in
       
        if (error != nil) {
                        NSLog("E: MovieAPI -- error != nil")
                        return
                    }
        if (data == nil) {
                        NSLog("E: MovieStore -- data returned nil")
                        return
                    }
        let responseString = String(data: data!, encoding: .utf8)!
        guard let dictionary = responseString.toDictionary() else {
                NSLog("E: MovieStore -- String().toDictionary() returned nil")
                return
        }
        let results = dictionary.value(forKeyPath: "results") as? NSArray
        //print(results?.count)
        response = MovieMaker(results: results!)
       
    }
    return response
}

    
func getUpcomingMovies()->MovieMaker? {
    var response: MovieMaker? = nil
    MovieAPIRequests.shared.fetchUpcomingMovies(with: .upcoming, format: .api_key.self, language: .language.self){
        (data, error) in
        
        if (error != nil) {
                        NSLog("E: MovieAPI -- error != nil")
                        return
                    }
                    if (data == nil) {
                        NSLog("E: MovieStore -- data returned nil")
                        return
                    }
                    let responseString = String(data: data!, encoding: .utf8)!
                    guard let dictionary = responseString.toDictionary() else {
                        NSLog("E: MovieStore -- String().toDictionary() returned nil")
                        return
                    }
                    let results = dictionary.value(forKeyPath: "results") as? NSArray
                    //print(results?.count)
                    let response: MovieMaker = MovieMaker(results: results!)
        }
    return response
}
    
func getTopRatedMovies() ->MovieMaker? {
    var response: MovieMaker? = nil
    MovieAPIRequests.shared.fetchTopRatedMovies(with: .top_rated, format: .api_key.self, language: .language.self){
        (data, error) in
        if (error != nil) {
            NSLog("E: MovieAPI -- error != nil")
            return
        }
        if (data == nil) {
            NSLog("E: MovieStore -- data returned nil")
            return
        }
        let responseString = String(data: data!, encoding: .utf8)!
        guard let dictionary = responseString.toDictionary() else {
            NSLog("E: MovieStore -- String().toDictionary() returned nil")
            return
        }
        let results = dictionary.value(forKeyPath: "results") as? NSArray
        //print(results?.count)
        let response: MovieMaker = MovieMaker(results: results!)
    }
    return response
}
    
extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
            
        }
    }
}
