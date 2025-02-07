//
//  SettingProfileImageViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class SettingProfileImageViewController: UIViewController {
    
    //MARK: - UI Property
    private lazy var mainView = SettingProfileImageView()
    
    //MARK: - Property
    var profileImage: String?
    let profilesImages: [String] = [Int](0...11).map { "profile_\($0)" }
    var delegate: ProfileDelegate?
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "프로필 이미지 설정"
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
        
        mainView.configureData(profileImage)
    }
    
}

extension SettingProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profilesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        
        guard let selectedImage = profileImage else {
            return cell
        }
        
        let image = profilesImages[indexPath.item]
        
        if image == selectedImage {
            cell.profileImageView.setEnable()
        } else {
            cell.profileImageView.setDisable()
        }
        
        cell.profileImageView.configureData(image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let profileImage else {
            return
        }
        
        guard let beforeItem = profilesImages.firstIndex(of: profileImage) else {
            return
        }
        
        self.profileImage = profilesImages[indexPath.item]
        mainView.configureData(self.profileImage)
        delegate?.profileImageDidChange(self.profileImage)
        collectionView.reloadItems(at: [indexPath, IndexPath(item: beforeItem, section: 0)])
    }
    
}
