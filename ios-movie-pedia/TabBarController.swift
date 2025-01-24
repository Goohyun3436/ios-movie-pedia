//
//  TabBarController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

private enum TabBar: String, CaseIterable {
    case cinema
    case upcoming
    case profile
    
    var vc: UIViewController.Type {
        switch self {
        case .cinema:
            return CinemaViewController.self
        case .upcoming:
            return UpcomingViewController.self
        case .profile:
            return ProfileViewController.self
        }
    }
    
    var title: String {
        switch self {
        case .cinema:
            return "오늘의 영화"
        case .upcoming:
            return "최신 영화"
        case .profile:
            return "설정"
        }
    }
    
    var icon: String {
        switch self {
        case .cinema:
            return "popcorn"
        case .upcoming:
            return "film.stack"
        case .profile:
            return "person.crop.circle"
        }
    }
}

final class TabBarController: UITabBarController {
    
    //MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTBC()
    }
    
    //MARK: - Method
    private func configureTBC() {
        let tabs = TabBar.allCases
        var navs = [UINavigationController]()
        
        for item in tabs {
            navs.append(makeNav(item))
        }
        
        setViewControllers(navs, animated: true)
    }
    
    private func makeNav(_ tab: TabBar) -> UINavigationController {
        let vc = tab.vc.init()
        let nav = UINavigationController(rootViewController: vc)
        vc.navigationItem.title = tab.title
        nav.tabBarItem.image = UIImage(systemName: tab.icon, withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 16, weight: .bold)))
        nav.tabBarItem.title = tab.rawValue.uppercased()
        return nav
    }
}
