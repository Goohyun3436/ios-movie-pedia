//
//  UIViewController+Extension.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/25/25.
//

import UIKit

extension UIViewController {
    func saveJsonData<T: Codable>(_ data: Any?, type: T.Type, forKey: String) {
        let encoder = JSONEncoder()
        let data = data as? T
        
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.setValue(encoded, forKey: forKey)
        }
    }
    
    func loadJsonData<T: Codable>(type: T.Type, forKey: String) -> T? {
        guard let savedData = UserDefaults.standard.object(forKey: forKey) as? Data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        guard let savedObject = try? decoder.decode(T.self, from: savedData) else {
            return nil
        }
        
        return savedObject
    }
}
