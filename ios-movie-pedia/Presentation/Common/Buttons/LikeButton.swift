//
//  LikeButton.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/27/25.
//

import UIKit

final class LikeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentHorizontalAlignment = .right
        setLikeButton(false)
    }
    
    func setLikeButton(_ isLike: Bool) {
        setImage(UIImage(systemName: isLike ? "heart.fill" : "heart"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
