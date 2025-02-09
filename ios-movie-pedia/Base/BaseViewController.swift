//
//  BaseViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/9/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setupActions()
        setupBinds()
    }
    
    func setupActions() {}
    func setupBinds() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
