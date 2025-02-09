//
//  OnboardingViewModel.swift
//  ios-movie-pedia
//
//  Created by Goo on 2/9/25.
//

import Foundation

final class OnboardingViewModel {
    
    //MARK: - Input
    let loadView: Observable<Void?> = Observable(nil)
    let startButtonTapped: Observable<Void?> = Observable(nil)
    
    //MARK: - Output
    let onboardingModel: Observable<OnboardingModel?> = Observable(nil)
    let mainImage: Observable<String?> = Observable(nil)
    let logoText: Observable<String?> = Observable(nil)
    let introText: Observable<String?> = Observable(nil)
    let pushVC: Observable<Void?> = Observable(nil)
    
    //MARK: - Bind
    init() {
        loadView.lazyBind { [weak self] _ in
            self?.onboardingModel.value = OnboardingModel(
                image: "onboarding",
                logo: "Onboarding",
                intro: "당신만의 영화 세상,\nMoviePedia를 시작해보세요."
            )
        }
        
        startButtonTapped.lazyBind { [weak self] _ in
            self?.pushVC.value = ()
        }
    }
    
}
