//
//  ImageScrollView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/28/25.
//

import UIKit
import Kingfisher
import SnapKit

final class ImageScrollView: BaseView {
    
    //MARK: - UI Property
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let pageControl = UIPageControl()
    private let noneContentLabel = UILabel()
    
    //MARK: - Property
    var images = [Image]() {
        didSet {
            guard !images.isEmpty else {
                noneContentLabel.isHidden = false
                noneContentLabel.text = ContentMessage.backdrops.none
                return
            }
            
            noneContentLabel.isHidden = true
            
            let numberOfPages = images.count > 5 ? 5 : images.count
            pageControl.numberOfPages = numberOfPages
            pageControl.size(forNumberOfPages: numberOfPages)
            
            for i in 0..<numberOfPages {
                let imageView = UIImageView()
                
                if let image = images[i].file_path, let url = URL(string: TMDBImageRequest.original(image).endpoint) {
                    imageView.kf.setImage(with: url)
                }
                
                stackView.addArrangedSubview(imageView)
                
                imageView.snp.makeConstraints { make in
                    make.width.equalTo(UIScreen.main.bounds.width)
                }
                
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFill
            }
        }
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(pageControl)
        addSubview(noneContentLabel)
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
            make.bottom.equalToSuperview().inset(4)
            make.height.equalTo(24)
        }
        
        noneContentLabel.snp.makeConstraints { make in
            make.center.equalTo(scrollView)
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
        pageControl.allowsContinuousInteraction = false
        pageControl.transform = CGAffineTransformMakeScale(0.8, 0.8)
        pageControl.backgroundColor = AppColor.deepgray
        pageControl.pageIndicatorTintColor = AppColor.darkgray
        pageControl.currentPageIndicatorTintColor = AppColor.white
        
        noneContentLabel.text = ContentMessage.backdrops.loading
        noneContentLabel.font = UIFont.systemFont(ofSize: 12)
        noneContentLabel.textColor = AppColor.darkgray
    }
    
}

//MARK: - UIScrollViewDelegate
extension ImageScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = UIScreen.main.bounds.width
        let horizontalCenter = width / 2
        
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
}
