//
//  UserManager.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/7/25.
//

import Foundation

@propertyWrapper
final class UserDefault<T> {
    let key: UserDefaultKey
    let empty: T
    
    var wrappedValue: T {
        get {
            return UserDefaultManager.shared.getData(forKey: key) as? T ?? empty
        }
        set {
            UserDefaultManager.shared.setData(newValue, forKey: key)
        }
    }
    
    init(key: UserDefaultKey, empty: T) {
        self.key = key
        self.empty = empty
    }
    
}

@propertyWrapper
final class UserDefaultJSON<T: Codable> {
    let key: UserDefaultKey
    let empty: T
    
    var wrappedValue: T {
        get {
            return UserDefaultManager.shared.loadJsonData(type: T.self, forKey: key) ?? empty
        }
        set {
            UserDefaultManager.shared.saveJsonData(newValue, type: T.self, forKey: key)
        }
    }
    
    init(key: UserDefaultKey, empty: T) {
        self.key = key
        self.empty = empty
    }
    
}

final class UserDefaultManager {
    
    private init() {}
    
    static let shared = UserDefaultManager()
    
    func getData(forKey: UserDefaultKey) -> Any? {
        return UserDefaults.standard.object(forKey: forKey.rawValue)
    }
    
    func setData(_ data: Any?, forKey: UserDefaultKey) {
        UserDefaults.standard.set(data, forKey: forKey.rawValue)
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
    
    func saveJsonData<T: Codable>(_ data: Any?, type: T.Type, forKey: UserDefaultKey) {
        let encoder = JSONEncoder()
        let data = data as? T
        
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.setValue(encoded, forKey: forKey.rawValue)
        }
    }
    
    func removeObject(forKey: UserDefaultKey) {
        UserDefaults.standard.removeObject(forKey: forKey.rawValue)
    }
    
}
