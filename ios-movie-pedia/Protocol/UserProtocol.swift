//
//  UserProtocol.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import Foundation

protocol SearchDelegate {
    func searchesDidChange()
}

protocol LikeDelegate {
    func likesDidChange()
}

protocol ProfileDelegate {
    func profileImageDidChange(_ image: String?)
    func nicknameDidChange(_ nickname: String?)
}
