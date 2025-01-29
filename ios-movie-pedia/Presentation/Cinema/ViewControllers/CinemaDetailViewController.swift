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
        
        mainView.backdropScrollView.images = ["heart", "heart.fill", "star", "star", "star", "star"]
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
//        
//        NetworkManager.shared.tmdb(.credits(604362, .en), TMDBCreditsResponse.self) { data in
//            print(data)
//        } failHandler: {
//            print("실패")
//        }
        
        guard let movie else {
            return
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
        
        navigationItem.title = movie.title
        isLike = movie.is_like
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
            
            cell.configureData(titles[row], "overviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverview")
            
            return cell
        } else if row == 1 {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.id, for: indexPath) as! CastTableViewCell
            
            cell.configureData(titles[row], [
                Person(name: "Kwon Sang-woo", original_name: "권상우", profile_path: "/sXWZ82ph4ZPPG9kv2x6nXha1Kk4.jpg"),
                Person(name: "Kwon Sang-woo", original_name: "권상우", profile_path: "/sXWZ82ph4ZPPG9kv2x6nXha1Kk4.jpg"),
                Person(name: "Kwon Sang-woo", original_name: "권상우", profile_path: "/sXWZ82ph4ZPPG9kv2x6nXha1Kk4.jpg"),
                Person(name: "Kwon Sang-woo", original_name: "권상우", profile_path: "/sXWZ82ph4ZPPG9kv2x6nXha1Kk4.jpg"),
                Person(name: "Kwon Sang-woo", original_name: "권상우", profile_path: "/sXWZ82ph4ZPPG9kv2x6nXha1Kk4.jpg")
            ])
            
            return cell
        } else {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.id, for: indexPath) as! OverviewTableViewCell
            
            cell.configureData(titles[row], "overviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverview")
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
