//
//  BaseView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

//MVVM 구조 전환 및 메서드명 변경중
class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupAttributes()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func setupUI() {}
    func setupConstraints() {}
    func setupAttributes() {}
    
    func configureHierarchy() {}
    
    func configureLayout() {}
    
    func configureView() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
