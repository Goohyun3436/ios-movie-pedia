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
    
    var endpoint: String {
        return APIUrl.tmdb + self.path
    }
    
    private var path: String {
        switch self {
        case .trending(let timewindow, _, _):
            return "/trending/movie/\(timewindow)"
        case .search:
            return "/search/movie"
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
    case origin(_ imagePath: String)
    case w500(_ imagePath: String)
    
    var endpoint: String {
        return APIUrl.tmdbImage + self.path
    }
    
    private var path: String {
        switch self {
        case .origin(let imagePath):
            return "/origin/\(imagePath)"
        case .w500(let imagePath):
            return "/w500/\(imagePath)"
        }
    }
}

//MARK: - Query Params
enum Language: String {
    case english = "en-US"
    case ko = "ko-KR"
}

enum Timewindow: String {
    case day
    case weak
}
