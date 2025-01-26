//
//  PosterCollectionViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import UIKit
import Kingfisher
import SnapKit

final class PosterCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - UI Property
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let likeButton = UIButton()
    private let overviewLabel = UILabel()
    
    //MARK: - Property
    static let id = "PosterCollectionViewCell"
    var delegate: LikeDelegate?
    private var movieId: Int = 0
    private var isLike: Bool = false {
        didSet {
            setLikeButton()
        }
    }
    
    //MARK: - Initializer Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Method
    func configureData(_ movie: Movie) {
        if let url = URL(string: TMDBImageRequest.w500(movie.poster_path).endpoint) {
            imageView.kf.setImage(with: url)
        }
        
        movieId = movie.id
        isLike = movie.is_like
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
    }
    
    @objc
    func likeButtonTapped() {
        delegate?.likesDidChange(movieId)
    }
    
    private func setLikeButton() {
        likeButton.setImage(UIImage(systemName: isLike ? "heart.fill" : "heart"), for: .normal)
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(overviewLabel)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView)
            make.height.equalTo(286)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.lessThanOrEqualTo(likeButton.snp.leading).offset(-16)
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(34)
            make.height.equalTo(30)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.lessThanOrEqualTo(contentView).offset(-0)
        }
        
    }
    
    override func configureView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        
        likeButton.contentHorizontalAlignment = .right
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        overviewLabel.numberOfLines = 2
        overviewLabel.font = UIFont.systemFont(ofSize: 12)
        overviewLabel.textColor = AppColor.darkgray
    }
    
}
