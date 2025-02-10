//
//  CinemaViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class CinemaViewController: UIViewController {
    
    //MARK: - UI Property
    private let mainView = CinemaView()
    
    //MARK: - Property
    private var profile: Profile? {
        didSet {
            mainView.userProfileView.setData(profile, likes)
        }
    }
    private var likes = User.likes {
        didSet {
            mainView.userProfileView.setData(profile, likes)
        }
    }
    private let titles = ["최근검색어", "오늘의 영화"]
    private var searches: [String] = User.searches
    private var movies = [Movie]()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = makeBarButtonItemWithImage(
            "magnifyingglass",
            size: 15,
            handler: #selector(searchButtonTapped)
        )
        
        mainView.userProfileView.delegate = self
        configureTableView()
        callRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profile = UserStorage.shared.getProfile()
        likes = User.likes
    }
    
    //MARK: - Method
    @objc
    private func searchButtonTapped() {
        let vc = SearchViewController()
        vc.likeDelegate = self
        vc.searchDelegate = self
        pushVC(vc)
    }
    
    private func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ResentSearchTableViewCell.self, forCellReuseIdentifier: ResentSearchTableViewCell.id)
        mainView.tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
    }
    
    private func callRequest() {
        NetworkManager.shared.tmdb(.trending(), TMDBResponse.self) { data in
            self.movies = data.results
            self.mainView.tableView.reloadData()
        } failHandler: { code in
            self.presentErrorAlert(code)
            self.movies = []
            self.mainView.tableView.reloadData()
        }
    }
    
}

//MARK: - ProfileDelegate
extension CinemaViewController: ProfileDelegate {
    
    func profileImageDidChange(_ image: String?) {
        profile?.image = image
    }
    
    func nicknameDidChange(_ nickname: String?) {
        profile?.nickname = nickname
    }
    
    func didClickedProfileView() {
        let vc = SettingProfileViewController(delegate: self)
        vc.modalPresentationStyle = .pageSheet
        presentVC(UINavigationController(rootViewController: vc))
    }
    
}

//MARK: - UITableViewDelegate
extension CinemaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: ResentSearchTableViewCell.id, for: indexPath) as! ResentSearchTableViewCell
            
            cell.collectionView.reloadData()
            
            cell.delegate = self
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            
            cell.collectionView.tag = row
            cell.titleLabel.text = titles[row]
            
            cell.removeButton.isHidden = searches.isEmpty
            cell.noneContentLabel.isHidden = !searches.isEmpty
            
            return cell
        } else {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as! PosterTableViewCell
            
            cell.collectionView.reloadData()
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            
            cell.collectionView.tag = row
            cell.titleLabel.text = titles[row]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: - UICollectionViewDelegate
extension CinemaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return searches.count
        } else {
            return movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResentSearchCollectionViewCell.id, for: indexPath) as! ResentSearchCollectionViewCell
            
            cell.delegate = self
            
            let row = searches[indexPath.item]
            cell.setData(row)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
            
            cell.delegate = self
            
            let row = movies[indexPath.item]
            cell.setData(row)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            let vc = SearchViewController()
            vc.searchDelegate = self
            vc.likeDelegate = self
            vc.query = searches[indexPath.item]
            pushVC(vc)
        } else {
            let vc = CinemaDetailViewController()
            vc.delegate = self
            vc.movie = movies[indexPath.item]
            pushVC(vc)
        }
    }
    
}

//MARK: - UserDelegate
extension CinemaViewController: SearchDelegate, LikeDelegate {
    
    func searchAdd(_ text: String) {
        if let index = User.searches.lastIndex(of: text) {
            User.searches.remove(at: index)
        }
        
        User.searches.insert(text, at: 0)
        searches = User.searches
        mainView.tableView.reloadData()
    }
    
    func searchesRemoveAll() {
        User.searches.removeAll()
        searches = User.searches
        mainView.tableView.reloadData()
    }
    
    func searchRemove(_ title: String) {
        if let index = User.searches.firstIndex(of: title) {
            User.searches.remove(at: index)
        }
        
        searches = User.searches
        mainView.tableView.reloadData()
    }
    
    func likesDidChange(_ movieId: Int, onlyCellReload: Bool) {
        if onlyCellReload {
            for i in movies.indices {
                if movies[i].id == movieId {
                    movies[i].is_like.toggle()
                }
            }
            mainView.tableView.reloadData()
            return
        }
        
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
        
        mainView.tableView.reloadData()
        likes = User.likes
    }
    
}
