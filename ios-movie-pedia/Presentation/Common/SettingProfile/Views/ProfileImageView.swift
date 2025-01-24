//
//  ProfileImageView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit
import SnapKit

final class ProfileImageView: BaseView {
    
    //MARK: - UI Property
    let imageView = UIImageView()
    private let cameraImageView = UIImageView()
    
    //MARK: - Method
    func configureData(_ image: String?) {
        guard let image else {
            let randomImage = "profile_\(Int.random(in: 0...11))"
            imageView.image = UIImage(named: randomImage)
            return
        }
        
        imageView.image = UIImage(named: image)
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(cameraImageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(100)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.size.equalTo(30)
        }
    }
    
    override func configureView() {
        backgroundColor = UIColor.clear
        
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = AppColor.accent?.cgColor
        imageView.contentMode = .scaleAspectFit
        
        cameraImageView.image = UIImage(systemName: "camera.fill")
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = AppColor.accent
        cameraImageView.tintColor = AppColor.white
        
        DispatchQueue.main.async {
            self.imageView.configureCircle()
            self.cameraImageView.configureCircle()
        }
    }
    
}
