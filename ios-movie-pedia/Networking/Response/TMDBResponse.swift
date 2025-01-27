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

struct TMDBSearchResponse: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let vote_average: Double
    var is_like: Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case backdrop_path
        case title
        case overview
        case poster_path
        case genre_ids
        case popularity
        case release_date
        case vote_average
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: CodingKeys.id)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        overview = try container.decode(String.self, forKey: CodingKeys.overview)
        poster_path = try container.decode(String.self, forKey: CodingKeys.poster_path)
        genre_ids = try container.decode([Int].self, forKey: CodingKeys.genre_ids)
        popularity = try container.decode(Double.self, forKey: CodingKeys.popularity)
        release_date = try container.decode(String.self, forKey: CodingKeys.release_date)
        vote_average = try container.decode(Double.self, forKey: CodingKeys.vote_average)
        is_like = User.likes.contains(id)
    }
}
