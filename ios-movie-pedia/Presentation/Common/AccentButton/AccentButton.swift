//
//  AccentButton.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

class AccentButton: UIButton {
    
    init(_ title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = AppColor.accent?.cgColor
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
