//
//  SearchView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/27/25.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    //MARK: - UI Property
    let searchBar = UISearchBar()
    let tableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        return view
    }()
    let noneContentLabel = UILabel()
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(noneContentLabel)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        noneContentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(searchBar).offset(200)
        }
    }
    
    override func configureView() {
        searchBar.setValue("취소", forKey: "cancelButtonText")
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "영화를 검색해보세요", attributes: [.foregroundColor : AppColor.darkgray!])
        searchBar.setImage(UIImage(systemName: "xmark.circle.fill"), for: .clear, state: .normal)
        searchBar.tintColor = AppColor.white
        searchBar.searchTextField.leftView?.tintColor = AppColor.lightgray
        
        tableView.keyboardDismissMode = .onDrag
        
        noneContentLabel.text = "원하는 검색결과를 찾지 못했습니다"
        noneContentLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        noneContentLabel.textColor = AppColor.darkgray
    }
    
}
