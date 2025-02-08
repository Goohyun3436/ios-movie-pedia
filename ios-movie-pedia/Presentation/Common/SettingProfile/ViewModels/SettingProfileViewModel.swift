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
    let profileMbti: Observable<[String?]> = Observable([nil, nil, nil, nil])
    
    let textFieldShouldReturn: Observable<Void?> = Observable(nil)
    let didSelectItemAt: Observable<IndexPath?> = Observable(nil)
    
    let inputMainViewTapped: Observable<Void?> = Observable(nil)
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
    let mbtiList = [ "E", "I", "S", "N", "T", "F", "J", "P"]
    
    //MARK: - Initializer Method
    init() {
        isOnboarding.lazyBind { [weak self] isOnboarding in
            self?.showsRightBarButtonItem.value = isOnboarding
            self?.showsSubmitButton.value = !isOnboarding
        }
        
        viewDidLoad.lazyBind { [weak self] _ in
            guard let profile = self?.getProfile() else { return }
            print("viewDidLoad")
            self?.profile.value = profile
            
            guard let mbti = profile.mbti else { return }
            self?.profileMbti.value = mbti
            self?.validation(of: profile.mbti)
        }
        
        viewDidAppear.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = true
        }
        
        viewWillDisappear.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = false
        }
        
        profileImage.lazyBind { [weak self] image in
            print("profileImage")
            self?.profile.value.image = image
        }
        
        profileNickname.lazyBind { [weak self] nickname in
            print("profileNickname")
            self?.profile.value.nickname = nickname
            self?.validation(of: nickname)
        }
        
        profileMbti.lazyBind { [weak self] mbti in
            print("profileMbti")
            self?.validation(of: mbti)
        }
        
        textFieldShouldReturn.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = false
        }
        
        didSelectItemAt.lazyBind { [weak self] indexPath in
            self?.updateSelectedMbti(indexPath)
        }
        
        inputMainViewTapped.lazyBind { [weak self] _ in
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
            var copyProfile = self?.profile.value
            copyProfile?.mbti = self?.profileMbti.value
            copyProfile?.created_at = self?.getToday()
            UserDefaultManager.shared.saveJsonData(copyProfile, type: Profile.self, forKey: .profile)
            self?.outputSubmitButtonTapped.value = ()
        }
        
        inputSaveButtonTapped.lazyBind { [weak self] _ in
            var copyProfile = self?.profile.value
            copyProfile?.mbti = self?.profileMbti.value
            UserDefaultManager.shared.saveJsonData(copyProfile, type: Profile.self, forKey: .profile)
            self?.profileDelegate?.profileImageDidChange(self?.profile.value.image)
            self?.profileDelegate?.nicknameDidChange(self?.profile.value.nickname)
            self?.dismissVC.value = ()
        }
    }
    
    //refactor point: load 여부 상관 없이 새로운 Profile 객체를 반환하는데, 메모리 누수 확인 필요
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
    
    private func updateSelectedMbti(_ indexPath: IndexPath?) {
        guard let indexPath else { return }
        
        let character = mbtiList[indexPath.item]
        let sectionIndex = indexPath.item / 2
        
        let isSelected = profileMbti.value.contains(character)
        
        if isSelected {
            profileMbti.value[sectionIndex] = nil
        } else {
            profileMbti.value[sectionIndex] = character
        }
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
