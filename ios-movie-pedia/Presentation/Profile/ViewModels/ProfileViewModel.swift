//
//  ProfileViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/9/25.
//

import Foundation

final class ProfileViewModel {
    
    //MARK: - Input
    let viewWillAppear: Observable<Void?> = Observable(nil)
    let profileViewTapped: Observable<Void?> = Observable(nil)
    let profileImageDidChange: Observable<String?> = Observable(nil)
    let profileNicknameDidChange: Observable<String?> = Observable(nil)
    let didSelectRowAt: Observable<IndexPath?> = Observable(nil)
    let confirmResign: Observable<Void?> = Observable(nil)
    
    //MARK: - Output
    let profile: Observable<Profile?> = Observable(nil)
    let likes: Observable<[Int]> = Observable([])
    
    let questionTapped: Observable<Void?> = Observable(nil)
    let inquiryTapped: Observable<Void?> = Observable(nil)
    let notificationTapped: Observable<Void?> = Observable(nil)
    let resignTapped: Observable<Void?> = Observable(nil)
    
    let pushVC: Observable<Void?> = Observable(nil)
    let rootVC: Observable<Void?> = Observable(nil)
    
    //MARK: - Property
    let menu = ProfileMenu.allCases
    
    //MARK: - Bind
    init() {
        viewWillAppear.lazyBind { [weak self] _ in
            self?.profile.value = UserStaticStorage.profile
            self?.likes.value = UserStaticStorage.likes
        }
        
        profileViewTapped.lazyBind { [weak self] _ in
            self?.pushVC.value = ()
        }
        
        profileImageDidChange.lazyBind { [weak self] image in
            self?.profile.value?.image = image
        }
        
        profileNicknameDidChange.lazyBind { [weak self] nickname in
            self?.profile.value?.nickname = nickname
        }
        
        didSelectRowAt.lazyBind { [weak self] indexPath in
            self?.routeMenu(indexPath)
        }
        
        confirmResign.lazyBind { [weak self] _ in
            self?.resign()
            self?.rootVC.value = ()
        }
    }
    
    //MARK: - Method
    private func routeMenu(_ indexPath: IndexPath?) {
        guard let indexPath else { return }
        
        switch menu[indexPath.row] {
        case .question:
            questionTapped.value = ()
        case .inquiry:
            inquiryTapped.value = ()
        case .notification:
            notificationTapped.value = ()
        case .resign:
            resignTapped.value = ()
        }
    }
    
    private func resign() {
        UserStorage.shared.resign()
    }
    
}
