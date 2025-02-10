//
//  UserManager.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/7/25.
//

import Foundation

final class UserDefaultManager {
    
    private init() {}
    
    static let shared = UserDefaultManager()
    
    func getArrayData<T>(forKey: UserDefaultKey) -> [T] {
        return UserDefaults.standard.array(forKey: forKey.rawValue) as? [T] ?? []
    }
    
    func saveData(_ data: Any?, forKey: UserDefaultKey) {
        UserDefaults.standard.set(data, forKey: forKey.rawValue)
    }
    
    func saveJsonData<T: Codable>(_ data: Any?, type: T.Type, forKey: UserDefaultKey) {
        let encoder = JSONEncoder()
        let data = data as? T
        
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.setValue(encoded, forKey: forKey.rawValue)
        }
    }
    
    func loadJsonData<T: Codable>(type: T.Type, forKey: UserDefaultKey) -> T? {
        guard let savedData = UserDefaults.standard.object(forKey: forKey.rawValue) as? Data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        guard let savedObject = try? decoder.decode(T.self, from: savedData) else {
            return nil
        }
        
        return savedObject
    }
    
    func removeObject(forKey: UserDefaultKey) {
        UserDefaults.standard.removeObject(forKey: forKey.rawValue)
    }
    
}
