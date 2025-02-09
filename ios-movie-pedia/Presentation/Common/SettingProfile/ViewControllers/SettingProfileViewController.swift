//
//  SettingProfileViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class SettingProfileViewController: UIViewController {
    
    //MARK: - UI Property
    private lazy var mainView = SettingProfileView()
    
    //MARK: - Property
    private let viewModel = SettingProfileViewModel()
    private let keyboardViewModel = KeyboardViewModel()
    
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
        mainView.mbtiSelectorView.collectionView.delegate = self
        mainView.mbtiSelectorView.collectionView.dataSource = self
        setupActions()
        setupBinds()
        viewModel.viewDidLoad.value = ()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        keyboardViewModel.viewDidAppear.value = ()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardViewModel.viewWillDisappear.value = ()
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
        
        viewModel.profileImage.lazyBind { [weak self] image in
            self?.mainView.configureData(image: image)
        }
        
        viewModel.profileNickname.lazyBind { [weak self] nickname in
            self?.mainView.configureData(nickname: nickname)
        }
        
        viewModel.profileMbti.lazyBind { [weak self] _ in
            self?.mainView.mbtiSelectorView.collectionView.reloadData()
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
        
        keyboardViewModel.showsKeyboard.lazyBind { [weak self] show in
            if show {
                self?.mainView.nicknameTextField.becomeFirstResponder()
            } else {
                self?.mainView.nicknameTextField.resignFirstResponder()
            }
        }
    }
    
    @objc private func mainViewTapped() {
        keyboardViewModel.inputMainViewTapped.value = ()
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
        viewModel.profileNicknameDidChange.value = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyboardViewModel.textFieldShouldReturn.value = ()
        return true
    }
    
}

//MARK: - UICollectionViewDelegate
extension SettingProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mbtiList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MbtiSelectorCollectionViewCell.id, for: indexPath) as! MbtiSelectorCollectionViewCell
        
        let character = viewModel.mbtiList[indexPath.item]
        let isSelected = viewModel.profileMbti.value.contains(character)
        cell.configureData(character, isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.profileMbtiDidChange.value = indexPath
    }
    
}

//MARK: - ProfileDelegate
extension SettingProfileViewController: ProfileDelegate {
    
    func profileImageDidChange(_ image: String?) {
        viewModel.profileImageDidChange.value = image
    }
    
    func nicknameDidChange(_ nickname: String?) {}
    
    func didClickedProfileView() {}
    
}
