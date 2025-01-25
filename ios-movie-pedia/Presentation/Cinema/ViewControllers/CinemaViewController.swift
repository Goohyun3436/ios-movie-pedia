//
//  CinemaViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class CinemaViewController: UIViewController {
    
    //MARK: - UI Property
    private let mainView = CinemaView()
    
    //MARK: - Property
    private var profile = Profile() {
        didSet {
            mainView.userProfileView.configureData(profile)
        }
    }
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.userProfileView.rightButton.addTarget(
            self,
            action: #selector(userRightButtonTapped),
            for: .touchUpInside
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        super.viewWillAppear(animated)
        
        if let saved = loadJsonData(type: Profile.self, forKey: "profile") {
            profile = saved
        }
    }
    
    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        super.beginAppearanceTransition(isAppearing, animated: animated)
        print(#function)
    }
    
    //MARK: - Method
    @objc
    private func userRightButtonTapped() {
        let vc = SettingProfileViewController()
        vc.presentDelegate = self
        vc.modalPresentationStyle = .pageSheet
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}

//MARK: - ProfileDelegate
extension CinemaViewController: ProfileDelegate {
    
    func profileImageDidChange(_ image: String?) {
        profile.image = image
    }
    
    func nicknameDidChange(_ nickname: String?) {
        profile.nickname = nickname
    }
    
}
