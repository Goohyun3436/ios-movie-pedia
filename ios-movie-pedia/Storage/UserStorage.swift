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
    
    func getProfile() -> Profile {
        guard let saved = UserDefaultManager.shared.loadJsonData(type: Profile.self, forKey: .profile) else {
            return Profile(image: Profile.randomImage, nickname: nil)
        }
        
        return saved
    }
    
    func getLikes() -> [Int] {
        return UserDefaultManager.shared.getArrayData(forKey: .likes)
    }
    
    func getSearches() -> [String] {
        return UserDefaultManager.shared.getArrayData(forKey: .searches)
    }
    
    func saveLikes() {
        UserDefaultManager.shared.saveData(User.likes, forKey: .likes)
    }
    
    func saveSearches() {
        UserDefaultManager.shared.saveData(User.searches, forKey: .searches)
    }
    
    func saveProfile(_ profile: Profile) {
        UserDefaultManager.shared.saveJsonData(profile, type: Profile.self, forKey: .profile)
    }
    
    func removeProfile() {
        UserDefaultManager.shared.removeObject(forKey: .profile)
    }
    
    func resign()  {
        UserDefaultManager.shared.removeObject(forKey: .profile)
        User.likes = []
        User.searches = []
    }
    
}
