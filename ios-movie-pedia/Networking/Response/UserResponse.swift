//
//  UserResponse.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import Foundation

struct Profile: Codable {
    // refactor point: static 없이 랜덤 이미지 적용하는 방법
    static let randomImage = "profile_\(Int.random(in: 0...11))"
    
    var image: String?
    var nickname: String?
    var mbti: [String?]?
    var created_at: String?
    var mbtiString: String? {
        guard let mbti else {
            return ""
        }
        
        guard ProfileMbtiValidation(mbti).validation else {
            return ""
        }
        
        return mbti.map { $0! }.joined(separator: "")
    }
    var createdAtFormat: String {
        let formatDate =  DateFormatterManager.shared.string(created_at, from: "yyyy-MM-dd HH:mm:ss", to: "yy.MM.dd 가입")
        return formatDate
    }
}
