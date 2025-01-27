//
//  SearchViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class SearchViewController: UIViewController {
    
    //MARK: - UI Property
    private let mainView = SearchView()
    
    //MARK: - Property
    var query: String? {
        didSet {
            guard let query else {
                return
            }
            
            guard oldValue != query else {
                return
            }
            
            totalPages = 0
            totalResults = 0
            isEnd = false
            page = 1
        }
    }
    private var page: Int = 0 {
        didSet {
            callRequest()
        }
    }
    private var totalPages: Int = 0
    private var totalResults: Int = 0
    private var movies = [Movie]()
    private var isEnd: Bool = false
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "영화 검색"
        mainView.searchBar.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.prefetchDataSource = self
        
        query = "액션"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.searchBar.becomeFirstResponder()
    }
    
    //MARK: - Method
    private func callRequest() {
        guard let query else {
            return
        }
        
        NetworkManager.shared.tmdb(.search(query, page), TMDBSearchResponse.self) { data in
            if self.page == 1 {
                self.totalPages = data.total_pages
                self.totalResults = data.total_results
                self.movies = data.results
                
                self.mainView.noneContentLabel.isHidden = !self.movies.isEmpty
                self.mainView.tableView.reloadData()
                
                guard !self.movies.isEmpty else {
                    return
                }
                
                self.mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            } else {
                self.movies.append(contentsOf: data.results)
            }
            
            if self.page == self.totalPages {
                self.isEnd = true
            }
            print("\(self.page)/\(self.totalPages)")
        } failHandler: {
            print("실패")
            self.totalPages = 0
            self.totalResults = 0
            self.movies = []
            self.mainView.tableView.reloadData()
        }

    }
    
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        query = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        query = searchBar.text
    }
    
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as! SearchTableViewCell
        
        cell.delegate = self
        
        let row = movies[indexPath.row]
        cell.configureData(movie: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !isEnd else {
            return
        }
        
        for item in indexPaths {
            if movies.count - 2 == item.row {
                page += 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

//MARK: - UserDelegate
extension SearchViewController: SearchDelegate, LikeDelegate {
    
    func searchesRemoveAll() {}
    
    func searchRemove(_ title: String) {}
    
    func likesDidChange(_ movieId: Int) {
        if let index = User.likes.firstIndex(of: movieId) {
            User.likes.remove(at: index)
        } else {
            User.likes.append(movieId)
        }
        
        for i in movies.indices {
            if movies[i].id == movieId {
                movies[i].is_like.toggle()
            }
        }
        
        mainView.tableView.reloadData()
    }
    
}
