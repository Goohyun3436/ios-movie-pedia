//
//  SettingProfileImageView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/25/25.
//

import UIKit
import SnapKit

final class SettingProfileImageView: BaseView {
    
    //MARK: - UI Property
    private var profileImageView = ProfileImageView(camera: true)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        
        let inset: CGFloat = 16
        let spacing: CGFloat = 16
        let cellPerRow: CGFloat = 4
        let width: CGFloat = (UIScreen.main.bounds.width - inset * 2 - spacing * (cellPerRow - 1)) / cellPerRow
        let height: CGFloat = width
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }())
    
    //MARK: - Method
    func configureData(_ profileImage: String?) {
        profileImageView.configureData(profileImage)
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(50)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
    }
}
