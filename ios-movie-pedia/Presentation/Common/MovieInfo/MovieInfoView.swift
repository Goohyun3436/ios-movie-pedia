//
//  MovieInfoStackView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/28/25.
//

import UIKit
import SnapKit

enum MovieInfo {
    case genre_ids
    case release_date
    case vote_average
}

final class MovieInfoView: BaseView {
    
    //MARK: - UI Property
    let imageView = UIImageView()
    let label = UILabel()
    
    //MARK: - Initializer Method
    init(_ info: MovieInfo, _ value: Any) {
        super.init(frame: .zero)
        
        switch info {
        case .genre_ids:
            imageView.image = UIImage(systemName: "film.fill")
            label.text = convertGenreIds(value as! [Int]).joined(separator: ", ")
        case .release_date:
            imageView.image = UIImage(systemName: "calendar")
            label.text = "\(value)"
        case .vote_average:
            imageView.image = UIImage(systemName: "star.fill")
            label.text = "\(value)"
        }
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(label)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.verticalEdges.equalToSuperview()
            make.size.equalTo(18)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        imageView.backgroundColor = AppColor.black
        imageView.tintColor = AppColor.lightgray
        
        label.backgroundColor = AppColor.black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = AppColor.lightgray
    }
    
}
