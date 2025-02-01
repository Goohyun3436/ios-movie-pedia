//
//  AppLabel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/1/25.
//

import UIKit

final class AppLabel: UILabel {
    
    init(_ appFont: AppFont, _ color: UIColor? = AppColor.white) {
        super.init(frame: .zero)
        self.font = appFont.font
        self.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
