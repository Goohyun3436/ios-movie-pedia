//
//  CinemaViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/10/25.
//

import Foundation

final class CinemaViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    typealias CollectionViewTag = Int
    typealias Query = String
    typealias MovieId = Int
    
    //MARK: - Input
    struct Input {
        let viewWillAppear: Observable<Void?> = Observable(nil)
        let didSelectItemAt: Observable<(CollectionViewTag?, IndexPath?)> = Observable((nil, nil))
        let searchAdd: Observable<Query?> = Observable(nil)
        let searchesRemoveAll: Observable<Void?> = Observable(nil)
        let searchRemove: Observable<Query?> = Observable(nil)
        let likesDidChange: Observable<(MovieId?, Bool)> = Observable((nil, false))
    }
    
    //MARK: - Output
    struct Output {
        let backButtonTitle = Observable("")
        let rightBarButtonImage = Observable("magnifyingglass")
        
        let profile: Observable<Profile?> = Observable(nil)
        let likes: Observable<[Int]> = Observable(User.likes)
        let titles = CinemaContent.allCases
        let searches: Observable<[String]> = Observable(User.searches)
        let movies: Observable<[Movie]> = Observable([])
        let error: Observable<TMDBStatusCode> = Observable(.success)
        
        let resentSearchTapped: Observable<Query?> = Observable(nil)
        let movieTapped: Observable<Movie?> = Observable(nil)
    }
    
    //MARK: - Bind
    init() {
        input = Input()
        output = Output()
        
        input.viewWillAppear.lazyBind { [weak self] _ in
            self?.output.profile.value = UserStorage.shared.getProfile()
            self?.output.likes.value = User.likes
            self?.getMovies()
        }
        
        input.didSelectItemAt.lazyBind { [weak self] tag, indexPath in
            guard let tag, let indexPath else { return }
            
            guard let content = self?.output.titles[tag] else { return }
            
            switch content {
            case .resentSearch:
                self?.output.resentSearchTapped.value = self?.output.searches.value[indexPath.item]
            case .trendMovie:
                self?.output.movieTapped.value = self?.output.movies.value[indexPath.item]
            }
        }
        
        input.searchAdd.lazyBind { [weak self] query in
            guard let query else { return }
            
            if let index = User.searches.lastIndex(of: query) {
                User.searches.remove(at: index)
            }
            
            User.searches.insert(query, at: 0)
            self?.output.searches.value = User.searches
        }
        
        input.searchesRemoveAll.lazyBind { [weak self] _ in
            User.searches.removeAll()
            self?.output.searches.value = User.searches
        }
        
        input.searchRemove.lazyBind { [weak self] query in
            guard let query else { return }
            
            if let index = User.searches.firstIndex(of: query) {
                User.searches.remove(at: index)
            }
            
            self?.output.searches.value = User.searches
        }
        
        input.likesDidChange.lazyBind { [weak self] movieId, onlyCellReload in
            guard let movieId else { return }
            
            guard let movies = self?.output.movies.value else { return }
            
            if onlyCellReload {
                for i in movies.indices {
                    if movies[i].id == movieId {
                        self?.output.movies.value[i].is_like.toggle()
                    }
                }
                return
            }
            
            if let index = User.likes.firstIndex(of: movieId) {
                User.likes.remove(at: index)
            } else {
                User.likes.append(movieId)
            }
            
            for i in movies.indices {
                if movies[i].id == movieId {
                    self?.output.movies.value[i].is_like.toggle()
                }
            }
            
            self?.output.likes.value = User.likes
        }
    }
    
    private func getMovies() {
        NetworkManager.shared.tmdb(.trending(), TMDBResponse.self) { [weak self] data in
            self?.output.movies.value = data.results
        } failHandler: { [weak self] code in
            self?.output.error.value = code
            self?.output.movies.value = []
        }
    }
    
}
