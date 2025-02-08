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
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
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
    
    //MARK: - Property
    private let mbtiList = [ "E", "I", "S", "N", "T", "F", "J", "P"]
    private var selectedMbti: [String?] = [nil, nil, nil, nil]
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(wrap)
        
        [titleLabel, collectionView].forEach {
            wrap.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
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
    
    override func configureView() {
        titleLabel.text = "MBTI"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MbtiSelectorCollectionViewCell.self, forCellWithReuseIdentifier: MbtiSelectorCollectionViewCell.id)
    }
    
}

extension MbtiSelectorView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mbtiList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MbtiSelectorCollectionViewCell.id, for: indexPath) as! MbtiSelectorCollectionViewCell
        
        let mbti = mbtiList[indexPath.item]
        let isSelected = selectedMbti.contains(mbti)
        cell.configureData(mbti, isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mbti = mbtiList[indexPath.item]
        let sectionIndex = indexPath.item / 2
        
        if selectedMbti.contains(mbti) {
            selectedMbti[sectionIndex] = nil
        } else {
            selectedMbti[sectionIndex] = mbti
        }
        
        print(selectedMbti)
        
        collectionView.reloadData()
    }
    
}
