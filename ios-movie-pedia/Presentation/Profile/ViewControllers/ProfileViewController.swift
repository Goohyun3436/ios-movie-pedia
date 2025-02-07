//
//  ProfileViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: UI Property
    private let mainView = ProfileView()
    
    //MARK: - Property
    private var profile: Profile? {
        didSet {
            mainView.userProfileView.configureData(profile, User.likes)
        }
    }
    private let menu = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
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
        profile = getUserProfile()
    }
    
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as! ProfileTableViewCell
        
        cell.configureData(menu[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            presentAlert("탈퇴하기", "탈퇴를 하면 데이터가 모두 초기화 됩니다. 탈퇴 하시겠습니까?") {
                UserDefaults.standard.removeObject(forKey: "profile")
                User.likes = []
                User.searches = []
                
                self.configureRootVC(UINavigationController(rootViewController: OnboardingViewController()))
            }
        }
    }
    
}

//MARK: - ProfileDelegate
extension ProfileViewController: ProfileDelegate {
    
    func profileImageDidChange(_ image: String?) {
        profile?.image = image
    }
    
    func nicknameDidChange(_ nickname: String?) {
        profile?.nickname = nickname
    }
    
    func didClickedProfileView() {
        let vc = SettingProfileViewController(delegate: self)
        vc.modalPresentationStyle = .pageSheet
        presentVC(UINavigationController(rootViewController: vc))
    }
    
}
