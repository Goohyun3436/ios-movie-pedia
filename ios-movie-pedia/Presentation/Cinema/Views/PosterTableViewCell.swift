//
//  PosterTableViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import UIKit
import SnapKit

final class PosterTableViewCell: BaseTableViewCell {
    
    //MARK: - UI Property
    let titleLabel = UILabel()
    let collectionView = PosterCollectionView()
    
    //MARK: - Property
    static let id = "PosterTableViewCell"
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(376)
            make.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
}
