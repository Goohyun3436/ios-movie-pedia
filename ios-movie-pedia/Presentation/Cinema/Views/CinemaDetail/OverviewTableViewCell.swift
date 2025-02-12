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
    private let titleLabel = AppLabel(.title1)
    private lazy var moreButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        return button
    }()
    private let overviewLabel = AppLabel(.text4, AppColor.darkgray)
    
    //MARK: - Property
    static let id = "OverviewTableViewCell"
    weak var delegate: MoreDelegate?
    
    //MARK: - Method
    func setData(
        _ title: String,
        _ overview: String?,
        _ moreButtonTitle: String,
        _ numberOfLines: Int
    ) {
        titleLabel.text = title
        
        guard let overview, !overview.isEmpty else {
            moreButton.isHidden = true
            overviewLabel.text = ContentMessage.overview.none
            return
        }
        
        moreButton.isHidden = false
        moreButton.setTitle(moreButtonTitle, for: .normal)
        overviewLabel.text = overview
        overviewLabel.textColor = AppColor.white
        overviewLabel.numberOfLines = numberOfLines
    }
    
    @objc
    private func moreButtonTapped() {
        delegate?.didChange()
    }
    
    //MARK: - Override Method
    override func setupUI() {
        [titleLabel, moreButton, overviewLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
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
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(contentView).inset(8)
        }
    }
    
    override func setupAttributes() {
        selectionStyle = .none
        moreButton.titleLabel?.font = AppFont.title2.font
        overviewLabel.text = ContentMessage.overview.loading
        overviewLabel.lineBreakMode = .byCharWrapping
    }
    
}
