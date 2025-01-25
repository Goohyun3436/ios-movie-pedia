//
//  SettingProfileViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class SettingProfileViewController: UIViewController {
    
    //MARK: - UI Property
    private lazy var mainView = SettingProfileView()
    
    //MARK: - Property
    var profile = Profile()
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.nicknameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
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
    
    @objc
    private func mainViewTapped() {
        mainView.nicknameTextField.resignFirstResponder()
    }
    
    @objc
    private func backButtonTapped() {
        UserDefaults.standard.removeObject(forKey: "profile")
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func profileImageViewTapped() {
        let vc = SettingProfileImageViewController()
        vc.delegate = self
        vc.profile = profile
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func submitButtonTapped() {
        saveJsonData(profile, type: Profile.self, forKey: "profile")
        
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            return
        }

        window.rootViewController = TabBarController()
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
    }
    
}
