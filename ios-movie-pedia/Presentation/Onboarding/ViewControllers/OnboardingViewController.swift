//
//  OnboardingViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    //MARK: - UI Property
    let mainView = OnboardingView()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        mainView.imageView.heightToFit()
    }
    
}
