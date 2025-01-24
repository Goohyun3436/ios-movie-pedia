//
//  SettingProfileView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit
import SnapKit

final class SettingProfileView: BaseView {
    
    //MARK: - UI Property
    let profileImageView = ProfileImageView()
    let nicknameTextField = UITextField()
    private let statusLabel = UILabel()
    let submitButton = AccentButton("완료")
    
    //MARK: - Initializer Method
    init(delegate: ProfileDelegate) {
        super.init(frame: .zero)
        profileImageView.delegate = delegate
    }
    
    //MARK: - Method
    func configureData(_ profile: Profile) {
        profileImageView.configureData(profile.image)
        nicknameTextField.text = profile.nickname
    }
    
    func configureStatus(_ condition: NicknameCondition) {
        statusLabel.text = condition.msg
        
        if condition == .satisfied {
            submitButton.setEnabled()
        } else {
            submitButton.setDisabled()
        }
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(nicknameTextField)
        addSubview(statusLabel)
        addSubview(submitButton)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.height.equalTo(40)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(16)
        }
        
        submitButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(statusLabel.snp.bottom).offset(32)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        nicknameTextField.placeholder = "닉네임"
        nicknameTextField.font = UIFont.systemFont(ofSize: 14)
        nicknameTextField.addLeftPadding(16)
        nicknameTextField.configurePlaceholder(color: AppColor.secondaryLabel)
        
        statusLabel.font = UIFont.systemFont(ofSize: 12)
        statusLabel.textColor = AppColor.accent
        
        DispatchQueue.main.async {
            self.nicknameTextField.configureBorderBottom(1)
        }
    }
    
}
