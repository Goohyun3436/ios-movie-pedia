//
//  CinemaView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/25/25.
//

import UIKit
import SnapKit

final class CinemaView: BaseView {
    
    //MARK: - UI Property
    let userProfileView = UserProfileView()
    let tableView = UITableView()
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(userProfileView)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        userProfileView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(userProfileView.snp.bottom).offset(8)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.isScrollEnabled = false
    }
}
