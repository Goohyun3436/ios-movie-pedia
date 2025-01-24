//
//  String+Extension.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/25/25.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
