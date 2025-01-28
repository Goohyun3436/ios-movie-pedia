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
    let infoStackView = {
        let view = UIStackView()
        view.addArrangedSubview(MovieInfoView(.release_date, "2024-10-10"))
        view.addArrangedSubview(MovieInfoView(.vote_average, 4.5))
        view.addArrangedSubview(MovieInfoView(.genre_ids, [12, 14, 27, 28]))
        return view
    }()
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(backdropScrollView)
        addSubview(infoStackView)
    }
    
    override func configureLayout() {
        backdropScrollView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(400)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backdropScrollView.snp.bottom).offset(16)
        }
        infoStackView.axis = .horizontal
        infoStackView.spacing = 0.5
    }
    
    override func configureView() {
        backdropScrollView.backgroundColor = .red
        infoStackView.backgroundColor = AppColor.darkgray
    }
    
}
