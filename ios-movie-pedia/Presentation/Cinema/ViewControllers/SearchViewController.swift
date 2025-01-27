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
            callRequest()
        }
    }
    private var page: Int = 1
    private var total_pages: Int = 0
    private var total_results: Int = 0
    private var movies = [Movie]()
    
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
        
        query = "뚫뚫뚫"
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
        
        NetworkManager.shared.tmdb(.search(query, 1), TMDBSearchResponse.self) { data in
            self.total_pages = data.total_pages
            self.total_results = data.total_results
            self.movies = data.results
            
            self.mainView.noneContentLabel.isHidden = !self.movies.isEmpty
            
            self.mainView.tableView.reloadData()
        } failHandler: {
            print("실패")
            self.total_pages = 0
            self.total_results = 0
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
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
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
