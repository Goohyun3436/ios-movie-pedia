//
//  SettingProfileViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/7/25.
//

import Foundation

final class SettingProfileViewModel {
    
    //MARK: - Input
    var isOnboarding: Observable<Bool> = Observable(false)
    let viewDidLoad: Observable<Void?> = Observable(nil)
    let viewDidAppear: Observable<Void?> = Observable(nil)
    let viewWillDisappear: Observable<Void?> = Observable(nil)
    let profileImage: Observable<String?> = Observable(nil)
    let profileNickname: Observable<String?> = Observable(nil)
    let profileMbti: Observable<[String?]> = Observable([])
    let inputMainViewTapped: Observable<Void?> = Observable(nil)
    let inputTextFieldShouldReturn: Observable<Void?> = Observable(nil)
    let inputProfileImageTapped: Observable<Void?> = Observable(nil)
    let inputBackButtonTapped: Observable<Void?> = Observable(nil)
    let inputSubmitButtonTapped: Observable<Void?> = Observable(nil)
    let inputSaveButtonTapped: Observable<Void?> = Observable(nil)
    
    //MARK: - Output
    let showsRightBarButtonItem: Observable<Bool> = Observable(false)
    let showsSubmitButton: Observable<Bool> = Observable(false)
    let navTitle = Observable("프로필 설정")
    let profile = Observable(Profile())
    let nicknameValidation: Observable<ProfileNicknameValidation> = Observable(.out_of_range)
    let mbtiValidation: Observable<ProfileMbtiValidation> = Observable(.empty)
    let submitValidation: Observable<Bool> = Observable(false)
    let popVC: Observable<Void?> = Observable(nil)
    let dismissVC: Observable<Void?> = Observable(nil)
    let outputProfileImageTapped: Observable<String?> = Observable(nil)
    let outputSubmitButtonTapped: Observable<Void?> = Observable(nil)
    let showsKeyboard: Observable<Bool> = Observable(false)
    
    //MARK: - Property
    var profileDelegate: ProfileDelegate?
    
    //MARK: - Initializer Method
    init() {
        isOnboarding.lazyBind { [weak self] isOnboarding in
            self?.showsRightBarButtonItem.value = isOnboarding
            self?.showsSubmitButton.value = !isOnboarding
        }
        
        viewDidLoad.lazyBind { [weak self] _ in
            guard let profile = self?.getProfile() else { return }
            self?.profile.value = profile
        }
        
        viewDidAppear.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = true
        }
        
        viewWillDisappear.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = false
        }
        
        profileImage.lazyBind { [weak self] image in
            self?.profile.value.image = image
        }
        
        profileNickname.lazyBind { [weak self] nickname in
            self?.profile.value.nickname = nickname
            self?.validation(of: nickname)
        }
        
        profileMbti.lazyBind { [weak self] mbti in
            self?.validation(of: mbti)
        }
        
        inputMainViewTapped.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = false
        }
        
        inputTextFieldShouldReturn.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = false
        }
        
        inputProfileImageTapped.lazyBind { [weak self] _ in
            self?.outputProfileImageTapped.value = self?.profile.value.image
        }
        
        inputBackButtonTapped.lazyBind { [weak self] _ in
            guard let isOnboarding = self?.isOnboarding.value else { return }
            
            if isOnboarding {
                self?.popVC.value = ()
            } else {
                self?.dismissVC.value = ()
            }
        }
        
        inputSubmitButtonTapped.lazyBind { [weak self] _ in
            self?.profile.value.created_at = self?.getToday()
            UserDefaultManager.shared.saveJsonData(self?.profile.value, type: Profile.self, forKey: .profile)
            self?.outputSubmitButtonTapped.value = ()
        }
        
        inputSaveButtonTapped.lazyBind { [weak self] _ in
            UserDefaultManager.shared.saveJsonData(self?.profile.value, type: Profile.self, forKey: .profile)
            self?.profileDelegate?.profileImageDidChange(self?.profile.value.image)
            self?.profileDelegate?.nicknameDidChange(self?.profile.value.nickname)
            self?.dismissVC.value = ()
        }
    }
    
    private func getProfile() -> Profile {
        guard let savedProfile = UserDefaultManager.shared.loadJsonData(type: Profile.self, forKey: .profile) else {
            return Profile(image: Profile.randomImage, nickname: nil)
        }
        
        return savedProfile
    }
    
    private func getToday() -> String {
        let formatter = DateFormatter()  //refactor point: DateFormatter 싱글톤 적용
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let today = formatter.string(from: Date())
        return today
    }
    
    private func validation(of nickname: String?) {
        nicknameValidation.value = ProfileNicknameValidation(nickname)
        saveValidation()
    }
    
    private func validation(of mbti: [String?]) {
        mbtiValidation.value = ProfileMbtiValidation(mbti)
        saveValidation()
    }
    
    private func saveValidation() {
        submitValidation.value = nicknameValidation.value.validation && mbtiValidation.value.validation
    }
}
