//
//  ViewModels.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/30/25.
//

import Foundation

enum NoneContent {
    case overview
    case poster
    
    var message: String {
        switch self {
        case .overview:
            return "줄거리가 등록되지 않은 영화입니다."
        case .poster:
            return "포스터가 등록되지 않은 영화입니다."
        }
    }
}
