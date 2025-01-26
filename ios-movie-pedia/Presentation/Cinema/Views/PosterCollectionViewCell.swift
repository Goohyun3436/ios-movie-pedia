//
//  PosterCollectionViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import UIKit
import SnapKit

final class PosterCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - UI Property
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let likeButton = UIButton()
    private let descriptionLabel = UILabel()
    
    //MARK: - Property
    static let id = "PosterCollectionViewCell"
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(descriptionLabel)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView)
            make.height.equalTo(270)
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
            make.height.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.lessThanOrEqualTo(contentView).offset(-0)
        }
        
    }
    
    override func configureView() {
        contentView.backgroundColor = .red
        imageView.backgroundColor = .orange
        titleLabel.backgroundColor = .yellow
        likeButton.backgroundColor = .green
        descriptionLabel.backgroundColor = .blue
        titleLabel.text = "titleLabel"
        descriptionLabel.text = "descriptionLabeldescriptionLabeldescriptionLabeldescriptionLabeldescriptionLabeldescriptionLabeldescriptionLabeldescriptionLabeldescriptionLabel"
        
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeButton.contentHorizontalAlignment = .right
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
}
