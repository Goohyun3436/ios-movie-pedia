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
        
        let titles = CinemaContent.allCases
        let profile: Observable<Profile?> = Observable(nil)
        let likes: Observable<[Int]> = Observable([])
        let searches: Observable<[String]> = Observable([])
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
            self?.output.profile.value = UserStaticStorage.profile
            self?.output.likes.value = UserStaticStorage.likes
            self?.output.searches.value = UserStaticStorage.searches
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
            guard let query, var searches = self?.output.searches.value else { return }
            
            if let index = searches.lastIndex(of: query) {
                searches.remove(at: index)
            }
            
            searches.insert(query, at: 0)
            self?.output.searches.value = searches
            UserStorage.shared.searches = searches
        }
        
        input.searchesRemoveAll.lazyBind { [weak self] _ in
            guard var searches = self?.output.searches.value else { return }
            
            searches.removeAll()
            self?.output.searches.value = searches
            UserStorage.shared.searches = searches
        }
        
        input.searchRemove.lazyBind { [weak self] query in
            guard let query, var searches = self?.output.searches.value else { return }
            
            if let index = searches.firstIndex(of: query) {
                searches.remove(at: index)
            }
            
            self?.output.searches.value = searches
            UserStorage.shared.searches = searches
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
            
            guard var likes = self?.output.likes.value else { return }
            
            if let index = likes.firstIndex(of: movieId) {
                likes.remove(at: index)
            } else {
                likes.append(movieId)
            }
            
            for i in movies.indices {
                if movies[i].id == movieId {
                    self?.output.movies.value[i].is_like.toggle()
                }
            }
            
            self?.output.likes.value = likes
            UserStorage.shared.likes = likes
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
