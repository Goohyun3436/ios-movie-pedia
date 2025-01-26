//
//  UserProtocol.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import Foundation

protocol SearchDelegate {
    func searchesRemoveAll()
    func searchRemove(_ title: String)
}

protocol LikeDelegate {
    func likesDidChange(_ movieId: Int)
}

protocol ProfileDelegate {
    func profileImageDidChange(_ image: String?)
    func nicknameDidChange(_ nickname: String?)
}
