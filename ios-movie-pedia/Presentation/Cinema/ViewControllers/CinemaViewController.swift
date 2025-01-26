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
    private var profile = Profile() {
        didSet {
            mainView.userProfileView.configureData(profile)
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
        
        mainView.userProfileView.rightButton.addTarget(self, action: #selector(userRightButtonTapped), for: .touchUpInside)
        
        configureTableView()
        
        searches = ["search"]
        
        NetworkManager.shared.tmdb(.trending(), TMDBResponse.self) { data in
            self.movies = data.results
            self.mainView.tableView.reloadData()
        } failHandler: {
            print("실패")
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let saved = loadJsonData(type: Profile.self, forKey: "profile") {
            profile = saved
        }
    }
    
    //MARK: - Method
    @objc
    private func userRightButtonTapped() {
        let vc = SettingProfileViewController()
        vc.presentDelegate = self
        vc.modalPresentationStyle = .pageSheet
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    private func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ResentSearchTableViewCell.self, forCellReuseIdentifier: ResentSearchTableViewCell.id)
        mainView.tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
    }
    
}

//MARK: - ProfileDelegate
extension CinemaViewController: ProfileDelegate {
    
    func profileImageDidChange(_ image: String?) {
        profile.image = image
    }
    
    func nicknameDidChange(_ nickname: String?) {
        profile.nickname = nickname
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
            
            let row = searches[indexPath.item]
            cell.configureData(row)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
            
            let row = movies[indexPath.item]
            cell.configureData(row)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            print("최근검색어", indexPath)
        } else {
            print("영화", indexPath)
        }
    }
    
}

//MARK: - UserDelegate
extension CinemaViewController: SearchDelegate, LikeDelegate {
    
    func searchesDidChange() {
        searches = User.searches
        mainView.tableView.reloadData()
    }
    
    func likesDidChange() {
        mainView.tableView.reloadData()
    }
    
}
