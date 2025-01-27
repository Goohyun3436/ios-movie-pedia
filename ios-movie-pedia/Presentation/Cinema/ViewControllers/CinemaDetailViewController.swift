//
//  CinemaDetailViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

class CinemaDetailViewController: UIViewController {
    
    //MARK: - Property
    var movie: Movie?
    
    //MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(movie)
    }
    
}
