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
    func setData(_ image: String?) {
        guard let image else {
            return
        }
        
        imageView.image = UIImage(named: image)
    }
    
    func setEnable() {
        imageView.alpha = 1
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = AppColor.accent?.cgColor
    }
    
    func setDisable() {
        imageView.alpha = 0.5
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = AppColor.darkgray?.cgColor
    }
    
    //MARK: - Override Method
    override func setupUI() {
        [imageView, cameraImageView].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
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
    
    override func setupAttributes() {
        isUserInteractionEnabled = true
        backgroundColor = UIColor.clear
        
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = AppColor.accent?.cgColor
        imageView.contentMode = .scaleAspectFit
        
        cameraImageView.image = UIImage(systemName: "camera.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 12)))
        cameraImageView.clipsToBounds = true
        cameraImageView.layer.cornerRadius = 15
        cameraImageView.contentMode = .center
        cameraImageView.backgroundColor = AppColor.accent
        cameraImageView.tintColor = AppColor.white
        
        if self.frame.width == 0 {
            imageView.layer.cornerRadius = 50
        } else {
            imageView.layer.cornerRadius = self.frame.width / 2
        }
    }
    
}
