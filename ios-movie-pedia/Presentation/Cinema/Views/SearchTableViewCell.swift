//
//  SearchTableViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/27/25.
//

import UIKit
import Kingfisher
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    
    //MARK: - UI Property
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let genreWrapView = UIStackView()
    private let genreIdLabels = [
        UILabel(),
        UILabel()
    ]
    private let likeButton = LikeButton()
    
    //MARK: - Property
    static let id = "SearchTableViewCell"
    private var isLike: Bool = false {
        didSet {
            likeButton.setLikeButton(isLike)
        }
    }
    
    //MARK: - Method
    func configureData(movie: Movie) {
        print(movie)
        isLike = false
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(genreWrapView)
        
        for item in genreIdLabels {
            genreWrapView.addArrangedSubview(item)
        }
        
        addSubview(likeButton)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.verticalEdges.equalToSuperview().inset(8)
            make.width.equalTo(100)
            make.height.equalTo(130)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.top.equalToSuperview().offset(12)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        genreWrapView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
        genreWrapView.axis = .horizontal
        genreWrapView.spacing = 3
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
            make.width.equalTo(34)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        releaseDateLabel.font = UIFont.systemFont(ofSize: 13)
        releaseDateLabel.textColor = AppColor.darkgray
        
        for item in genreIdLabels {
            item.text = " 액션 "
            item.clipsToBounds = true
            item.layer.cornerRadius = 4
            item.backgroundColor = AppColor.darkgray
            item.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        }
    }
    
}
