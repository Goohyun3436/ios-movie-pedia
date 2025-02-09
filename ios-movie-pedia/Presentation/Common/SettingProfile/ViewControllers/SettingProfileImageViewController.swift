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
    let viewModel = SettingProfileImageViewModel()
    
    //MARK: - Initializer Method
    init(delegate: ProfileDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = delegate
        setupBinds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
    }
    
    private func setupBinds() {
        viewModel.navTitle.bind { [weak self] title in
            self?.navigationItem.title = title
        }
        
        viewModel.profileImage.lazyBind { [weak self] image in
            self?.mainView.configureData(image)
        }
        
        viewModel.collectionViewReloadItems.lazyBind { [weak self] indexPaths in
            guard let indexPaths else { return }
            self?.mainView.collectionView.reloadItems(at: indexPaths)
        }
    }
    
}

extension SettingProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.profilesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        
        guard let selectedImage = viewModel.profileImage.value else {
            return cell
        }
        
        let image = viewModel.profilesImages[indexPath.item]
        
        if image == selectedImage {
            cell.profileImageView.setEnable()
        } else {
            cell.profileImageView.setDisable()
        }
        
        cell.profileImageView.configureData(image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.profileImageDidSelect.value = indexPath
    }
    
}
