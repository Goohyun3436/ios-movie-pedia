//
//  ProfileStorageViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/9/25.
//

import Foundation

protocol ProfileStrageDelegate {
    func profileDidChange(_ profile: Profile)
}

final class ProfileStorageViewModel {
    
    let profile = Observable(Profile())
    
}
