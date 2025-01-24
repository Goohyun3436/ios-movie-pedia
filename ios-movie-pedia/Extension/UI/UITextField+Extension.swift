//
//  UITextField+Extension.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

extension UITextField {
    func configurePlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
    
    func configureBorderBottom(_ borderWidth: CGFloat) {
        let border = CALayer()
        border.frame = CGRect(x: 0.0, y: frame.height - borderWidth, width: frame.width, height: borderWidth)
        border.backgroundColor = AppColor.lightgray?.cgColor
        borderStyle = UITextField.BorderStyle.none
        layer.addSublayer(border)
    }
    
    func addLeftPadding(_ width: CGFloat) {
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: width, height: frame.height))
        leftView = padding
        leftViewMode = ViewMode.always
    }
}
