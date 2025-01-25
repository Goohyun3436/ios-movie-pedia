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
    
    override func configureHierarchy() {
        addSubview(userProfileView)
    }
    
    override func configureLayout() {
        userProfileView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}
