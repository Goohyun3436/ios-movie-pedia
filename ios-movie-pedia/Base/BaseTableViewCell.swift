//
//  BaseTableViewCell.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
