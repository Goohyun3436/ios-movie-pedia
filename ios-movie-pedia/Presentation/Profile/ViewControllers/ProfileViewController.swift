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
    private var profile = Profile() {
        didSet {
            mainView.userProfileView.configureData(profile)
        }
    }
    private let menu = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let saved = loadJsonData(type: Profile.self, forKey: "profile") {
            profile = saved
        }
    }
    
}

//MARK: -
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as! ProfileTableViewCell
        
        cell.configureData(menu[indexPath.row])
        
        return cell
    }
    
}
