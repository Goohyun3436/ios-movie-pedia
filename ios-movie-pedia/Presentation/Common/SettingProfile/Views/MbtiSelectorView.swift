//
//  MbtiSelectorView.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/8/25.
//

import UIKit
import SnapKit

final class MbtiSelectorView: BaseView {
    
    //MARK: - UI Property
    private let wrap = UIStackView()
    private let titleLabel = AppLabel(.title2)
    let collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            
            let inset: CGFloat = 8
            let spacing: CGFloat = 8
            let width: CGFloat = 50
            let height: CGFloat = 50
            
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            
            return layout
        }())
        
        view.register(MbtiSelectorCollectionViewCell.self, forCellWithReuseIdentifier: MbtiSelectorCollectionViewCell.id)
        
        return view
    }()
    
    //MARK: - Override Method
    override func setupUI() {
        addSubview(wrap)
        
        [titleLabel, collectionView].forEach {
            wrap.addArrangedSubview($0)
        }
    }
    
    override func setupConstraints() {
        wrap.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        wrap.axis = .horizontal
        wrap.alignment = .top
        
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(224)
            make.height.equalTo(108)
        }
    }
    
    override func setupAttributes() {
        titleLabel.text = "MBTI"
    }
    
}
