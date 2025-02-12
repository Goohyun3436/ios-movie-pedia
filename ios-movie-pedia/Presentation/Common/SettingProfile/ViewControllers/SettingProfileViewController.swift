//
//  SettingProfileViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class SettingProfileViewController: BaseViewController {
    
    //MARK: - UI Property
    private lazy var mainView = SettingProfileView()
    
    //MARK: - Property
    private let viewModel = SettingProfileViewModel()
    private let keyboardViewModel = KeyboardViewModel()
    
    //MARK: - Initializer Method
    init(isOnboarding: Bool = false, delegate: ProfileDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        viewModel.input.isOnboarding.value = isOnboarding
        viewModel.profileDelegate = delegate
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
        viewModel.input.viewDidLoad.value = ()
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
    override func setupActions() {
        navigationItem.leftBarButtonItem = makeBarButtonItemWithImage(
            "",
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
    
    override func setupBinds() {
        viewModel.output.showsRightBarButtonItem.bind { [weak self] show in
            self?.navigationItem.rightBarButtonItem?.isHidden = show
        }
        
        viewModel.output.showsSubmitButton.bind { [weak self] show in
            self?.mainView.submitButton.isHidden = show
        }
        
        viewModel.output.navigationTitle.bind { [weak self] title in
            self?.navigationItem.title = title
        }
        
        viewModel.output.backButtonTitle.bind { [weak self] title in
            self?.navigationItem.backButtonTitle = title
        }
        
        viewModel.output.leftBarButtonImage.lazyBind { [weak self] image in
            self?.navigationItem.leftBarButtonItem?.image = UIImage(systemName: image)
        }
        
        viewModel.output.profileImage.lazyBind { [weak self] image in
            self?.mainView.setData(image: image)
        }
        
        viewModel.output.profileNickname.lazyBind { [weak self] nickname in
            self?.mainView.setData(nickname: nickname)
        }
        
        viewModel.output.profileMbti.lazyBind { [weak self] _ in
            self?.mainView.mbtiSelectorView.collectionView.reloadData()
        }
        
        viewModel.output.nicknameValidation.lazyBind { [weak self] validation in
            self?.mainView.setStatus(nicknameValidation: validation)
        }
        
        viewModel.output.mbtiValidation.lazyBind { [weak self] validation in
            self?.mainView.setStatus(mbtiValidation: validation)
        }
        
        viewModel.output.submitValidation.lazyBind { [weak self] validation in
            self?.mainView.submitButton.setAbled(validation)
            self?.navigationItem.rightBarButtonItem?.isEnabled = validation
        }
        
        //refactor point: init 시점에 이미지 넘겨주기
        viewModel.output.profileImageTapped.lazyBind { [weak self] image in
            let vc = SettingProfileImageViewController(delegate: self)
            vc.viewModel.input.profileImageDidChange.value = image
            self?.pushVC(vc)
        }
        
        viewModel.output.popVC.lazyBind { [weak self] _ in
            self?.popVC()
        }
        
        viewModel.output.dismissVC.lazyBind { [weak self] _ in
            self?.dismissVC()
        }
        
        viewModel.output.submitButtonTapped.lazyBind { [weak self] _ in
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
        viewModel.input.backButtonTapped.value = ()
    }
    
    @objc private func profileImageViewTapped() {
        viewModel.input.profileImageTapped.value = ()
    }
    
    @objc private func submitButtonTapped() {
        viewModel.input.submitButtonTapped.value = ()
    }
    
    @objc private func saveButtonTapped() {
        viewModel.input.saveButtonTapped.value = ()
    }
    
}

//MARK: - UITextFieldDelegate
extension SettingProfileViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.input.profileNicknameDidChange.value = textField.text
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
        let isSelected = viewModel.output.profileMbti.value.contains(character)
        cell.setData(character, isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input.profileMbtiDidChange.value = indexPath
    }
    
}

//MARK: - ProfileDelegate
extension SettingProfileViewController: ProfileDelegate {
    
    func profileImageDidChange(_ image: String?) {
        viewModel.input.profileImageDidChange.value = image
    }
    
    func nicknameDidChange(_ nickname: String?) {}
    
    func didClickedProfileView() {}
    
}
