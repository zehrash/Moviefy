//
//  RequestUtil.swift
//  Moviefy
//
//  Created by Zehra Iliyaz on 26.02.21.
//

import Foundation

public enum MovieError: Error {
    case apiError
    case invalidURL
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}

public enum MovieAPIResources: String{
    case popular = "popular",
         top_rated = "top_rated",
         upcoming = "upcoming",
         trending = "now_playing" //trending
}

public enum MovieAPIFormat:String{
    case api_key = "25ade48746a03a4c0a91070686e7b028",
         language = "en-US"
}

public enum MovieImageSize: String {
    case small = "w92"
    case medium = "w185"
    case big = "w500"
    case original = "original"
}
