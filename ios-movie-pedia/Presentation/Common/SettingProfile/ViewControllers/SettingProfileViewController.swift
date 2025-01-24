//
//  SettingProfileViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit
import SwiftUI

final class SettingProfileViewController: UIViewController {
    
    //MARK: - UI Property
    private let mainView = SettingProfileView()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "프로필 설정"
        
        mainView.configureData("profile_\(Int.random(in: 0...11))")
    }
    
}

#Preview {
    SettingProfileViewController()
}
