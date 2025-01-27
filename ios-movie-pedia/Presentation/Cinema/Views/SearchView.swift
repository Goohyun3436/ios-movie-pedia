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
    
    override func configureHierarchy() {
        addSubview(searchBar)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        searchBar.setValue("취소", forKey: "cancelButtonText")
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "영화를 검색해보세요", attributes: [.foregroundColor : AppColor.darkgray!])
        searchBar.setImage(UIImage(systemName: "xmark.circle.fill"), for: .clear, state: .normal)
        searchBar.tintColor = AppColor.white
        searchBar.searchTextField.leftView?.tintColor = AppColor.lightgray
    }
    
}
