//
//  CinemaViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/10/25.
//

import Foundation

final class CinemaViewModel {
    
    //MARK: - Input
    let viewWillAppear: Observable<Void?> = Observable(nil)
    
    //MARK: - Output
    let rightBarButtonImage = Observable("magnifyingglass")
    let profile: Observable<Profile?> = Observable(nil)
    let likes: Observable<[Int]> = Observable(User.likes)
    let searches: Observable<[String]> = Observable(User.searches)
    let movies: Observable<[Movie]> = Observable([])
    
    //MARK: - Property
    let titles = CinemaContent.allCases
    
    //MARK: - Bind
    init() {
        viewWillAppear.lazyBind { [weak self] _ in
            self?.profile.value = UserStorage.shared.getProfile()
            self?.likes.value = User.likes
        }
    }
    
}
