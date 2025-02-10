//
//  SettingProfileViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/7/25.
//

import Foundation

final class SettingProfileViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    //MARK: - Input
    struct Input {
        var isOnboarding: Observable<Bool> = Observable(false)
        let viewDidLoad: Observable<Void?> = Observable(nil)
        
        let profileImageDidChange: Observable<String?> = Observable(nil)
        let profileNicknameDidChange: Observable<String?> = Observable(nil)
        let profileMbtiDidChange: Observable<IndexPath?> = Observable(nil)
        
        let profileImageTapped: Observable<Void?> = Observable(nil)
        let backButtonTapped: Observable<Void?> = Observable(nil)
        let submitButtonTapped: Observable<Void?> = Observable(nil)
        let saveButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    //MARK: - Output
    struct Output {
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
        
        let profileImageTapped: Observable<String?> = Observable(nil)
        let submitButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    //MARK: - Property
    var profileDelegate: ProfileDelegate?
    let mbtiList = ["E", "I", "S", "N", "T", "F", "J", "P"]
    private var profile = Profile()
    
    //MARK: - Bind
    init() {
        input = Input()
        output = Output()
        
        input.isOnboarding.lazyBind { [weak self] isOnboarding in
            self?.output.showsRightBarButtonItem.value = isOnboarding
            self?.output.showsSubmitButton.value = !isOnboarding
            self?.output.leftBarButtonImage.value = isOnboarding ? "chevron.backward" : "xmark"
        }
        
        input.viewDidLoad.lazyBind { [weak self] _ in
            let profile = UserStorage.shared.getProfile()
            self?.profile = profile
            
            self?.input.profileImageDidChange.value = profile.image
            self?.input.profileNicknameDidChange.value = profile.nickname
            
            guard let mbti = profile.mbti else { return }
            self?.output.profileMbti.value = mbti
            self?.validation(of: profile.mbti)
        }
        
        input.profileImageDidChange.lazyBind { [weak self] image in
            self?.output.profileImage.value = image
            self?.profile.image = image
        }
        
        input.profileNicknameDidChange.lazyBind { [weak self] nickname in
            self?.output.profileNickname.value = nickname
            self?.validation(of: nickname)
            self?.profile.nickname = nickname
        }
        
        input.profileMbtiDidChange.lazyBind { [weak self] indexPath in
            guard let mbti = self?.updateSelectedMbti(indexPath) else { return }
            
            self?.output.profileMbti.value = mbti
            self?.validation(of: mbti)
            self?.profile.mbti = mbti
        }
        
        input.profileImageTapped.lazyBind { [weak self] _ in
            self?.output.profileImageTapped.value = self?.profile.image
        }
        
        input.backButtonTapped.lazyBind { [weak self] _ in
            guard let isOnboarding = self?.input.isOnboarding.value else { return }
            
            if isOnboarding {
                self?.output.popVC.value = ()
            } else {
                self?.output.dismissVC.value = ()
            }
        }
        
        input.submitButtonTapped.lazyBind { [weak self] _ in
            guard var copyProfile = self?.profile else { return }
            
            copyProfile.created_at = DateFormatterManager.shared.getToday()
            UserStorage.shared.saveProfile(copyProfile)
            self?.output.submitButtonTapped.value = ()
        }
        
        input.saveButtonTapped.lazyBind { [weak self] _ in
            guard let profile = self?.profile else { return }
            
            UserStorage.shared.saveProfile(profile)
            self?.profileDelegate?.profileImageDidChange(self?.profile.image)
            self?.profileDelegate?.nicknameDidChange(self?.profile.nickname)
            self?.output.dismissVC.value = ()
        }
    }
    
    //MARK: - Method
    private func updateSelectedMbti(_ indexPath: IndexPath?) -> [String?] {
        guard let indexPath else {
            return self.output.profileMbti.value
        }
        
        var updatedProfileMbti = self.output.profileMbti.value
        let character = mbtiList[indexPath.item]
        let sectionIndex = indexPath.item / 2
        let isSelected = output.profileMbti.value.contains(character)
        
        if isSelected {
            updatedProfileMbti[sectionIndex] = nil
        } else {
            updatedProfileMbti[sectionIndex] = character
        }
        
        return updatedProfileMbti
    }
    
    private func validation(of nickname: String?) {
        output.nicknameValidation.value = ProfileNicknameValidation(nickname)
        saveValidation()
    }
    
    private func validation(of mbti: [String?]?) {
        output.mbtiValidation.value = ProfileMbtiValidation(mbti)
        saveValidation()
    }
    
    private func saveValidation() {
        output.submitValidation.value = output.nicknameValidation.value.validation && output.mbtiValidation.value.validation
    }
}
