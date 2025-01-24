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
        
        mainView.nicknameTextField.delegate = self
        
        configureProfile()
        
        mainView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainView.nicknameTextField.becomeFirstResponder()
    }
    
    //MARK: - Method
    @objc
    private func submitButtonTapped() {
        print(#function)
        print(profile)
    }
    
    private func configureProfile() {
        profile = Profile(image: nil, nickname: nil)
        mainView.configureData(profile)
        mainView.configureStatus(nicknameCondition(nil))
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
