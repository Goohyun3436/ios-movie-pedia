//
//  DateFormatterManager.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/9/25.
//

import Foundation

final class DateFormatterManager {
    
    static let shared = DateFormatterManager()
    private let formatter = DateFormatter()
    
    func getToday() -> String {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let today = formatter.string(from: Date())
        return today
    }
    
    func string(_ dateString: String?, from: String, to: String) -> String {
        guard let dateString else {
            return ""
        }
        
        formatter.dateFormat = from
        
        guard let convertDate = formatter.date(from: dateString) else {
            return ""
        }
        
        formatter.dateFormat = to
        let date = formatter.string(from: convertDate)
        return date
    }
    
}
