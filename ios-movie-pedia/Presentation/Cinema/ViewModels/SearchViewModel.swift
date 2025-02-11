//
//  SearchViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/11/25.
//

import Foundation

final class SearchViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    typealias Query = String
    
    //MARK: - Input
    struct Input {
        let query: Observable<Query?> = Observable(nil)
        let viewDidAppear: Observable<Void?> = Observable(nil)
        let likesDidChange: Observable<(Int?, Bool)> = Observable((nil, false))
        let prefetchRowsAt: Observable<[IndexPath]?> = Observable(nil)
        let didSelectRowAt: Observable<IndexPath?> = Observable(nil)
        let searchBarShouldBeginEditing: Observable<Void?> = Observable(nil)
        let searchBarCancelButtonClicked: Observable<Void?> = Observable(nil)
        let searchBarSearchButtonClicked: Observable<Query?> = Observable(nil)
    }
    
    //MARK: - Output
    struct Output {
        let navigationTitle = Observable("영화 검색")
        let backButtonTitle = Observable("")
        let showsKeyboard = Observable(false)
        let showsCancelButton = Observable(false)
        let showsNoneContentLabel = Observable(false)
        let searchBarText = Observable("")
        let movies: Observable<[Movie]> = Observable([])
        let pushVC: Observable<Movie?> = Observable(nil)
    }
    
    //MARK: - Property
    var searchDelegate: SearchDelegate?
    var likeDelegate: LikeDelegate?
    
    private var query: Query?
    private var page = Observable(0)
    private var totalPages: Int = 0
    private var totalResults: Int = 0
    private var isEnd: Bool = false
    
    //MARK: - Bind
    init() {
        input = Input()
        output = Output()
        
        input.query.lazyBind { [weak self] query in
            guard let query else {
                self?.output.searchBarText.value = ""
                self?.output.movies.value = []
                self?.totalPages = 0
                self?.totalResults = 0
                self?.isEnd = false
                return
            }
            
            guard self?.query != query else { return }
            
            self?.query = query
            self?.output.searchBarText.value = query
            self?.totalPages = 0
            self?.totalResults = 0
            self?.isEnd = false
            self?.page.value = 1
        }
        
        page.lazyBind { [weak self] page in
            self?.getMovies(of: self?.query)
        }
        
        input.viewDidAppear.lazyBind { [weak self] _ in
            if self?.query == nil {
                self?.output.showsKeyboard.value = true
            } else {
                self?.output.showsCancelButton.value = true
            }
        }
        
        input.likesDidChange.lazyBind { [weak self] (movieId, onlyCellReload) in
            guard let movieId, var movies = self?.output.movies.value else { return }
            
            if let index = User.likes.firstIndex(of: movieId) {
                User.likes.remove(at: index)
            } else {
                User.likes.append(movieId)
            }
            
            for i in movies.indices {
                if movies[i].id == movieId {
                    movies[i].is_like.toggle()
                }
            }
            
            self?.output.movies.value = movies
            self?.likeDelegate?.likesDidChange(movieId, onlyCellReload: true)
        }
        
        input.prefetchRowsAt.lazyBind { [weak self] indexPaths in
            self?.getPrefetchMovies(indexPaths)
        }
        
        input.didSelectRowAt.lazyBind { [weak self] indexPath in
            guard let indexPath else { return }
            
            self?.output.pushVC.value = self?.output.movies.value[indexPath.row]
        }
        
        input.searchBarShouldBeginEditing.lazyBind { [weak self] _ in
            self?.output.showsCancelButton.value = true
        }
        
        input.searchBarCancelButtonClicked.lazyBind { [weak self] _ in
            self?.output.showsKeyboard.value = false
            self?.output.showsCancelButton.value = false
            self?.input.query.value = nil
        }
        
        input.searchBarSearchButtonClicked.lazyBind { [weak self] query in
            self?.output.showsKeyboard.value = false
            self?.output.showsCancelButton.value = false
            
            guard var query else { return }
            
            query = query.trimmingCharacters(in: .whitespaces)
            
            guard !query.isEmpty else {
                return
            }
            
            self?.input.query.value = query
        }
    }
    
    private func getMovies(of query: Query?) {
        guard let query else { return }
        
        searchDelegate?.searchAdd(query)
        
        NetworkManager.shared.tmdb(.search(query, page.value), TMDBSearchResponse.self) { [weak self] data in
            if self?.page.value == 1 {
                self?.totalPages = data.total_pages
                self?.totalResults = data.total_results
                self?.output.movies.value = data.results
                self?.output.showsNoneContentLabel.value = !data.results.isEmpty
            } else {
                self?.output.movies.value.append(contentsOf: data.results)
            }
            
            if self?.page.value == self?.totalPages {
                self?.isEnd = true
            }
        } failHandler: { [weak self] code in
//            self?.presentErrorAlert(code)
            self?.totalPages = 0
            self?.totalResults = 0
            self?.output.movies.value = []
        }
        
    }
    
    private func getPrefetchMovies(_ indexPaths: [IndexPath]?) {
        guard let indexPaths else { return }
        
        guard !isEnd else { return }
        
        indexPaths.forEach {
            if output.movies.value.count - 2 == $0.row {
                page.value += 1
            }
        }
    }
    
}
