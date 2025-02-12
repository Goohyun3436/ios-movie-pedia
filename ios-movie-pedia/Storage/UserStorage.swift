//
//  UserStorage.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/9/25.
//

import Foundation

final class UserStorage {
    
    static let shared = UserStorage()
    
    private init() {}
    
    @UserDefaultJSON(key: .profile, empty: Profile(image: Profile.randomImage, nickname: nil))
    var profile {
        didSet {
            UserStaticStorage.profile = profile
        }
    }
    
    @UserDefault(key: .likes, empty: [Int]())
    var likes {
        didSet {
            UserStaticStorage.likes = likes
        }
    }
    
    @UserDefault(key: .searches, empty: [String]())
    var searches {
        didSet {
            UserStaticStorage.searches = searches
        }
    }
    
    func removeProfile() {
        UserDefaultManager.shared.removeObject(forKey: .profile)
        UserStaticStorage.profile = Profile(image: Profile.randomImage, nickname: nil)
    }
    
    func resign()  {
        UserDefaultManager.shared.removeObject(forKey: .profile)
        UserStaticStorage.profile = Profile(image: Profile.randomImage, nickname: nil)
        UserStorage.shared.likes = []
        UserStorage.shared.searches = []
    }
    
}

//refactor point: read-only 설정
enum UserStaticStorage {
    static var profile = Profile(image: Profile.randomImage, nickname: nil)
    static var likes = [Int]()
    static var searches = [String]()
}
