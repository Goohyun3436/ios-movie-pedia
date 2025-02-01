//
//  ProfileTableViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/29/25.
//

import UIKit
import SnapKit

final class ProfileTableViewCell: BaseTableViewCell {
    
    //MARK: - UI Property
    private let titleLabel = AppLabel(.text2)
    
    //MARK: - Property
    static let id = "ProfileTableViewCell"
    
    //MARK: - Method
    func configureData(_ title: String) {
        titleLabel.text = title
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.trailing.lessThanOrEqualTo(contentView).offset(-20)
            make.centerY.equalTo(contentView)
        }
    }
    
}
