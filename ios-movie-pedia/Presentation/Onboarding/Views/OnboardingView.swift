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
    private let logoLabel = AppLabel(.logo)
    private let introLabel = AppLabel(.text2, AppColor.secondaryLabel)
    let startButton = AccentBorderButton("시작하기")
    
    //MARK: - Method
    func setData(_ onboardingModel: OnboardingModel?) {
        guard let onboardingModel else {
            imageView.image = UIImage(named: "onboarding")
            return
        }
        
        imageView.image = UIImage(named: onboardingModel.image ?? "")
        logoLabel.text = onboardingModel.logo
        introLabel.text = onboardingModel.intro
    }
    
    //MARK: - Setup Method
    override func setupUI() {
        addSubview(wrapView)
        
        [imageView, logoLabel, introLabel, startButton].forEach {
            wrapView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        wrapView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        logoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(-16)
        }
        
        introLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoLabel.snp.bottom).offset(16)
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalTo(introLabel.snp.bottom).offset(32)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    override func setupAttributes() {
        imageView.contentMode = .scaleAspectFit
        introLabel.textAlignment = .center
        introLabel.numberOfLines = 0
    }
    
}
