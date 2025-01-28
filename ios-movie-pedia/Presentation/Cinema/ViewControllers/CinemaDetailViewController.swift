//
//  CinemaDetailViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

class CinemaDetailViewController: UIViewController {
    
    //MARK: - UI Property
    private let mainView = CinemaDetailView()
    lazy private var likeButton = {
        let button = LikeButton()
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Property
    var delegate: LikeDelegate?
    var movie: Movie?
    private var isLike: Bool = false {
        didSet {
            likeButton.setLikeButton(isLike)
        }
    }
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie else {
            return
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
        
        navigationItem.title = movie.title
        isLike = movie.is_like
        
        print(movie)
    }
    
    //MARK: - Method
    @objc
    private func likeButtonTapped() {
        guard let movieId = movie?.id else {
            return
        }
        
        isLike.toggle()
        delegate?.likesDidChange(movieId, onlyCellReload: false)
    }
    
}
