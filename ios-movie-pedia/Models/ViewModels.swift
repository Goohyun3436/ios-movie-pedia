//
//  ViewModels.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/30/25.
//

import Foundation

enum NoneContent {
    case backdrops
    case overview
    case poster
    
    var message: String {
        switch self {
        case .backdrops:
            return "배경 이미지가 등록되지 않은 영화입니다."
        case .overview:
            return "줄거리가 등록되지 않은 영화입니다."
        case .poster:
            return "포스터가 등록되지 않은 영화입니다."
        }
    }
}
