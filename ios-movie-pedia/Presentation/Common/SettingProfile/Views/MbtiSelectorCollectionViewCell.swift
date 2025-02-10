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
    func setData(_ character: String?, _ isSelected: Bool) {
        mbtiLabel.text = character
        setActive(isSelected)
    }
    
    private func setActive(_ isSelected: Bool) {
        layer.borderColor = isSelected ? AppColor.accent?.cgColor : AppColor.darkgray?.cgColor
        mbtiLabel.textColor = isSelected ? AppColor.white : AppColor.darkgray
        backgroundColor = isSelected ? AppColor.accent : UIColor.clear
    }
    
    //MARK: - Override Method
    override func setupUI() {
        contentView.addSubview(mbtiLabel)
    }
    
    override func setupConstraints() {
        mbtiLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
    
    override func setupAttributes() {
        clipsToBounds = true
        layer.cornerRadius = 25
        self.layer.borderWidth = 1
    }
    
}
