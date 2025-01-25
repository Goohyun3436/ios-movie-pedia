//
//  UserProfileView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/25/25.
//

import UIKit
import SnapKit

final class UserProfileView: BaseView {
    
    //MARK: - UI Property
    private let profileImage = ProfileImageView(frame: CGRect(x: .zero, y: .zero, width: 50, height: 50), camera: false)
    private let nicknameLabel = UILabel()
    private let createdAtLabel = UILabel()
    let rightButton = UIButton()
    private let bottomButton = AccentFillButton("0개의 무비박스 보관중")
    
    //MARK: - Method
    func configureData(_ profile: Profile) {
        profileImage.configureData(profile.image)
        nicknameLabel.text = profile.nickname
        createdAtLabel.text = profile.createdAtFormat
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(profileImage)
        addSubview(nicknameLabel)
        addSubview(createdAtLabel)
        addSubview(rightButton)
        addSubview(bottomButton)
    }
    
    override func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(rightButton.snp.leading).offset(-12)
            make.top.equalToSuperview().offset(18)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
        }
        
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().offset(12)
            make.centerY.equalTo(profileImage.snp.centerY)
            make.width.equalTo(30)
            make.bottom.equalTo(bottomButton.snp.top).offset(-16)
        }
        
        bottomButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.top.greaterThanOrEqualTo(profileImage.snp.bottom).offset(16)
            make.top.equalTo(createdAtLabel.snp.bottom).offset(22)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    override func configureView() {
        layer.cornerRadius = 16
        backgroundColor = AppColor.tertiaryBackgroundColor
        
        nicknameLabel.numberOfLines = 0
        nicknameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        createdAtLabel.font = UIFont.systemFont(ofSize: 12)
        createdAtLabel.textColor = AppColor.darkgray
        
        rightButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        rightButton.contentHorizontalAlignment = .trailing
        rightButton.tintColor = AppColor.darkgray
    }
    
}
