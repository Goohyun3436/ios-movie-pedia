//
//  ProfileModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/9/25.
//

import Foundation

enum ProfileMenu: CaseIterable {
    case question
    case inquiry
    case notification
    case resign
    
    var title: String {
        switch self {
        case .question:
            return "자주 묻는 질문"
        case .inquiry:
            return "1:1 문의"
        case .notification:
            return "알림 설정"
        case .resign:
            return "탈퇴하기"
        }
    }
    
}
