//
//  ProfileView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/29/25.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {
    
    //MARK: UI Property
    let userProfileView = UserProfileView()
    let tableView = {
        let view = UITableView()
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        return view
    }()
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(userProfileView)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        userProfileView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(userProfileView.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
        tableView.separatorInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
    }
}
