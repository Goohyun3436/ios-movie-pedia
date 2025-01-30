//
//  PosterCollectionView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import UIKit

final class PosterCollectionView: UICollectionView {
    
    init(_ size: CGSize, _ inset: CGFloat, _ spacing: CGFloat) {
        super.init(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            
            let width: CGFloat = size.width
            let height: CGFloat = size.height
            
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: width, height: height)
            layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            
            return layout
        }())
        
        showsHorizontalScrollIndicator = false
        bounces = false
        
        register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
