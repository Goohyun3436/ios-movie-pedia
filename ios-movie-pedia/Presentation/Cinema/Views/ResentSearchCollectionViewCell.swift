//
//  ResentSearchCollectionViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import UIKit
import SnapKit

final class ResentSearchCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - UI Property
    private let titleLabel = UILabel()
    private let removeButton = UIButton()
    
    //MARK: - Property
    static let id = "ResentSearchCollectionViewCell"
    
    //MARK: - Method
    func configureData(_ title: String) {
        titleLabel.text = title
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(removeButton)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(12)
            make.centerY.equalTo(contentView)
        }
        
        removeButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(3)
            make.trailing.equalTo(contentView).inset(6)
            make.centerY.equalTo(contentView)
            make.size.equalTo(16)
        }
    }
    
    override func configureView() {
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = AppColor.lightgray
        
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        titleLabel.textColor = AppColor.black
        
        removeButton.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 12, weight: .semibold))), for: .normal)
        removeButton.tintColor = AppColor.black
    }
    
}
