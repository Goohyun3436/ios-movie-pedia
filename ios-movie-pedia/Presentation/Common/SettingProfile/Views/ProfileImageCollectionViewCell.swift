//
//  ProfileImageCollectionViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/25/25.
//

import UIKit
import SnapKit

class ProfileImageCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - UI Property
    lazy var profileImageView = ProfileImageView(frame: self.frame, camera: false)
    
    //MARK: - Property
    static let id = "ProfileImageCollectionViewCell"
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(profileImageView)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
}

