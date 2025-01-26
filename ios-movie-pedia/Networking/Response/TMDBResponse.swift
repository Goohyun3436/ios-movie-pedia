//
//  TMDBResponse.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import Foundation

struct TMDBResponse: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let backdrop_path: String
    let title: String
    let overview: String
    let poster_path: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let vote_average: Double
    var is_like: Bool {
        return User.likes.contains(self.id)
    }
}
