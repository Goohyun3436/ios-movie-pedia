//
//  KeyboardViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/9/25.
//

import Foundation

final class KeyboardViewModel {
    
    //MARK: - Input
    let viewDidAppear: Observable<Void?> = Observable(nil)
    let viewWillDisappear: Observable<Void?> = Observable(nil)
    let inputMainViewTapped: Observable<Void?> = Observable(nil)
    let textFieldShouldReturn: Observable<Void?> = Observable(nil)
    
    //MARK: - Output
    let showsKeyboard: Observable<Bool> = Observable(false)
    
    //MARK: - Bind
    init() {
        viewDidAppear.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = true
        }
        
        viewWillDisappear.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = false
        }
        
        inputMainViewTapped.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = false
        }
        
        textFieldShouldReturn.lazyBind { [weak self] _ in
            self?.showsKeyboard.value = false
        }
    }
    
}
