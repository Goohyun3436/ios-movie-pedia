//
//  UIImageView+Extension.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

extension UIImageView {
    func heightToFit() {
        let ratio = Double(image?.size.height ?? 0) / Double(image?.size.width ?? 0)
        frame.size.height = frame.size.width * ratio
    }
}
