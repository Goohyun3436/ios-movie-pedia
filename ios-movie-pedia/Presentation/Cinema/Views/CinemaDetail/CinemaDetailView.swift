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
    let tableView = {
       let view = UITableView()
        view.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.id)
        view.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.id)
        view.register(PosterMiniTableViewCell.self, forCellReuseIdentifier: PosterMiniTableViewCell.id)
        return view
    }()
    
    //MARK: - Property
    private var tableViewHeightConstraint: Constraint?
    
    //MARK: - Method
    func configureTableViewHeight() {
        tableView.reloadData()
        
        var height: CGFloat = 0
        
        for item in tableView.visibleCells {
            height += item.frame.height
        }
        
        tableViewHeightConstraint?.deactivate()
        
        tableView.snp.makeConstraints { make in
            tableViewHeightConstraint = make.height.equalTo(height).constraint
        }
    }
    
    //MARK: - Override Method
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backdropScrollView)
        contentView.addSubview(infoStackView)
        contentView.addSubview(tableView)
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
            make.centerX.equalToSuperview()
            make.top.equalTo(backdropScrollView.snp.bottom).offset(16)
        }
        infoStackView.axis = .horizontal
        infoStackView.spacing = 0.5
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(infoStackView.snp.bottom)
            tableViewHeightConstraint = make.height.equalTo(508).constraint
        }
    }
    
    override func configureView() {
        scrollView.bouncesVertically = false
        
        infoStackView.backgroundColor = AppColor.darkgray
        
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }
    
}
