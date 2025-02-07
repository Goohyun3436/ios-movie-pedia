//
//  SettingProfileViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class SettingProfileViewController: UIViewController {
    
    //MARK: - UI Property
    private let mainView = SettingProfileView()
    
    //MARK: - Property
    private var profile = Profile()
    var presentDelegate: ProfileDelegate?
    var isOnboarding: Bool = false
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "프로필 설정"
        navigationItem.backButtonTitle = ""
        mainView.nicknameTextField.delegate = self
        configureProfile()
        configureAction()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.nicknameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainView.nicknameTextField.resignFirstResponder()
    }
    
    //MARK: - Method
    private func configureProfile() {
        if let savedProfile = loadJsonData(type: Profile.self, forKey: "profile") {
            profile = savedProfile
        } else {
            let randomImage = "profile_\(Int.random(in: 0...11))"
            profileImageDidChange(randomImage)
            profile = Profile(image: randomImage, nickname: nil)
        }
        
        mainView.configureData(profile)
        mainView.configureStatus(nicknameCondition(profile.nickname))
    }
    
    private func configureAction() {
        navigationItem.leftBarButtonItem = makeBarButtonItemWithImage(
            isOnboarding ? "chevron.backward" : "xmark",
            handler: #selector(backButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = makeBarButtonItemWithTitle(
            "저장",
            handler: #selector(saveButtonTapped)
        )
        
        mainView.isUserInteractionEnabled = true
        mainView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(mainViewTapped)
        ))
        
        mainView.profileImageView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(profileImageViewTapped)
        ))
        
        mainView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    private func configureView() {
        mainView.submitButton.setDisabled()
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        if isOnboarding {
            navigationItem.rightBarButtonItem?.isHidden = true
        } else {
            mainView.submitButton.isHidden = true
        }
    }
    
    @objc
    private func mainViewTapped() {
        mainView.nicknameTextField.resignFirstResponder()
    }
    
    @objc
    private func backButtonTapped() {
        if isOnboarding {
            UserDefaults.standard.removeObject(forKey: "profile")
            popVC()
        } else {
            dismissVC()
        }
    }
    
    @objc
    private func profileImageViewTapped() {
        let vc = SettingProfileImageViewController()
        vc.delegate = self
        vc.profile = profile
        pushVC(vc)
    }
    
    @objc
    private func submitButtonTapped() {
        profile.created_at = getToday()
        
        saveJsonData(profile, type: Profile.self, forKey: "profile")
        
        configureRootVC(TabBarController())
    }
    
    @objc
    private func saveButtonTapped() {
        saveJsonData(profile, type: Profile.self, forKey: "profile")
        presentDelegate?.profileImageDidChange(profile.image)
        presentDelegate?.nicknameDidChange(profile.nickname)
        dismissVC()
    }
    
    private func nicknameCondition(_ nickname: String?) -> NicknameCondition {
        guard var nickname else {
            return .length
        }
        
        nickname = nickname.trimmingCharacters(in: .whitespaces)
        
        guard !nickname.matches("[0-9]") else {
            return .number
        }
        
        guard !nickname.matches("[@#$%]") else {
            return .symbol
        }
        
        guard 2 <= nickname.count && nickname.count < 10 else {
            return .length
        }
        
        return .satisfied
    }
    
}

//MARK: - UITextFieldDelegate
extension SettingProfileViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        nicknameDidChange(textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

//MARK: - ProfileDelegate
extension SettingProfileViewController: ProfileDelegate {
    
    func profileImageDidChange(_ image: String?) {
        profile.image = image
        mainView.configureData(profile)
    }
    
    func nicknameDidChange(_ nickname: String?) {
        profile.nickname = nickname
        
        let condition = nicknameCondition(nickname)
        mainView.configureStatus(condition)
        
        if condition == .satisfied {
            mainView.submitButton.setEnabled()
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            mainView.submitButton.setDisabled()
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func didClickedProfileView() {}
    
}
