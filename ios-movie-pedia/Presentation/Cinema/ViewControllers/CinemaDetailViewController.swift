//
//  CinemaDetailViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class CinemaDetailViewController: UIViewController {
    
    //MARK: - UI Property
    private let mainView = CinemaDetailView()
    lazy private var likeButton = {
        let button = LikeButton()
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Property
    var delegate: LikeDelegate?
    private let titles = ["Synopsis", "Cast", "Poster"]
    var movie: Movie?
    private var cast = [Person]()
    private var backdrops = [Image]()
    private var posters = [Image]()
    private var isLike: Bool = false {
        didSet {
            likeButton.setLikeButton(isLike)
        }
    }
    private var isMore: Bool = false
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        guard let movie else {
            return
        }
        
        navigationItem.title = movie.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
        isLike = movie.is_like
        callRequest(movie.id)
    }
    
    private func callRequest(_ movieId: Int) {
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.tmdb(.images(movieId), TMDBImagesResponse.self) { data in
            self.backdrops = data.backdrops
            self.posters = data.posters
            group.leave()
        } failHandler: {
            print("실패")
            self.backdrops = []
            self.posters = []
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.tmdb(.credits(movieId, .en), TMDBCreditsResponse.self) { data in
            self.cast = data.cast
            group.leave()
        } failHandler: {
            print("실패")
            self.cast = []
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.backdropScrollView.images = self.backdrops
            self.mainView.tableView.reloadData()
        }
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

//MARK: - UITableViewDelegate
extension CinemaDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.id, for: indexPath) as! OverviewTableViewCell
            
            cell.delegate = self
            
            cell.configureData(titles[row], movie?.overview)
            
            return cell
        } else if row == 1 {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.id, for: indexPath) as! CastTableViewCell
            
            cell.configureData(titles[row], cast)
            
            return cell
        } else {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: PosterMiniTableViewCell.id, for: indexPath) as! PosterMiniTableViewCell
            
            cell.configureData(titles[row], posters)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: - MoreDelegate
extension CinemaDetailViewController: MoreDelegate {
    
    func didChange(_ isMore: Bool) {
        mainView.configureTableViewHeight()
    }
    
}
