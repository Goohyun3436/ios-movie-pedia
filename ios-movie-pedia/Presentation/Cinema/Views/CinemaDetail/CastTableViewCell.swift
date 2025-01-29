//
//  CastTableViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/29/25.
//

import UIKit
import SnapKit

final class CastTableViewCell: BaseTableViewCell {
    
    //MARK: - UI Property
    private let titleLabel = UILabel()
    lazy private var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            
            let inset: CGFloat = 8
            let spacing: CGFloat = 8
            let width: CGFloat = 170
            let height: CGFloat = 50
            
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: width, height: height)
            layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            
            return layout
        }())
        
        view.delegate = self
        view.dataSource = self
        view.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.id)
        
        return view
    }()
    
    //MARK: - Property
    static let id = "CastTableViewCell"
    private var casts = [Person]()
    
    //MARK: - Method
    func configureData(_ title: String, _ casts: [Person]) {
        titleLabel.text = title
        self.casts = casts
        collectionView.reloadData()
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(contentView)
            make.height.equalTo(124)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        collectionView.bouncesHorizontally = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
}

//MARK: - UICollectionViewDelegate
extension CastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.id, for: indexPath) as! PersonCollectionViewCell
        
        cell.configureData(casts[indexPath.item])
        
        return cell
    }
    
}
