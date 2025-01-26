//
//  TMDBResponse.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import Foundation

struct TMDBResponse: Decodable {
    static let test = TMDBResponse(
        page: 1,
        results: [
            Movie(
                id: 939243,
                backdrop_path: "/b85bJfrTOSJ7M5Ox0yp4lxIxdG1.jpg",
                title: "수퍼 소닉 3",
                overview: "너클즈, 테일즈와 함께 평화로운 일상을 보내던 초특급 히어로 소닉. 연구 시설에 50년간 잠들어 있던 사상 최강의 비밀 병기 \"섀도우\"가 탈주하자, 세계 수호 통합 부대(약칭 세.수.통)에 의해 극비 소집된다. 소중한 것을 잃은 분노와 복수심에 불타는 섀도우는 소닉의 초고속 스피드와 너클즈의 최강 펀치를 단 단숨에 제압해버린다. 세상을 지배하려는 닥터 로보트닉과 그의 할아버지 제럴드 박사는 섀도우의 엄청난 힘 카오스 에너지를 이용해 인류를 정복하려고 하는데…",
                poster_path: "/5ZoI48Puf5i5FwI6HOpunDuJOw0.jpg",
                genre_ids: [28, 878, 35, 10751],
                popularity: 7240.445,
                release_date: "2024-12-19",
                vote_average: 7.852
            ),
            Movie(
                id: 1114894,
                backdrop_path: "/3SOunz2Z0qcOVlrkYFj20HquziB.jpg",
                title: "스타 트렉: 섹션 31",
                overview: "",
                poster_path: "/sqiCinCzUGlzQiFytS30N1nO3Pt.jpg",
                genre_ids: [878, 12, 28, 18],
                popularity: 77.101,
                release_date: "2025-01-15",
                vote_average: 5.011
            ),
            Movie(
                id: 1114894,
                backdrop_path: "/3SOunz2Z0qcOVlrkYFj20HquziB.jpg",
                title: "스타 트렉: 섹션 31",
                overview: "",
                poster_path: "/sqiCinCzUGlzQiFytS30N1nO3Pt.jpg",
                genre_ids: [878, 12, 28, 18],
                popularity: 77.101,
                release_date: "2025-01-15",
                vote_average: 5.011
            ),
            Movie(
                id: 939243,
                backdrop_path: "/b85bJfrTOSJ7M5Ox0yp4lxIxdG1.jpg",
                title: "수퍼 소닉 3",
                overview: "너클즈, 테일즈와 함께 평화로운 일상을 보내던 초특급 히어로 소닉. 연구 시설에 50년간 잠들어 있던 사상 최강의 비밀 병기 \"섀도우\"가 탈주하자, 세계 수호 통합 부대(약칭 세.수.통)에 의해 극비 소집된다. 소중한 것을 잃은 분노와 복수심에 불타는 섀도우는 소닉의 초고속 스피드와 너클즈의 최강 펀치를 단 단숨에 제압해버린다. 세상을 지배하려는 닥터 로보트닉과 그의 할아버지 제럴드 박사는 섀도우의 엄청난 힘 카오스 에너지를 이용해 인류를 정복하려고 하는데…",
                poster_path: "/5ZoI48Puf5i5FwI6HOpunDuJOw0.jpg",
                genre_ids: [28, 878, 35, 10751],
                popularity: 7240.445,
                release_date: "2024-12-19",
                vote_average: 7.852
            ),
            Movie(
                id: 939243,
                backdrop_path: "/b85bJfrTOSJ7M5Ox0yp4lxIxdG1.jpg",
                title: "수퍼 소닉 3",
                overview: "너클즈, 테일즈와 함께 평화로운 일상을 보내던 초특급 히어로 소닉. 연구 시설에 50년간 잠들어 있던 사상 최강의 비밀 병기 \"섀도우\"가 탈주하자, 세계 수호 통합 부대(약칭 세.수.통)에 의해 극비 소집된다. 소중한 것을 잃은 분노와 복수심에 불타는 섀도우는 소닉의 초고속 스피드와 너클즈의 최강 펀치를 단 단숨에 제압해버린다. 세상을 지배하려는 닥터 로보트닉과 그의 할아버지 제럴드 박사는 섀도우의 엄청난 힘 카오스 에너지를 이용해 인류를 정복하려고 하는데…",
                poster_path: "/5ZoI48Puf5i5FwI6HOpunDuJOw0.jpg",
                genre_ids: [28, 878, 35, 10751],
                popularity: 7240.445,
                release_date: "2024-12-19",
                vote_average: 7.852
            )
        ]
    )
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
}
