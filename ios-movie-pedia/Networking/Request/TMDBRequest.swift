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
    case trending(_ timewindow: Timewindow = .day, _ language: Language = .ko, _ page: Int = 1)
    
    var endpoint: String {
        return APIUrl.tmdb + self.path
    }
    
    private var path: String {
        switch self {
            case .trending(let timewindow, _, _):
                return "/trending/movie/\(timewindow)"
        }
    }
    
    var parameters: Parameters {
        switch self {
            case .trending(_, let language, let page):
                return [
                    "language": language,
                    "page": page
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
