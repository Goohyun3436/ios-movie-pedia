//
//  SettingProfileImageViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/9/25.
//

import Foundation

final class SettingProfileImageViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    //MARK: - Input
    struct Input {
        var delegate: ProfileDelegate?
        let profileImageDidChange: Observable<String?> = Observable(nil)
        let profileImageDidSelect: Observable<IndexPath?> = Observable(nil)
    }
    
    //MARK: - Output
    struct Output {
        let navTitle = Observable("프로필 이미지 설정")
        let collectionViewReloadItems: Observable<[IndexPath]?> = Observable(nil)
        let profileImage: Observable<String?> = Observable(nil)
        let profilesImages: [String] = [Int](0...11).map { "profile_\($0)" }
    }
    
    //MARK: - Property
    var delegate: ProfileDelegate?
    
    //MARK: - Bind
    init() {
        input = Input()
        output = Output()
        
        input.profileImageDidChange.lazyBind { [weak self] image in
            self?.output.profileImage.value = image
        }
        
        input.profileImageDidSelect.lazyBind { [weak self] indexPath in
            self?.updateProfileImage(indexPath)
            self?.delegate?.profileImageDidChange(self?.output.profileImage.value)
        }
    }
    
    //MARK: - Method
    private func updateProfileImage(_ indexPath: IndexPath?) {
        guard let indexPath else {
            return
        }
        
        guard let profileImage = output.profileImage.value else {
            return
        }
        
        guard let beforeItem = output.profilesImages.firstIndex(of: profileImage) else {
            return
        }
        
        output.profileImage.value = output.profilesImages[indexPath.item]
        output.collectionViewReloadItems.value = [indexPath, IndexPath(item: beforeItem, section: 0)]
    }
    
}
