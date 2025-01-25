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
    
    func getToday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var today = formatter.string(from: Date())
        return today
    }
}
