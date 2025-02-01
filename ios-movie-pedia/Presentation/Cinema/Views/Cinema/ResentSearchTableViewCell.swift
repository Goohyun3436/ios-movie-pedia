//
//  ResentSearchTableViewCell.swift.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import UIKit
import SnapKit

final class ResentSearchTableViewCell: BaseTableViewCell {
    
    //MARK: - UI Property
    let titleLabel = AppLabel(.title1)
    let removeButton = UIButton()
    let collectionView = ResentSearchCollectionView()
    let noneContentLabel = AppLabel(.text3)
    
    //MARK: - Property
    static let id = "CinemaTableViewCell"
    var delegate: SearchDelegate?
    
    //MARK: - Initializer Method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Method
    @objc
    private func removeButtonTapped() {
        delegate?.searchesRemoveAll()
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(removeButton)
        contentView.addSubview(collectionView)
        contentView.addSubview(noneContentLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(20)
        }
        
        removeButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(16)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView)
        }
        
        noneContentLabel.snp.makeConstraints { make in
            make.center.equalTo(collectionView)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
        removeButton.setTitle("전체 삭제", for: .normal)
        removeButton.titleLabel?.font = AppFont.title2.font
        noneContentLabel.text = "최근 검색어 내역이 없습니다."
        noneContentLabel.textColor = AppColor.darkgray
    }
}
