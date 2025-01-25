//
//  Profile.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/25/25.
//

import Foundation

struct Profile: Codable {
    var image: String?
    var nickname: String?
    var created_at: String?
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

enum NicknameCondition {
    case satisfied, length, symbol, number
    
    var msg: String {
        switch self {
        case .satisfied:
            return "사용할 수 있는 닉네임이에요"
        case .length:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .symbol:
            return "닉네임에 @, #, $, % 는 포함할 수 없어요"
        case .number:
            return "닉네임에 숫자는 포함할 수 없어요"
        }
    }
}

protocol ProfileDelegate {
    func profileImageDidChange(_ image: String?)
    func nicknameDidChange(_ nickname: String?)
}
