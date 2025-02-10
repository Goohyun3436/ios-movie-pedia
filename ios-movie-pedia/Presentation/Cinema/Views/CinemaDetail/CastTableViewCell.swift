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
    private let titleLabel = AppLabel(.title1)
    lazy private var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            
            let inset: CGFloat = 16
            let spacing: CGFloat = 16
            let width: CGFloat = 170
            let height: CGFloat = 50
            
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: width, height: height)
            layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            
            return layout
        }())
        
        view.delegate = self
        view.dataSource = self
        view.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.id)
        
        return view
    }()
    private let noneContentLabel = AppLabel(.text4, AppColor.darkgray)
    
    //MARK: - Property
    static let id = "CastTableViewCell"
    private var cast = [Person]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Method
    func configureData(_ title: String, _ cast: [Person]) {
        titleLabel.text = title
        self.cast = cast
        
        guard !cast.isEmpty else {
            noneContentLabel.text = ContentMessage.cast.none
            noneContentLabel.isHidden = false
            return
        }
        
        noneContentLabel.isHidden = true
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(noneContentLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(contentView).inset(8)
            make.height.equalTo(116)
        }
        
        noneContentLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    override func configureView() {
        selectionStyle = .none
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        noneContentLabel.text = ContentMessage.cast.loading
    }
    
}

//MARK: - UICollectionViewDelegate
extension CastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.id, for: indexPath) as! PersonCollectionViewCell
        
        cell.setData(cast[indexPath.item])
        
        return cell
    }
    
}
