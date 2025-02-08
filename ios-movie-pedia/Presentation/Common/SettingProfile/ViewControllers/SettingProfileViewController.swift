//
//  SettingProfileViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class SettingProfileViewController: UIViewController {
    
    //MARK: - UI Property
    private lazy var mainView = SettingProfileView(delegate: self)
    
    //MARK: - Property
    private let viewModel = SettingProfileViewModel()
    
    //MARK: - Initializer Method
    init(isOnboarding: Bool = false, delegate: ProfileDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        viewModel.isOnboarding.value = isOnboarding
        viewModel.profileDelegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.nicknameTextField.delegate = self
        setupActions()
        setupBinds()
        viewModel.viewDidLoad.value = ()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear.value = ()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear.value = ()
    }
    
    //MARK: - Setup Method
    private func setupActions() {
        navigationItem.leftBarButtonItem = makeBarButtonItemWithImage(
            viewModel.isOnboarding.value ? "chevron.backward" : "xmark",
            handler: #selector(backButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = makeBarButtonItemWithTitle(
            "저장",
            handler: #selector(saveButtonTapped)
        )
        
        let singleTap = UITapGestureRecognizer(
            target: self,
            action: #selector(mainViewTapped)
        )
        singleTap.cancelsTouchesInView = false
        mainView.isUserInteractionEnabled = true
        mainView.addGestureRecognizer(singleTap)
        
        mainView.profileImageView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(profileImageViewTapped)
        ))
        
        mainView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    private func setupBinds() {
        viewModel.showsRightBarButtonItem.bind { [weak self] show in
            self?.navigationItem.rightBarButtonItem?.isHidden = show
        }
        
        viewModel.showsSubmitButton.bind { [weak self] show in
            self?.mainView.submitButton.isHidden = show
        }
        
        viewModel.navTitle.bind { [weak self] title in
            self?.navigationItem.title = title
            self?.navigationItem.backButtonTitle = ""
        }
        
        viewModel.profile.lazyBind { [weak self] profile in
            print("profile")
            dump(profile)
            self?.mainView.configureData(profile)
        }
        
        viewModel.nicknameValidation.lazyBind { [weak self] validation in
            self?.mainView.configureStatus(nicknameValidation: validation)
        }
        
        viewModel.mbtiValidation.lazyBind { [weak self] validation in
            self?.mainView.configureStatus(mbtiValidation: validation)
        }
        
        viewModel.submitValidation.lazyBind { [weak self] validation in
            self?.mainView.submitButton.setAbled(validation)
            self?.navigationItem.rightBarButtonItem?.isEnabled = validation
        }
        
        viewModel.outputProfileImageTapped.lazyBind { [weak self] image in
            let vc = SettingProfileImageViewController()
            vc.delegate = self
            vc.profileImage = image
            self?.pushVC(vc)
        }
        
        viewModel.popVC.lazyBind { [weak self] _ in
            UserDefaultManager.shared.removeObject(forKey: .profile)
            self?.popVC()
        }
        
        viewModel.dismissVC.lazyBind { [weak self] _ in
            self?.dismissVC()
        }
        
        viewModel.outputSubmitButtonTapped.lazyBind { [weak self] _ in
            self?.configureRootVC(TabBarController())
        }
        
        viewModel.showsKeyboard.lazyBind { [weak self] show in
            if show {
                self?.mainView.nicknameTextField.becomeFirstResponder()
            } else {
                self?.mainView.nicknameTextField.resignFirstResponder()
            }
        }
    }
    
    @objc private func mainViewTapped() {
        viewModel.inputMainViewTapped.value = ()
    }
    
    @objc private func backButtonTapped() {
        viewModel.inputBackButtonTapped.value = ()
    }
    
    @objc private func profileImageViewTapped() {
        viewModel.inputProfileImageTapped.value = ()
    }
    
    @objc private func submitButtonTapped() {
        viewModel.inputSubmitButtonTapped.value = ()
    }
    
    @objc private func saveButtonTapped() {
        viewModel.inputSaveButtonTapped.value = ()
    }
    
}

//MARK: - UITextFieldDelegate
extension SettingProfileViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.profileNickname.value = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.inputTextFieldShouldReturn.value = ()
        return true
    }
    
}

//MARK: - ProfileDelegate
extension SettingProfileViewController: ProfileDelegate {
    
    func profileImageDidChange(_ image: String?) {
        viewModel.profileImage.value = image
    }
    
    func nicknameDidChange(_ nickname: String?) {
        viewModel.profileNickname.value = nickname
    }
    
    func didClickedProfileView() {}
    
}

//MARK: - MbtiDelegate
extension SettingProfileViewController: MbtiDelegate {
    
    func didChange(_ mbti: [String?]) {
        viewModel.profileMbti.value = mbti
    }
    
}
