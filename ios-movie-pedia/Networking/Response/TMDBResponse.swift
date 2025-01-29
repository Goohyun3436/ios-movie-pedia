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

struct TMDBCreditsResponse: Decodable {
    let id: Int
    let cast: [Person]
}

struct TMDBImagesResponse: Decodable {
    let id: Int
    let backdrops: [Image]
    let posters: [Image]
}

struct Movie: Decodable {
    static let genre = [
        12: GenreName(ko: "모험"),
        14: GenreName(ko: "판타지"),
        16: GenreName(ko: "애니메이션"),
        18: GenreName(ko: "드라마"),
        27: GenreName(ko: "공포"),
        28: GenreName(ko: "액션"),
        35: GenreName(ko: "코미디"),
        36: GenreName(ko: "역사"),
        37: GenreName(ko: "서부"),
        53: GenreName(ko: "스릴러"),
        80: GenreName(ko: "범죄"),
        99: GenreName(ko: "다큐멘터리"),
        878: GenreName(ko: "SF"),
        9648: GenreName(ko: "미스터리"),
        10402: GenreName(ko: "음악"),
        10749: GenreName(ko: "로맨스"),
        10751: GenreName(ko: "가족"),
        10752: GenreName(ko: "전쟁"),
        10770: GenreName(ko: "TV 영화")
    ]
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
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
        poster_path = try container.decode(String?.self, forKey: CodingKeys.poster_path)
        genre_ids = try container.decode([Int].self, forKey: CodingKeys.genre_ids)
        popularity = try container.decode(Double.self, forKey: CodingKeys.popularity)
        release_date = try container.decode(String.self, forKey: CodingKeys.release_date)
        vote_average = try container.decode(Double.self, forKey: CodingKeys.vote_average)
        is_like = User.likes.contains(id)
    }
}

struct Person: Decodable {
    let name: String
    let original_name: String
    let profile_path: String?
}

struct Image: Decodable {
    let file_path: String?
}

struct GenreName {
    let ko: String
}
