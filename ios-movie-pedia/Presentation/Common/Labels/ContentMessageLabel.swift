//
//  ContentMessageLabel.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/30/25.
//

import UIKit

enum ContentMessage: String {
    case backdrops = "배경 이미지"
    case overview = "줄거리"
    case poster = "포스터 이미지"
    
    var loading: String {
        return "\(self.rawValue) 로드중"
    }
    
    var none: String {
        return "\(self.rawValue)가 등록되지 않은 영화입니다."
    }
}

final class ContentMessageLabel: UILabel {
    
    init(_ content: ContentMessage) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
