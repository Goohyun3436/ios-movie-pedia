//
//  UserProtocol.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import Foundation

protocol SearchDelegate {
    func searchAdd(_ text: String)
    func searchesRemoveAll()
    func searchRemove(_ text: String)
}

protocol LikeDelegate {
    func likesDidChange(_ movieId: Int, onlyCellReload: Bool)
}

protocol ProfileDelegate {
    func profileImageDidChange(_ image: String?)
    func nicknameDidChange(_ nickname: String?)
    func didClickedProfileView()
}
