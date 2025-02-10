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
    private let nicknameLabel = AppLabel(.title1)
    private let createdAtLabel = AppLabel(.text4, AppColor.darkgray)
    private let rightImageView = UIImageView()
    private let bottomButton = AccentFillButton()
    
    //MARK: - Property
    var delegate: ProfileDelegate?
    
    //MARK: - Initializer Method
    init() {
        super.init(frame: .zero)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(userProfileViewTapped))
        addGestureRecognizer(singleTap)
        isUserInteractionEnabled = true
    }
    
    //MARK: - Method
    func setData(_ profile: Profile?) {
        profileImage.setData(profile?.image)
        nicknameLabel.text = profile?.nickname
        createdAtLabel.text = profile?.createdAtFormat
    }
    
    func setData(_ likes: [Int]) {
        bottomButton.setTitle("\(likes.count)개의 무비박스 보관중", for: .normal)
    }
    
    @objc
    private func userProfileViewTapped() {
        delegate?.didClickedProfileView()
    }
    
    //MARK: - Override Method
    override func setupUI() {
        [profileImage, nicknameLabel, createdAtLabel, rightImageView, bottomButton].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
        profileImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(rightImageView.snp.leading).offset(-12)
            make.top.equalToSuperview().offset(18)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.top.greaterThanOrEqualToSuperview().offset(12)
            make.centerY.equalTo(profileImage.snp.centerY)
            make.bottom.lessThanOrEqualTo(bottomButton.snp.top).offset(0)
            make.width.equalTo(14)
            make.height.equalTo(24)
        }
        
        bottomButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.top.greaterThanOrEqualTo(profileImage.snp.bottom).offset(16)
            make.top.equalTo(createdAtLabel.snp.bottom).offset(22)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    override func setupAttributes() {
        layer.cornerRadius = 16
        backgroundColor = AppColor.tertiaryBackgroundColor
        nicknameLabel.numberOfLines = 0
        rightImageView.image = UIImage(systemName: "chevron.right")
        rightImageView.tintColor = AppColor.darkgray
    }
    
}
