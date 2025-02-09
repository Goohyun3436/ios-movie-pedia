//
//  OnboardingViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    
    //MARK: - UI Property
    private let mainView = OnboardingView()
    
    //MARK: - UI Property
    private let viewModel = OnboardingViewModel()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
        viewModel.loadView.value = ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.imageView.heightToFit()
    }
    
    //MARK: - Method
    override func setupActions() {
        mainView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    override func setupBinds() {
        viewModel.onboardingModel.lazyBind { [weak self] onboardingModel in
            self?.mainView.setData(onboardingModel)
        }
        
        viewModel.pushVC.lazyBind { [weak self] _ in
            self?.pushVC(SettingProfileViewController(isOnboarding: true))
        }
    }
    
    @objc
    private func startButtonTapped() {
        viewModel.startButtonTapped.value = ()
    }
    
}
