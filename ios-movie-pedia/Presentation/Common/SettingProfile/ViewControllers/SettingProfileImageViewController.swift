//
//  SettingProfileImageViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class SettingProfileImageViewController: BaseViewController {
    
    //MARK: - UI Property
    private lazy var mainView = SettingProfileImageView()
    
    //MARK: - Property
    let viewModel = SettingProfileImageViewModel()
    
    //MARK: - Initializer Method
    init(delegate: ProfileDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = delegate
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
    
    override func setupBinds() {
        viewModel.output.navTitle.bind { [weak self] title in
            self?.navigationItem.title = title
        }
        
        viewModel.output.profileImage.lazyBind { [weak self] image in
            self?.mainView.setData(image)
        }
        
        viewModel.output.collectionViewReloadItems.lazyBind { [weak self] indexPaths in
            guard let indexPaths else { return }
            self?.mainView.collectionView.reloadItems(at: indexPaths)
        }
    }
    
}

extension SettingProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.profilesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        
        guard let selectedImage = viewModel.output.profileImage.value else {
            return cell
        }
        
        let image = viewModel.output.profilesImages[indexPath.item]
        
        if image == selectedImage {
            cell.profileImageView.setEnable()
        } else {
            cell.profileImageView.setDisable()
        }
        
        cell.profileImageView.setData(image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input.profileImageDidSelect.value = indexPath
    }
    
}
