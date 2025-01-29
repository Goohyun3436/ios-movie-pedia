//
//  TMDBRequest.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import Foundation
import Alamofire

//MARK: - TMDB
enum TMDBRequest {
    case trending(_ timewindow: Timewindow = .day, _ page: Int = 1, _ language: Language = .ko)
    case search(_ query: String, _ page: Int = 1, _ include_adult: Bool = false, _ language: Language = .ko)
    case credits(_ movieId: Int, _ language: Language = .ko)
    case images(_ movieId: Int)
    
    var endpoint: String {
        return APIUrl.tmdb + self.path
    }
    
    private var path: String {
        switch self {
        case .trending(let timewindow, _, _):
            return "/trending/movie/\(timewindow)"
        case .search:
            return "/search/movie"
        case .credits(let movieId, _):
            return "/movie/\(movieId)/credits"
        case .images(let movieId):
            return "/movie/\(movieId)/images"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .trending(_, let page, let language):
            return [
                "page": page,
                "language": language.rawValue
            ]
        case .search(let query, let page, let include_adult, let language):
            return [
                "query": query,
                "page": page,
                "include_adult": include_adult,
                "language": language.rawValue
            ]
        case .credits(_, let language):
            return [
                "language": language.rawValue
            ]
        case .images(_):
            return [:]
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdb]
    }
}

//MARK: - TMDB Image
enum TMDBImageRequest {
    case original(_ imagePath: String)
    case w500(_ imagePath: String)
    
    var endpoint: String {
        return APIUrl.tmdbImage + self.path
    }
    
    private var path: String {
        switch self {
        case .original(let imagePath):
            return "/original/\(imagePath)"
        case .w500(let imagePath):
            return "/w500/\(imagePath)"
        }
    }
}

//MARK: - Query Params
enum Language: String {
    case en = "en-US"
    case ko = "ko-KR"
}

enum Timewindow: String {
    case day
    case weak
}
