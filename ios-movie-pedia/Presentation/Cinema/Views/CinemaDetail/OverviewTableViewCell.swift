//
//  OverviewTableViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/29/25.
//

import UIKit
import SnapKit

final class OverviewTableViewCell: BaseTableViewCell {
    
    //MARK: - UI Property
    private let titleLabel = UILabel()
    private let moreButton = UIButton()
    private let overviewLabel = UILabel()
    
    //MARK: - Property
    static let id = "OverviewTableViewCell"
    
    //MARK: - Method
    func configureData(_ title: String, _ overview: String) {
        titleLabel.text = title
        overviewLabel.text = overview
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(moreButton)
        contentView.addSubview(overviewLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(16)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(16)
            make.top.equalTo(contentView).offset(16)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        moreButton.setTitle("More", for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        overviewLabel.numberOfLines = 3
        overviewLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
}
