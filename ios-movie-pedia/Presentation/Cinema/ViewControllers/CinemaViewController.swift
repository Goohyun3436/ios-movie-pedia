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
    private var resentSearchList = ["스파이더", "해리포터", "소방관", "스파이더", "해리포터", "소방관"]
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.userProfileView.rightButton.addTarget(self, action: #selector(userRightButtonTapped), for: .touchUpInside)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ResentSearchTableViewCell.self, forCellReuseIdentifier: ResentSearchTableViewCell.id)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: ResentSearchTableViewCell.id, for: indexPath) as! ResentSearchTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(ResentSearchCollectionViewCell.self, forCellWithReuseIdentifier: ResentSearchCollectionViewCell.id)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: - UICollectionViewDelegate
extension CinemaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resentSearchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResentSearchCollectionViewCell.id, for: indexPath) as! ResentSearchCollectionViewCell
        
        let row = resentSearchList[indexPath.item]
        cell.configureData(row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
