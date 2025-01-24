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
        
        profile = Profile(image: nil, nickname: nil)
        mainView.configureData(profile)
        mainView.configureStatus(NicknameCondition.length)
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
    
}

//MARK: - UITextFieldDelegate
extension SettingProfileViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        nicknameDidChange(textField.text)
        
        guard var name = textField.text else {
            return
        }
        
        name = name.trimmingCharacters(in: .whitespaces)
        
        guard !name.matches("[0-9]") else {
            mainView.configureStatus(NicknameCondition.number)
            return
        }
        
        guard !name.matches("[@#$%]") else {
            mainView.configureStatus(NicknameCondition.symbol)
            return
        }
        
        guard 2 <= name.count && name.count < 10 else {
            mainView.configureStatus(NicknameCondition.length)
            return
        }
        
        mainView.configureStatus(NicknameCondition.satisfied)
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
    }
    
}
