//
//  CinemaViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

final class CinemaViewController: UIViewController {
    
    //MARK: - UI Property
    private let mainView = CinemaView()
    
    //MARK: - Property
    private var profile = Profile()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let saved = loadJsonData(type: Profile.self, forKey: "profile") {
            profile = saved
        }
        
        mainView.userProfileView.configureData(profile)
    }
    
}
