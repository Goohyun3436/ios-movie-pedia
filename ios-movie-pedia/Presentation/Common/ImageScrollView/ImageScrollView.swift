//
//  ImageScrollView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/28/25.
//

import UIKit
import SnapKit

final class ImageScrollView: BaseView {
    
    //MARK: - UI Property
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let pageControl = UIPageControl()
    
    //MARK: - Property
    var images = [String]() {
        didSet {
            pageControl.numberOfPages = images.count
            pageControl.size(forNumberOfPages: images.count)
            
            for i in images.indices {
                let imageView = UIImageView()
                imageView.image = UIImage(systemName: images[i])
                
                stackView.addArrangedSubview(imageView)
                
                imageView.snp.makeConstraints { make in
                    make.width.equalTo(UIScreen.main.bounds.width)
                }
                
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFit
            }
        }
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(pageControl)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(scrollView)
            make.height.equalToSuperview()
        }
        
        stackView.axis = .horizontal
        stackView.spacing = 0
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
    }
    
    override func configureView() {
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = 0
        pageControl.layer.cornerRadius = 12
        pageControl.backgroundColor = AppColor.deepgray
        pageControl.pageIndicatorTintColor = AppColor.darkgray
        pageControl.currentPageIndicatorTintColor = AppColor.white
    }
    
}

extension ImageScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = UIScreen.main.bounds.width
        let horizontalCenter = width / 2
        
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
}
