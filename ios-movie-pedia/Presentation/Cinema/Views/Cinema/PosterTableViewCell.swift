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
    let titleLabel = AppLabel(.title1)
    let collectionView = PosterCollectionView(CGSize(width: 200, height: 356), 16, 16)
    
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
    }
}
