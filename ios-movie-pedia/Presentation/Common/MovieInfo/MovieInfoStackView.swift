//
//  MovieInfoStackView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/30/25.
//

import UIKit
import SnapKit

struct MovieInfoValue {
    let movieInfo: MovieInfo
    let value: Any?
}

final class MovieInfoStackView: BaseView {
    
    //MARK: - UI Property
    private let stackView = UIStackView()
    private let infoViews = [
        MovieInfoView(.release_date),
        MovieInfoView(.vote_average),
        MovieInfoView(.genre_ids)
    ]
    
    //MARK: - Method
    func configureData(_ movieInfos: [MovieInfoValue]) {
        for item in movieInfos {
            switch item.movieInfo {
            case .release_date:
                infoViews[0].configureData(item.value)
            case .vote_average:
                infoViews[1].configureData(item.value)
            case .genre_ids:
                infoViews[2].configureData(item.value)
            }
        }
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(stackView)
        
        for item in infoViews {
            stackView.addArrangedSubview(item)
        }
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.axis = .horizontal
        stackView.spacing = 0.5
    }
    
    override func configureView() {
        stackView.backgroundColor = AppColor.darkgray
    }
    
}
