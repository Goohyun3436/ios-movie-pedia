//
//  UserResponse.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import Foundation

struct User {
    static var likes = [Int]() {
        didSet {
            UserDefaults.standard.set(User.likes, forKey: "likes")
        }
    }
    static var searches = [String]() {
        didSet {
            UserDefaults.standard.set(User.searches, forKey: "searches")
        }
    }
}

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
        guard let created_at else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let convertDate = formatter.date(from: created_at) else {
            return ""
        }
        
        formatter.dateFormat = "yy.MM.dd 가입"
        let date = formatter.string(from: convertDate)
        return date
    }
}
