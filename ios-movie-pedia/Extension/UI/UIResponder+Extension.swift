//
//  UIResponder+Extension.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/25/25.
//

import UIKit

extension UIResponder {
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
