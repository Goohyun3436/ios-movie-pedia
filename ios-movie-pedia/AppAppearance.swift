//
//  AppAppearance.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

enum AppColor {
    static let accent = UIColor(named: "AccentColor")
    static let darkgray = UIColor(named: "DarkGrayColor")
    static let lightgray = UIColor(named: "LightGrayColor")
    static let black = UIColor.black
    static let white = UIColor.white
    static let secondaryLabel = UIColor.lightGray
    static let secondaryBackgroundColor = UIColor(named: "SecondaryBackgroundColor")
    static let tertiaryBackgroundColor = UIColor(named: "TertiaryBackgroundColor")
}

final class AppAppearance {
    static func setUpAppearance() {
        let appearanceT = UITabBarAppearance()
        appearanceT.configureWithTransparentBackground()
        appearanceT.backgroundColor = AppColor.secondaryBackgroundColor
        UITabBar.appearance().tintColor = AppColor.accent
        UITabBar.appearance().standardAppearance = appearanceT
        UITabBar.appearance().scrollEdgeAppearance = appearanceT
        
        let appearanceN = UINavigationBarAppearance()
        appearanceN.configureWithTransparentBackground()
        appearanceN.backgroundColor = AppColor.black
        appearanceN.titleTextAttributes = [.foregroundColor: AppColor.white, .font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        appearanceN.largeTitleTextAttributes = [.foregroundColor: AppColor.white]
        UINavigationBar.appearance().standardAppearance = appearanceN
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceN
        
        BaseView.appearance().backgroundColor = AppColor.black
        
        UILabel.appearance().textColor = AppColor.white
        
        UIButton.appearance().setTitleColor(AppColor.accent, for: .normal)
        UIButton.appearance().setTitleColor(AppColor.darkgray, for: .disabled)
        
        UITextField.appearance().tintColor = AppColor.accent
        UITextField.appearance().textColor = AppColor.white
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.dark
        
        UISearchBar.appearance().barTintColor = UIColor.black
        UISearchBar.appearance().keyboardAppearance = UIKeyboardAppearance.dark
        UISearchTextField.appearance().tintColor = AppColor.lightgray
        UISearchTextField.appearance().backgroundColor = AppColor.tertiaryBackgroundColor
        
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableView.appearance().separatorColor = AppColor.tertiaryBackgroundColor
        UITableView.appearance().indicatorStyle = .white
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectionStyle = .none
        
        UICollectionView.appearance().backgroundColor = UIColor.clear
    }
}
