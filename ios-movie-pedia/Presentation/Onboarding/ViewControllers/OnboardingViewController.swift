//
//  OnboardingViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    //MARK: - UI Property
    let wrapView = UIView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let introLabel = UILabel()
    let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .orange
        
        view.addSubview(wrapView)
        wrapView.addSubview(imageView)
        wrapView.addSubview(titleLabel)
        wrapView.addSubview(introLabel)
        wrapView.addSubview(startButton)
        
        wrapView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(402.0 / 493.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(16)
        }
        
        introLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(introLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        imageView.image = UIImage(named: "onboarding")
        imageView.contentMode = .scaleAspectFit
        titleLabel.text = "Onboarding"
        introLabel.text = "당신만의 영화 세상,\nMoviePedia를 시작해보세요."
        introLabel.numberOfLines = 0
        startButton.setTitle("시작하기", for: .normal)
    }
    
}
