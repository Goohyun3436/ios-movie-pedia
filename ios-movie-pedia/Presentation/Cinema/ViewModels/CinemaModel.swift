//
//  CinemaModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/10/25.
//

import Foundation

enum CinemaContent: CaseIterable {
    case resentSearch
    case trendMovie
    
    var title: String {
        switch self {
        case .resentSearch:
            return "최근검색어"
        case .trendMovie:
            return "오늘의 영화"
        }
    }
}
