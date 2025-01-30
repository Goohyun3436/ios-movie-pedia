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
    
    var image: String {
        switch self {
        case .genre_ids:
            return "film.fill"
        case .release_date:
            return "calendar"
        case .vote_average:
            return "star.fill"
        }
    }
    
    var placeholder: String {
        switch self {
        case .genre_ids:
            return "장르 로드중"
        case .release_date:
            return "개봉일 로드중"
        case .vote_average:
            return "평점 로드중"
        }
    }
}

final class MovieInfoView: BaseView {
    
    //MARK: - UI Property
    private let imageView = UIImageView()
    private let label = UILabel()
    
    //MARK: - Property
    private var info: MovieInfo?
    
    //MARK: - Initializer Method
    init(_ info: MovieInfo) {
        super.init(frame: .zero)
        self.info = info
        
        imageView.image = UIImage(systemName: info.image)
        label.text = info.placeholder
    }
    
    //MARK: - Method
    func configureData(_ value: Any?) {
        guard let value else {
            return
        }
        
        switch info {
        case .genre_ids:
            label.text = convertGenreIds(value as? [Int] ?? []).joined(separator: ", ")
        case .release_date:
            label.text = "\(value)"
        case .vote_average:
            label.text = "\(round(value as? Double ?? 0))"
        case .none:
            imageView.isHidden = true
            label.isHidden = true
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
