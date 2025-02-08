//
//  MbtiSelectorCollectionViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/8/25.
//

import UIKit
import SnapKit

class MbtiSelectorCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - UI Property
    private let mbtiLabel = AppLabel(.title2)
    
    //MARK: - Property
    static let id = "MbtiSelectorCollectionViewCell"
    
    //MARK: - Method
    func configureData(_ mbti: String, _ isSelected: Bool) {
        mbtiLabel.text = mbti
        setActive(isSelected)
    }
    
    private func setActive(_ isSelected: Bool) {
        layer.borderColor = isSelected ? AppColor.accent?.cgColor : AppColor.darkgray?.cgColor
        mbtiLabel.textColor = isSelected ? AppColor.white : AppColor.darkgray
        backgroundColor = isSelected ? AppColor.accent : UIColor.clear
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(mbtiLabel)
    }
    
    override func configureLayout() {
        mbtiLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
    
    override func configureView() {
        clipsToBounds = true
        layer.cornerRadius = 25
        self.layer.borderWidth = 1
    }
    
}
