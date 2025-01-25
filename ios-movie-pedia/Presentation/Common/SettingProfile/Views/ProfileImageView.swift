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
    private let imageView = UIImageView()
    private let cameraImageView = UIImageView()
    
    //MARK: - Initializer Method
    init(frame: CGRect = .zero, camera isCameraImage: Bool) {
        super.init(frame: frame)
        cameraImageView.isHidden = !isCameraImage
    }
    
    //MARK: - Method
    func configureData(_ image: String?) {
        guard let image else {
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
        let diameter: CGFloat = self.frame.width == 0 ? 100 : self.frame.width
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(diameter)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.size.equalTo(30)
        }
    }
    
    override func configureView() {
        isUserInteractionEnabled = true
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
