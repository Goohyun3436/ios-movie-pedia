//
//  ResentSearchCollectionView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import UIKit

final class ResentSearchCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            
            let inset: CGFloat = 16
            let spacing: CGFloat = 8
            let width: CGFloat = 80
            let height: CGFloat = 30
            
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: width, height: height)
            layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            
            return layout
        }())
        
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
