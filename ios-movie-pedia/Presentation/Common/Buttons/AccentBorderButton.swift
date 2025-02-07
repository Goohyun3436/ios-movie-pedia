//
//  AccentBorderButton.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class AccentBorderButton: UIButton {
    
    init(_ title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = AppColor.accent?.cgColor
        titleLabel?.font = AppFont.title2.font
    }
    
    func setAbled(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
        layer.borderColor = isEnabled ? AppColor.accent?.cgColor : AppColor.darkgray?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
