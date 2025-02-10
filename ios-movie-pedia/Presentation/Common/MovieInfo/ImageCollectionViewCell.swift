//
//  ImageCollectionViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/29/25.
//

import UIKit
import Kingfisher
import SnapKit

final class ImageCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - UI Property
    private let imageView = UIImageView()
    
    //MARK: - Property
    static let id = "ImageCollectionViewCell"
    
    //MARK: - Method
    func setData(_ image: String?) {
        if let image, let url = URL(string: TMDBImageRequest.w500(image).endpoint) {
            imageView.kf.setImage(with: url)
        }
    }
    
    //MARK: - Override Method
    override func setupUI() {
        contentView.addSubview(imageView)
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func setupAttributes() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
}
