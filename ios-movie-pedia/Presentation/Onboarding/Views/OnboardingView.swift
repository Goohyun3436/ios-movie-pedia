//
//  OnboardingView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit
import SnapKit

final class OnboardingView: BaseView {
    
    //MARK: - UI Property
    private let wrapView = UIView()
    let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let introLabel = UILabel()
    let startButton = AccentButton("시작하기")
    
    //MARK: - Configure Method
    override func configureHierarchy() {
        addSubview(wrapView)
        wrapView.addSubview(imageView)
        wrapView.addSubview(titleLabel)
        wrapView.addSubview(introLabel)
        wrapView.addSubview(startButton)
    }
    
    override func configureLayout() {
        wrapView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(-16)
        }
        
        introLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(introLabel.snp.bottom).offset(32)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        imageView.image = UIImage(named: "onboarding")
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "Onboarding"
        titleLabel.font = UIFont.italicSystemFont(ofSize: 28)
        
        introLabel.text = "당신만의 영화 세상,\nMoviePedia를 시작해보세요."
        introLabel.font = UIFont.systemFont(ofSize: 14)
        introLabel.textColor = AppColor.secondaryLabel
        introLabel.textAlignment = .center
        introLabel.numberOfLines = 0
    }
    
}
