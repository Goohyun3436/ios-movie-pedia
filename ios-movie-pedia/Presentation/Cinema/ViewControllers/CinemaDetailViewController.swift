//
//  CinemaDetailViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class CinemaDetailViewController: BaseViewController {
    
    //MARK: - UI Property
    private let mainView = CinemaDetailView()
    lazy private var likeButton = LikeButton()
    
    //MARK: - Property
    private let viewModel = CinemaDetailViewModel()
    
    //MARK: - Initializer Method
    init(delegate: LikeDelegate?, movie: Movie?) {
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = delegate
        viewModel.input.movieDidChange.value = movie
    }
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    //MARK: - Setup Method
    override func setupActions() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
    }
    
    override func setupBinds() {
        viewModel.output.navigationTitle.lazyBind { [weak self] title in
            self?.navigationItem.title = title
        }
        
        viewModel.output.likeButtonValidation.lazyBind { [weak self] isEnabled in
            self?.navigationItem.rightBarButtonItem?.isEnabled = isEnabled
        }
        
        viewModel.output.movie.lazyBind { [weak self] movie in
            self?.mainView.infoStackView.configureData([
                MovieInfoValue(movieInfo: .genre_ids, value: movie?.genre_ids),
                MovieInfoValue(movieInfo: .release_date, value: movie?.release_date),
                MovieInfoValue(movieInfo: .vote_average, value: movie?.vote_average)
            ])
        }
        
        viewModel.output.isLike.lazyBind { [weak self] isLike in
            self?.likeButton.setLikeButton(isLike)
        }
        
        viewModel.output.backdrops.lazyBind { [weak self] backdrops in
            self?.mainView.backdropScrollView.images = backdrops
        }
        
        viewModel.output.tableViewReloadData.lazyBind { [weak self] _ in
            self?.mainView.setupTableViewHeight()  //refactor point: 좀 더 명확한 호출 시점 필요
        }
        
        viewModel.output.error.lazyBind { [weak self] code in
            self?.presentErrorAlert(code)
        }
        
        
    }
    
    //MARK: - Method
    @objc private func likeButtonTapped() {
        viewModel.input.likeButtonTapped.value = ()
    }
    
}

//MARK: - UITableViewDelegate
extension CinemaDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let content = viewModel.output.contents[row]
        
        switch content {
        case .overview:
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.id, for: indexPath) as! OverviewTableViewCell
            
            cell.delegate = self
            
            let data = viewModel.output.movie.value?.overview
            let moreButtonTitle = viewModel.output.moreButtonTitle
            let numberOfLines = viewModel.output.overviewNumberOfLines
            cell.setData(content.title, data, moreButtonTitle, numberOfLines)
            
            return cell
            
        case .cast:
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.id, for: indexPath) as! CastTableViewCell
            
            let data = viewModel.output.cast.value
            cell.setData(content.title, data)
            
            return cell
            
        case .poster:
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: PosterMiniTableViewCell.id, for: indexPath) as! PosterMiniTableViewCell
            
            let data = viewModel.output.posters.value
            cell.setData(content.title, data)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: - MoreDelegate
extension CinemaDetailViewController: MoreDelegate {
    
    func didChange() {
        viewModel.input.moreButtonTapped.value = ()
    }
    
}
