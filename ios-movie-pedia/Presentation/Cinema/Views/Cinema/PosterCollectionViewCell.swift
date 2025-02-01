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
    private let titleLabel = AppLabel(.title1)
    lazy private var likeButton = {
        let button = LikeButton()
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    private let overviewLabel = AppLabel(.text4, AppColor.darkgray)
    
    //MARK: - Property
    static let id = "PosterCollectionViewCell"
    var delegate: LikeDelegate?
    private var movieId: Int?
    private var isLike: Bool = false {
        didSet {
            likeButton.setLikeButton(isLike)
        }
    }
    
    //MARK: - Method
    func configureData(_ movie: Movie) {
        if let poster = movie.poster_path, let url = URL(string: TMDBImageRequest.w500(poster).endpoint) {
            imageView.kf.setImage(with: url)
        }
        
        movieId = movie.id
        isLike = movie.is_like
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
    }
    
    @objc
    private func likeButtonTapped() {
        guard let movieId else {
            return
        }
        
        delegate?.likesDidChange(movieId, onlyCellReload: false)
    }
    
    //MARK: - Override Method
    override func prepareForReuse() {
        imageView.image = nil
        movieId = nil
        isLike = false
        titleLabel.text = ""
        overviewLabel.text = ""
    }
    
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
        overviewLabel.numberOfLines = 2
    }
    
}
