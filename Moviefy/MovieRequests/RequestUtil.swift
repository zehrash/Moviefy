//
//  RequestUtil.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 26.02.21.
//

import Foundation

 enum MovieError: Error {
    case apiError
    case invalidURL
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}

 enum MovieAPIResources: String{
    case popular = "popular",
         top_rated = "top_rated",
         upcoming = "upcoming",
         trending = "now_playing",//trending
         movieId = "movie_id"
}

 enum MovieAPIFormat:String{
    case language = "en-US"
}

 enum MovieImageSize: String {
    case small = "w92"
    case medium = "w185"
    case big = "w500"
    case original = "original"
}
