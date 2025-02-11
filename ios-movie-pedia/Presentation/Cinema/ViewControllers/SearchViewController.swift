//
//  SearchViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    //MARK: - UI Property
    private let mainView = SearchView()
    
    //MARK: - Property
    private let viewModel = SearchViewModel()
    
    //MARK: - Initializer Method
    init(
        searchDelegate: SearchDelegate?,
        likeDelegate: LikeDelegate?,
        query: String?
    ) {
        super.init(nibName: nil, bundle: nil)
        viewModel.searchDelegate = searchDelegate
        viewModel.likeDelegate = likeDelegate
        viewModel.input.query.value = query
    }
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.searchBar.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.prefetchDataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.input.viewDidAppear.value = ()
    }
    
    //MARK: - Setup Method
    override func setupBinds() {
        viewModel.output.navigationTitle.bind { [weak self] title in
            self?.navigationItem.title = title
        }
        
        viewModel.output.backButtonTitle.bind { [weak self] title in
            self?.navigationItem.backButtonTitle = title
        }
        
        viewModel.output.showsKeyboard.lazyBind { [weak self] shows in
            if shows {
                self?.mainView.searchBar.becomeFirstResponder()
            } else {
                self?.mainView.searchBar.resignFirstResponder()
            }
        }
        
        viewModel.output.showsCancelButton.lazyBind { [weak self] shows in
            self?.mainView.searchBar.setShowsCancelButton(shows, animated: true)
        }
        
        viewModel.output.showsNoneContentLabel.lazyBind { [weak self] isHidden in
            self?.mainView.noneContentLabel.isHidden = isHidden
        }
        
        viewModel.output.searchBarText.lazyBind { [weak self] text in
            self?.mainView.searchBar.text = text
        }
        
        viewModel.output.movies.lazyBind { [weak self] movies in
            self?.mainView.tableView.reloadData()
        }
        
        viewModel.output.pushVC.lazyBind { [weak self] movie in
            self?.pushVC(CinemaDetailViewController(
                delegate: self,
                movie: movie
            ))
        }
    }
    
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.input.searchBarShouldBeginEditing.value = ()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.input.searchBarCancelButtonClicked.value = ()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.input.searchBarSearchButtonClicked.value = searchBar.text
    }
    
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.movies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as! SearchTableViewCell
        
        cell.delegate = self
        
        let row = viewModel.output.movies.value[indexPath.row]
        cell.configureData(movie: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.input.prefetchRowsAt.value = indexPaths
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.didSelectRowAt.value = indexPath
    }
    
}

//MARK: - UserDelegate
extension SearchViewController: SearchDelegate, LikeDelegate {
    func searchAdd(_ text: String) {}
    
    func searchesRemoveAll() {}
    
    func searchRemove(_ text: String) {}
    
    func likesDidChange(_ movieId: Int, onlyCellReload: Bool) {
        viewModel.input.likesDidChange.value = (movieId, onlyCellReload)
    }
    
}
