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
    let profileImageView = ProfileImageView(camera: true)
    let nicknameTextField = UITextField()
    private let nicknameStatusLabel = AppLabel(.text4, AppColor.accent)
    private lazy var mbtiSelectorView = MbtiSelectorView()
    private let mbtiStatusLabel = AppLabel(.text4, AppColor.accent)
    let submitButton = AccentBorderButton("완료")
    
    //MARK: - Initializer Method
    init(delegate: MbtiDelegate) {
        super.init(frame: .zero)
        mbtiSelectorView.viewModel.delegate = delegate
    }
    
    //MARK: - Method
    func configureData(_ profile: Profile) {
        profileImageView.configureData(profile.image)
        nicknameTextField.text = profile.nickname
    }
    
    func configureStatus(
        nicknameValidation: ProfileNicknameValidation? = nil,
        mbtiValidation: ProfileMbtiValidation? = nil
    ) {
        if let nicknameValidation {
            nicknameStatusLabel.text = nicknameValidation.message
            nicknameStatusLabel.textColor = nicknameValidation.validation ? AppColor.accent : AppColor.red
            return
        }
        
        if let mbtiValidation {
            mbtiStatusLabel.text = mbtiValidation.message
            mbtiStatusLabel.textColor = mbtiValidation.validation ? AppColor.accent : AppColor.red
            return
        }
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(nicknameTextField)
        addSubview(nicknameStatusLabel)
        addSubview(mbtiSelectorView)
        addSubview(mbtiStatusLabel)
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
        
        nicknameStatusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(16)
        }
        
        mbtiSelectorView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(nicknameStatusLabel.snp.bottom).offset(32)
        }
        
        mbtiStatusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(mbtiSelectorView.snp.bottom).offset(16)
        }
        
        submitButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(32)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        nicknameTextField.placeholder = "닉네임"
        nicknameTextField.font = AppFont.text2.font
        nicknameTextField.addLeftPadding(16)
        nicknameTextField.configurePlaceholder(color: AppColor.secondaryLabel)
        
        DispatchQueue.main.async {
            self.nicknameTextField.configureBorderBottom(1)
        }
    }
    
}
