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
    
    //MARK: - Property
    var delegate: ProfileDelegate?
    
    //MARK: - Method
    func configureData(_ image: String?) {
        let img = image ?? "profile_\(Int.random(in: 0...11))"
        
        delegate?.profileImageDidChange(img)
        imageView.image = UIImage(named: img)
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
