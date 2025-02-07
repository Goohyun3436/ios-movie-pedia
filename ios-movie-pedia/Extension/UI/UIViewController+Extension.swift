//
//  UIViewController+Extension.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/25/25.
//

import UIKit

extension UIViewController {    
    func presentAlert(_ title: String?, _ message: String?, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .destructive) { action in
            completionHandler()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        alert.overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
        
        present(alert, animated: true)
    }
    
    func presentErrorAlert(_ status: TMDBStatusCode) {
        let alert = UIAlertController(title: "실패", message: "\(status.ko) (\(status.statusCode))", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .destructive)
        
        alert.addAction(ok)
        
        alert.overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
        
        present(alert, animated: true)
    }
    
    func getUserProfile() -> Profile? {
        guard let saved = UserDefaultManager.shared.loadJsonData(type: Profile.self, forKey: .profile) else {
            return nil
        }
        
        return saved
    }
    
    func pushVC(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func presentVC(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureRootVC(_ viewController: UIViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            return
        }

        window.rootViewController = viewController
    }
    
    func makeBarButtonItemWithImage(_ image: String, size: CGFloat = 16, handler: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(
            image: UIImage(
                systemName: image,
                withConfiguration: UIImage.SymbolConfiguration(
                    font: .systemFont(ofSize: size)
                )
            ),
            style: .plain,
            target: self,
            action: handler
        )
    }
    
    func makeBarButtonItemWithTitle(_ title: String, handler: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(
            title: title,
            style: .plain,
            target: self,
            action: handler
        )
    }
}
