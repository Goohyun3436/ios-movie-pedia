//
//  CinemaDetailView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/28/25.
//

import UIKit
import SnapKit

final class CinemaDetailView: BaseView {
    
    //MARK: - UI Property
    let backdropScrollView = ImageScrollView()
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(backdropScrollView)
    }
    
    override func configureLayout() {
        backdropScrollView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(400)
        }
    }
    
    override func configureView() {
        backdropScrollView.backgroundColor = .red
    }
    
}
