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
    private let rightButton = UIButton()
    private let bottomButton = AccentFillButton("0개의 무비박스 보관중")
    
    //MARK: - Method
    func configureData(_ profile: Profile) {
        profileImage.configureData(profile.image)
        nicknameLabel.text = profile.nickname
        nicknameLabel.text = "세상에서가장긴닉네임이존재한다면아마두줄세줄네줄다섯줄여섯줄이되겠죠"
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
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(rightButton.snp.leading).offset(-12)
            make.top.equalToSuperview().offset(20)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
        }
        
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(profileImage.snp.centerY)
            make.size.equalTo(30)
        }
        
        bottomButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.greaterThanOrEqualTo(profileImage.snp.bottom).offset(16)
            make.top.equalTo(createdAtLabel.snp.bottom).offset(16)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func configureView() {
        backgroundColor = AppColor.tertiaryBackgroundColor
        nicknameLabel.numberOfLines = 0
        nicknameLabel.backgroundColor = .orange
        rightButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        rightButton.tintColor = AppColor.darkgray
    }
    
}
