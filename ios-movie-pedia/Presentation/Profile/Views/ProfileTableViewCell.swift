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
    func setData(_ menu: ProfileMenu) {
        titleLabel.text = menu.title
    }
    
    //MARK: - Override Method
    override func setupUI() {
        contentView.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.trailing.lessThanOrEqualTo(contentView).offset(-20)
            make.centerY.equalTo(contentView)
        }
    }
    
}
