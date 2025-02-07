//
//  SettingProfileModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/7/25.
//

import Foundation

enum ProfileNicknameValidation {
    case satisfied, out_of_range, symbol, number
    
    init(_ nickname: String?) {
        guard var nickname else {
            self = .out_of_range
            return
        }
        
        nickname = nickname.trimmingCharacters(in: .whitespaces)
        
        guard !nickname.matches("[0-9]") else {
            self = .number
            return
        }
        
        guard !nickname.matches("[@#$%]") else {
            self = .symbol
            return
        }
        
        guard 2 <= nickname.count && nickname.count < 10 else {
            self = .out_of_range
            return
        }
        
        self = .satisfied
    }
    
    var message: String {
        switch self {
        case .satisfied:
            return "사용할 수 있는 닉네임이에요"
        case .out_of_range:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .symbol:
            return "닉네임에 @, #, $, % 는 포함할 수 없어요"
        case .number:
            return "닉네임에 숫자는 포함할 수 없어요"
        }
    }
}
