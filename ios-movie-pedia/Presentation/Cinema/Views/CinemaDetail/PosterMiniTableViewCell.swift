//
//  PosterTableViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/29/25.
//

import UIKit
import SnapKit

final class PosterMiniTableViewCell: BaseTableViewCell {
    
    //MARK: - UI Property
    private let titleLabel = AppLabel(.title1)
    private lazy var collectionView = {
        let view = PosterCollectionView(CGSize(width: 130, height: 200), 16, 8)
        
        view.delegate = self
        view.dataSource = self
        view.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.id)
        
        return view
    }()
    private let noneContentLabel = AppLabel(.text4, AppColor.darkgray)
    
    //MARK: - Property
    static let id = "PosterMiniTableViewCell"
    private var posters = [Image]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Method
    func configureData(_ title: String, _ posters: [Image]) {
        titleLabel.text = title
        self.posters = posters
        
        guard !posters.isEmpty else {
            noneContentLabel.text = ContentMessage.poster.none
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
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(contentView)
            make.height.equalTo(216)
        }
        
        noneContentLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    override func configureView() {
        noneContentLabel.text = ContentMessage.poster.loading
    }
    
}

extension PosterMiniTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.id, for: indexPath) as! ImageCollectionViewCell
        
        cell.setData(posters[indexPath.item].file_path)
        
        return cell
    }
    
}
