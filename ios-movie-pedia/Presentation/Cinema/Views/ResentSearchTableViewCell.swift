//
//  ResentSearchTableViewCell.swift.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import UIKit
import SnapKit

final class ResentSearchTableViewCell: BaseTableViewCell {
    
    //MARK: - Property
    static let id = "CinemaTableViewCell"
    
    //MARK: - UI Property
    private let titleLabel = UILabel()
    private let removeButton = UIButton()
    let collectionView = ResentSearchCollectionView()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(removeButton)
        contentView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(16)
        }
        
        removeButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(16)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(46)
            make.bottom.equalTo(contentView).inset(16)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
        removeButton.setTitle("전체 삭제", for: .normal)
        removeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        titleLabel.text = "최근검색어"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
}
