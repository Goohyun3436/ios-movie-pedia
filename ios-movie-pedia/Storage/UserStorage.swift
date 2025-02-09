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
    
    func getProfile() -> Profile? {
        guard let saved = UserDefaultManager.shared.loadJsonData(type: Profile.self, forKey: .profile) else {
            return nil
        }
        
        return saved
    }
    
    func remove()  {
        UserDefaults.standard.removeObject(forKey: "profile")
        User.likes = []
        User.searches = []
    }
    
}
