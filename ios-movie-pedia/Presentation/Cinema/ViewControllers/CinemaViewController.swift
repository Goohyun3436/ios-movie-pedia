//
//  CinemaViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

class CinemaViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profile = loadJsonData(type: Profile.self, forKey: "profile")
        print(profile)
    }
    
}
