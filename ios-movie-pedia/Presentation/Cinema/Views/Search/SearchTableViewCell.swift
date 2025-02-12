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
    private let titleLabel = AppLabel(.title1)
    private let releaseDateLabel = AppLabel(.text4, AppColor.darkgray)
    private let genreWrapView = UIStackView()
    private let genreIdLabels = [
        AppLabel(.text1, AppColor.lightgray),
        AppLabel(.text1, AppColor.lightgray)
    ]
    lazy private var likeButton = {
        let button = LikeButton()
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Property
    static let id = "SearchTableViewCell"
    weak var delegate: LikeDelegate?
    private var movieId: Int?
    private var isLike: Bool = false {
        didSet {
            likeButton.setLikeButton(isLike)
        }
    }
    
    //MARK: - Method
    func configureData(movie: Movie) {
        if let poster = movie.poster_path, let url = URL(string: TMDBImageRequest.w500(poster).endpoint) {
            posterImageView.kf.setImage(with: url)
        }
        
        movieId = movie.id
        isLike = movie.is_like
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        
        let genres = convertGenreIds(movie.genre_ids)
        
        for i in genres.indices {
            genreIdLabels[i].text = " \(genres[i]) "
        }
        
        likeButton.isEnabled = movie.release_date != nil
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
        posterImageView.image = nil
        movieId = nil
        isLike = false
        titleLabel.text = ""
        releaseDateLabel.text = ""
        for item in genreIdLabels {
            item.text = ""
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(genreWrapView)
        
        for item in genreIdLabels {
            genreWrapView.addArrangedSubview(item)
        }
        
        contentView.addSubview(likeButton)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.verticalEdges.equalToSuperview().inset(12)
            make.width.equalTo(100)
            make.height.equalTo(130).priority(.high)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        genreWrapView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(24)
        }
        genreWrapView.axis = .horizontal
        genreWrapView.spacing = 3
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(4)
            make.width.equalTo(34)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        
        titleLabel.numberOfLines = 2
        
        for item in genreIdLabels {
            item.clipsToBounds = true
            item.layer.cornerRadius = 4
            item.backgroundColor = AppColor.deepgray
        }
    }
    
}
