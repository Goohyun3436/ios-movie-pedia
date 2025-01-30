//
//  AccentFillButton.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/25/25.
//

import UIKit

final class AccentFillButton: UIButton {
    
    init(_ title: String = "") {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 8
        backgroundColor = AppColor.accent
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        setTitleColor(AppColor.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
