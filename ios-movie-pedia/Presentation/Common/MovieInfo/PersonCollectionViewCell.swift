//
//  PersonCollectionViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/29/25.
//

import UIKit
import Kingfisher
import SnapKit

final class PersonCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - UI Property
    private let imageView = UIImageView()
    private let originNameLabel = UILabel()
    private let nameLabel = UILabel()
    
    //MARK: - Property
    static let id = "PersonCollectionViewCell"
    
    //MARK: - Override Method
    func configureData(_ person: Person) {
        if let profile = person.profile_path, let url = URL(string: TMDBImageRequest.w500(profile).endpoint) {
            imageView.kf.setImage(with: url)
        }
        
        originNameLabel.text = person.original_name
        nameLabel.text = person.name
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(originNameLabel)
        contentView.addSubview(nameLabel)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-0)
            make.size.equalTo(50)
        }
        
        originNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(8)
            make.trailing.lessThanOrEqualToSuperview().offset(-0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.trailing.bottom.lessThanOrEqualToSuperview().offset(-0)
            make.top.equalTo(originNameLabel.snp.bottom).offset(2)
        }
    }
    
    override func configureView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFill
        originNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = AppColor.lightgray
    }
    
}
