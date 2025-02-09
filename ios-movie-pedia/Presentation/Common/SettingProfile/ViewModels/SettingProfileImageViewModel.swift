//
//  SettingProfileImageViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/9/25.
//

import Foundation

final class SettingProfileImageViewModel {
    
    //MARK: - Input
    let profileImageDidChange: Observable<String?> = Observable(nil)
    let profileImageDidSelect: Observable<IndexPath?> = Observable(nil)
    
    //MARK: - Output
    let navTitle = Observable("프로필 이미지 설정")
    let collectionViewReloadItems: Observable<[IndexPath]?> = Observable(nil)
    let profileImage: Observable<String?> = Observable(nil)
    
    //MARK: - Property
    var delegate: ProfileDelegate?
    let profilesImages: [String] = [Int](0...11).map { "profile_\($0)" }
    
    //MARK: - Bind
    init() {
        profileImageDidChange.lazyBind { [weak self] image in
            self?.profileImage.value = image
        }
        
        profileImageDidSelect.lazyBind { [weak self] indexPath in
            self?.updateProfileImage(indexPath)
            self?.delegate?.profileImageDidChange(self?.profileImage.value)
        }
    }
    
    //MARK: - Method
    private func updateProfileImage(_ indexPath: IndexPath?) {
        guard let indexPath else {
            return
        }
        
        guard let profileImage = profileImage.value else {
            return
        }
        
        guard let beforeItem = profilesImages.firstIndex(of: profileImage) else {
            return
        }
        
        self.profileImage.value = profilesImages[indexPath.item]
        collectionViewReloadItems.value = [indexPath, IndexPath(item: beforeItem, section: 0)]
    }
    
}
