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
    let infoStackView = MovieInfoStackView()
    let tableView = {
       let view = UITableView()
        view.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.id)
        view.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.id)
        view.register(PosterMiniTableViewCell.self, forCellReuseIdentifier: PosterMiniTableViewCell.id)
        return view
    }()
    
    //MARK: - Property
    private var tableViewHeightConstraint: Constraint?
    private var tableViewHeightWithoutOverView: CGFloat = 420.0
    
    //MARK: - Method
    func setupTableViewHeight() {
        tableView.reloadData()
        
        let height: CGFloat = tableViewHeightWithoutOverView + tableView.visibleCells[0].frame.height
        
        tableViewHeightConstraint?.deactivate()
        
        tableView.snp.makeConstraints { make in
            tableViewHeightConstraint = make.height.equalTo(height).constraint
        }
    }
    
    //MARK: - Setup Method
    override func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [backdropScrollView, infoStackView, tableView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide)
            make.verticalEdges.equalTo(safeAreaLayoutGuide)
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
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(infoStackView.snp.bottom)
            tableViewHeightConstraint = make.height.greaterThanOrEqualTo(508).constraint
        }
    }
    
    override func setupAttributes() {
        scrollView.bounces = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }
    
}
