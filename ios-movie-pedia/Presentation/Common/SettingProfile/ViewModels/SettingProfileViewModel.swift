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
    
    let profileImageDidChange: Observable<String?> = Observable(nil)
    let profileNicknameDidChange: Observable<String?> = Observable(nil)
    let profileMbtiDidChange: Observable<IndexPath?> = Observable(nil)
    
    let inputProfileImageTapped: Observable<Void?> = Observable(nil)
    let inputBackButtonTapped: Observable<Void?> = Observable(nil)
    let inputSubmitButtonTapped: Observable<Void?> = Observable(nil)
    let inputSaveButtonTapped: Observable<Void?> = Observable(nil)
    
    //MARK: - Output
    let showsRightBarButtonItem: Observable<Bool> = Observable(false)
    let showsSubmitButton: Observable<Bool> = Observable(false)
    let leftBarButtonImage: Observable<String> = Observable("xmark")
    let navTitle = Observable("프로필 설정")
    
    let profileImage: Observable<String?> = Observable(nil)
    let profileNickname: Observable<String?> = Observable(nil)
    let profileMbti: Observable<[String?]> = Observable([nil, nil, nil, nil])
    
    let nicknameValidation: Observable<ProfileNicknameValidation> = Observable(.empty)
    let mbtiValidation: Observable<ProfileMbtiValidation> = Observable(.empty)
    let submitValidation: Observable<Bool> = Observable(false)
    
    let popVC: Observable<Void?> = Observable(nil)
    let dismissVC: Observable<Void?> = Observable(nil)
    
    let outputProfileImageTapped: Observable<String?> = Observable(nil)
    let outputSubmitButtonTapped: Observable<Void?> = Observable(nil)
    
    //MARK: - Property
    var profileDelegate: ProfileDelegate?
    let mbtiList = ["E", "I", "S", "N", "T", "F", "J", "P"]
    private var profile = Profile()
    
    //MARK: - Bind
    init() {
        isOnboarding.lazyBind { [weak self] isOnboarding in
            self?.showsRightBarButtonItem.value = isOnboarding
            self?.showsSubmitButton.value = !isOnboarding
            self?.leftBarButtonImage.value = isOnboarding ? "chevron.backward" : "xmark"
        }
        
        viewDidLoad.lazyBind { [weak self] _ in
            guard let profile = self?.getProfile() else { return }
            self?.profile = profile
            
            self?.profileImageDidChange.value = profile.image
            self?.profileNicknameDidChange.value = profile.nickname
            
            guard let mbti = profile.mbti else { return }
            self?.profileMbti.value = mbti
            self?.validation(of: profile.mbti)
        }
        
        profileImageDidChange.lazyBind { [weak self] image in
            self?.profileImage.value = image
            self?.profile.image = image
        }
        
        profileNicknameDidChange.lazyBind { [weak self] nickname in
            self?.profileNickname.value = nickname
            self?.validation(of: nickname)
            self?.profile.nickname = nickname
        }
        
        profileMbtiDidChange.lazyBind { [weak self] indexPath in
            guard let mbti = self?.updateSelectedMbti(indexPath) else { return }
            
            self?.profileMbti.value = mbti
            self?.validation(of: mbti)
            self?.profile.mbti = mbti
        }
        
        inputProfileImageTapped.lazyBind { [weak self] _ in
            self?.outputProfileImageTapped.value = self?.profile.image
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
            var copyProfile = self?.profile
            copyProfile?.created_at = DateFormatterManager.shared.getToday()
            UserDefaultManager.shared.saveJsonData(copyProfile, type: Profile.self, forKey: .profile)
            self?.outputSubmitButtonTapped.value = ()
        }
        
        inputSaveButtonTapped.lazyBind { [weak self] _ in
            UserDefaultManager.shared.saveJsonData(self?.profile, type: Profile.self, forKey: .profile)
            self?.profileDelegate?.profileImageDidChange(self?.profile.image)
            self?.profileDelegate?.nicknameDidChange(self?.profile.nickname)
            self?.dismissVC.value = ()
        }
    }
    
    //MARK: - Method
    //refactor point: load 여부 상관 없이 새로운 Profile 객체를 반환하는데, 메모리 누수 확인 필요
    private func getProfile() -> Profile {
        guard let savedProfile = UserDefaultManager.shared.loadJsonData(type: Profile.self, forKey: .profile) else {
            return Profile(image: Profile.randomImage, nickname: nil)
        }
        
        return savedProfile
    }
    
    private func updateSelectedMbti(_ indexPath: IndexPath?) -> [String?] {
        guard let indexPath else {
            return self.profileMbti.value
        }
        
        var updatedProfileMbti = self.profileMbti.value
        let character = mbtiList[indexPath.item]
        let sectionIndex = indexPath.item / 2
        let isSelected = profileMbti.value.contains(character)
        
        if isSelected {
            updatedProfileMbti[sectionIndex] = nil
        } else {
            updatedProfileMbti[sectionIndex] = character
        }
        
        return updatedProfileMbti
    }
    
    private func validation(of nickname: String?) {
        nicknameValidation.value = ProfileNicknameValidation(nickname)
        saveValidation()
    }
    
    private func validation(of mbti: [String?]?) {
        mbtiValidation.value = ProfileMbtiValidation(mbti)
        saveValidation()
    }
    
    private func saveValidation() {
        submitValidation.value = nicknameValidation.value.validation && mbtiValidation.value.validation
    }
}
