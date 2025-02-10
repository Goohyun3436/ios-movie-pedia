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
    private let originNameLabel = AppLabel(.title2)
    private let nameLabel = AppLabel(.text4, AppColor.darkgray)
    
    //MARK: - Property
    static let id = "PersonCollectionViewCell"
    
    //MARK: - Override Method
    func setData(_ person: Person) {
        if let profile = person.profile_path, let url = URL(string: TMDBImageRequest.w500(profile).endpoint) {
            imageView.kf.setImage(with: url)
            imageView.contentMode = .scaleAspectFill
        }
        else {
            imageView.image = nil
        }
        
        originNameLabel.text = person.original_name
        nameLabel.text = person.name
    }
    
    //MARK: - Override Method
    override func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(originNameLabel)
        contentView.addSubview(nameLabel)
    }
    
    override func setupConstraints() {
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
            make.top.equalTo(originNameLabel.snp.bottom).offset(4)
        }
    }
    
    override func setupAttributes() {
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.backgroundColor = AppColor.deepgray
        imageView.tintColor = AppColor.darkgray
    }
    
}
