//
//  CinemaDetailViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/11/25.
//

import Foundation

final class CinemaDetailViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    //MARK: - Input
    struct Input {
        let movieDidChange: Observable<Movie?> = Observable(nil)
        let likeButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    //MARK: - Output
    struct Output {
        let navigationTitle = Observable("")
        let likeButtonValidation = Observable(false)
        let contents = CinemaDetailContent.allCases
        let movie: Observable<Movie?> = Observable(nil)
        let cast: Observable<[Person]> = Observable([])
        let backdrops: Observable<[Image]> = Observable([])
        let posters: Observable<[Image]> = Observable([])
        let isLike = Observable(false)
        let isMore = Observable(false)
        let tableViewReloadData: Observable<Void?> = Observable(nil)
        let error: Observable<TMDBStatusCode> = Observable(.success)
    }
    
    //MARK: - Property
    var delegate: LikeDelegate?
    
    //MARK: - Bind
    init() {
        print("CinemaDetailViewModel", "init")
        
        input = Input()
        output = Output()
        
        input.movieDidChange.lazyBind { [weak self] movie in
            print("movieDidChange")
            self?.getMovieDetail(of: movie?.id)
            self?.output.movie.value = movie
            self?.output.navigationTitle.value = movie?.title ?? ""
            self?.output.likeButtonValidation.value = movie?.release_date != nil
            self?.output.isLike.value = movie?.is_like ?? false
        }
        
        input.likeButtonTapped.lazyBind { [weak self] _ in
            print("likeButtonTapped")
            guard let movieId = self?.output.movie.value?.id else { return }
            
            self?.output.isLike.value.toggle()
            self?.delegate?.likesDidChange(movieId, onlyCellReload: false)
        }
    }
    
    deinit {
        print("CinemaDetailViewModel", "deinit")
    }
    
    //MARK: - Method
    private func getMovieDetail(of movieId: Int?) {
        guard let movieId else { return }
        
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.tmdb(.images(movieId), TMDBImagesResponse.self) { [weak self] data in
            self?.output.backdrops.value = data.backdrops
            self?.output.posters.value = data.posters
            group.leave()
        } failHandler: { [weak self] code in
            self?.output.error.value = code
            self?.output.backdrops.value = []
            self?.output.posters.value = []
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.tmdb(.credits(movieId, .en), TMDBCreditsResponse.self) { [weak self] data in
            self?.output.cast.value = data.cast
            group.leave()
        } failHandler: { [weak self] code in
            self?.output.error.value = code
            self?.output.cast.value = []
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.output.tableViewReloadData.value = ()
        }
        
    }
    
}
