//
//  SettingProfileViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class SettingProfileViewController: UIViewController {
    
    //MARK: - UI Property
    private lazy var mainView = SettingProfileView(delegate: self)
    
    //MARK: - Property
    var profile = Profile()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "프로필 설정"
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
            profile = Profile(image: nil, nickname: nil)
        }
        
        mainView.configureData(profile)
        mainView.configureStatus(nicknameCondition(profile.nickname))
    }
    
    private func configureAction() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        mainView.profileImageView.addGestureRecognizer(singleTap)
        
        mainView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        UserDefaults.standard.removeObject(forKey: "profile")
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func profileImageViewTapped() {
        let vc = SettingProfileImageViewController()
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
    }
    
    func nicknameDidChange(_ nickname: String?) {
        profile.nickname = nickname
        
        let condition = nicknameCondition(nickname)
        mainView.configureStatus(condition)
    }
    
}
