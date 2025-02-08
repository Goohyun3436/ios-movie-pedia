//
//  MbtiSelectorViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/8/25.
//

import Foundation

final class MbtiSelectorViewModel {
    
    //MARK: - Input
    let didSelectItemAt: Observable<IndexPath?> = Observable(nil)
    
    //MARK: - Output
    let titleText = Observable("MBTI")
    let mbtiList = [ "E", "I", "S", "N", "T", "F", "J", "P"]
    let selectedMbti: Observable<[String?]> = Observable([nil, nil, nil, nil])
    
    //MARK: - Property
    var delegate: MbtiDelegate?
    
    //MARK: - Initializer Method
    init() {
        didSelectItemAt.lazyBind { [weak self] indexPath in
            guard let indexPath else { return }
            
            let character = self?.mbtiList[indexPath.item]
            let sectionIndex = indexPath.item / 2
            
            guard let isSelected = self?.selectedMbti.value.contains(character) else {
                return
            }
            
            if isSelected {
                self?.selectedMbti.value[sectionIndex] = nil
            } else {
                self?.selectedMbti.value[sectionIndex] = character
            }
            
            if let selectedMbti = self?.selectedMbti.value {
                self?.delegate?.didChange(selectedMbti)
            }
        }
    }
    
}
