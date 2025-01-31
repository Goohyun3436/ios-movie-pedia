//
//  UIView+Extension.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/28/25.
//

import UIKit

extension UIView {
    func convertGenreIds(_ ids: [Int]?) -> [String] {
        guard let ids else {
            return []
        }
        
        var result = [String]()
        
        for i in ids.indices {
            guard i <= 1 else {
                break
            }
            
            guard let genre = Movie.genre[ids[i]]?.ko else {
                continue
            }
            
            result.append(genre)
        }
        
        return result
    }
}
