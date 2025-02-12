//
//  ProfileViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    //MARK: UI Property
    private let mainView = ProfileView()
    
    //MARK: - Property
    private let viewModel = ProfileViewModel()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.userProfileView.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear.value = ()
    }
    
    override func setupBinds() {
        viewModel.profile.lazyBind { [weak self] profile in
            self?.mainView.userProfileView.setData(profile)
        }
        
        viewModel.likes.lazyBind { [weak self] likes in
            self?.mainView.userProfileView.setData(likes)
        }
        
        viewModel.resignTapped.lazyBind { [weak self] _ in
            self?.presentAlert("탈퇴하기", "탈퇴를 하면 데이터가 모두 초기화 됩니다. 탈퇴 하시겠습니까?") {
                self?.viewModel.confirmResign.value = ()
            }
        }
        
        viewModel.pushVC.lazyBind { [weak self] _ in
            let vc = SettingProfileViewController(delegate: self)
            vc.modalPresentationStyle = .pageSheet
            self?.presentVC(UINavigationController(rootViewController: vc))
        }
        
        viewModel.rootVC.lazyBind { [weak self] _ in
            self?.configureRootVC(UINavigationController(rootViewController: OnboardingViewController()))
        }
    }
    
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as! ProfileTableViewCell
        
        cell.setData(viewModel.menu[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt.value = indexPath
    }
    
}

//MARK: - ProfileDelegate
extension ProfileViewController: ProfileDelegate {
    
    func profileImageDidChange(_ image: String?) {
        viewModel.profileImageDidChange.value = image
    }
    
    func nicknameDidChange(_ nickname: String?) {
        viewModel.profileNicknameDidChange.value = nickname
    }
    
    func didClickedProfileView() {
        viewModel.profileViewTapped.value = ()
    }
    
}
