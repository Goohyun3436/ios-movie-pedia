//
//  CinemaDetailView.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/28/25.
//

import UIKit
import SnapKit

final class CinemaDetailView: BaseView {
    
    //MARK: - UI Property
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let backdropScrollView = ImageScrollView()
    let infoStackView = {
        let view = UIStackView()
        view.addArrangedSubview(MovieInfoView(.release_date, "2024-10-10"))
        view.addArrangedSubview(MovieInfoView(.vote_average, 4.5))
        view.addArrangedSubview(MovieInfoView(.genre_ids, [12, 14, 27, 28]))
        return view
    }()
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backdropScrollView)
        contentView.addSubview(infoStackView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        backdropScrollView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(300)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.centerX.bottom.equalToSuperview()
            make.top.equalTo(backdropScrollView.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
        infoStackView.axis = .horizontal
        infoStackView.spacing = 0.5
    }
    
    override func configureView() {
        scrollView.backgroundColor = .red
        contentView.backgroundColor = .orange
        backdropScrollView.backgroundColor = .yellow
        
        infoStackView.backgroundColor = AppColor.darkgray
    }
    
}
