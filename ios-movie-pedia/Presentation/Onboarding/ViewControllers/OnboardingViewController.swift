//
//  OnboardingViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    //MARK: - UI Property
    private let mainView = OnboardingView()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.imageView.heightToFit()
    }
    
    //MARK: - Method
    @objc
    private func startButtonTapped() {
        pushVC(SettingProfileViewController(isOnboarding: true))
    }
}
