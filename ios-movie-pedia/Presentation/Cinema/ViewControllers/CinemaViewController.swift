//
//  CinemaViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class CinemaViewController: BaseViewController {
    
    //MARK: - UI Property
    private let mainView = CinemaView()
    
    //MARK: - Property
    private let viewModel = CinemaViewModel()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.userProfileView.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.viewWillAppear.value = ()
    }
    
    //MARK: - Setup Method
    override func setupActions() {
        navigationItem.rightBarButtonItem = makeBarButtonItemWithImage(
            "",
            size: 15,
            handler: #selector(searchButtonTapped)
        )
    }
    
    override func setupBinds() {
        viewModel.output.backButtonTitle.bind { [weak self] title in
            self?.navigationItem.backButtonTitle = title
        }
        
        viewModel.output.rightBarButtonImage.bind { [weak self] image in
            self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: image)
        }
        
        viewModel.output.profile.lazyBind { [weak self] profile in
            self?.mainView.userProfileView.setData(profile)
        }
        
        viewModel.output.likes.lazyBind { [weak self] likes in
            self?.mainView.userProfileView.setData(likes)
        }
        
        viewModel.output.searches.lazyBind { [weak self] searches in
            self?.mainView.tableView.reloadData()
        }
        
        viewModel.output.movies.lazyBind { [weak self] movies in
            self?.mainView.tableView.reloadData()
        }
        
        viewModel.output.error.lazyBind { [weak self] errCode in
            self?.presentErrorAlert(errCode)
        }
        
        viewModel.output.resentSearchTapped.lazyBind { [weak self] query in
            let vc = SearchViewController()
            vc.searchDelegate = self
            vc.likeDelegate = self
            vc.query = query
            self?.pushVC(vc)
        }
        
        viewModel.output.movieTapped.lazyBind { [weak self] movie in
            self?.pushVC(CinemaDetailViewController(
                delegate: self,
                movie: movie
            ))
        }
    }
    
    private func setupTableView() {
        mainView.tableView.register(ResentSearchTableViewCell.self, forCellReuseIdentifier: ResentSearchTableViewCell.id)
        mainView.tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
    }
    
    //MARK: - Method
    @objc private func searchButtonTapped() {
        let vc = SearchViewController()
        vc.likeDelegate = self
        vc.searchDelegate = self
        pushVC(vc)
    }
    
}

//MARK: - ProfileDelegate
extension CinemaViewController: ProfileDelegate {
    
    func profileImageDidChange(_ image: String?) {
        viewModel.output.profile.value?.image = image
    }
    
    func nicknameDidChange(_ nickname: String?) {
        viewModel.output.profile.value?.nickname = nickname
    }
    
    func didClickedProfileView() {
        let vc = SettingProfileViewController(delegate: self)
        vc.modalPresentationStyle = .pageSheet
        presentVC(UINavigationController(rootViewController: vc))
    }
    
}

//MARK: - UITableViewDelegate
extension CinemaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: ResentSearchTableViewCell.id, for: indexPath) as! ResentSearchTableViewCell
            
            cell.collectionView.reloadData()
            
            cell.delegate = self
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            
            cell.collectionView.tag = row
            cell.titleLabel.text = viewModel.output.titles[row].title
            
            cell.removeButton.isHidden = viewModel.output.searches.value.isEmpty
            cell.noneContentLabel.isHidden = !viewModel.output.searches.value.isEmpty
            
            return cell
        } else {
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as! PosterTableViewCell
            
            cell.collectionView.reloadData()
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            
            cell.collectionView.tag = row
            cell.titleLabel.text = viewModel.output.titles[row].title
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: - UICollectionViewDelegate
extension CinemaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return viewModel.output.searches.value.count
        } else {
            return viewModel.output.movies.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResentSearchCollectionViewCell.id, for: indexPath) as! ResentSearchCollectionViewCell
            
            cell.delegate = self
            
            let row = viewModel.output.searches.value[indexPath.item]
            cell.setData(row)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
            
            cell.delegate = self
            
            let row = viewModel.output.movies.value[indexPath.item]
            cell.setData(row)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input.didSelectItemAt.value = (collectionView.tag, indexPath)
    }
    
}

//MARK: - UserDelegate
extension CinemaViewController: SearchDelegate, LikeDelegate {
    
    func searchAdd(_ text: String) {
        viewModel.input.searchAdd.value = text
    }
    
    func searchesRemoveAll() {
        viewModel.input.searchesRemoveAll.value = ()
    }
    
    func searchRemove(_ title: String) {
        viewModel.input.searchRemove.value = title
    }
    
    func likesDidChange(_ movieId: Int, onlyCellReload: Bool) {
        viewModel.input.likesDidChange.value = (movieId, onlyCellReload)
    }
    
}
