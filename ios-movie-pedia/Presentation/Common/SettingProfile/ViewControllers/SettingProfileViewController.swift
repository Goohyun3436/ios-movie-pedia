//
//  SettingProfileViewController.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/24/25.
//

import UIKit

enum NicknameCondition {
    case satisfied, length, symbol, number
    
    var msg: String {
        switch self {
        case .satisfied:
            return "사용할 수 있는 닉네임이에요"
        case .length:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .symbol:
            return "닉네임에 @, #, $, % 는 포함할 수 없어요"
        case .number:
            return "닉네임에 숫자는 포함할 수 없어요"
        }
    }
}

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
        
        mainView.nicknameTextField.delegate = self
        
        mainView.configureData("profile_\(Int.random(in: 0...11))")
        mainView.configureStatus(NicknameCondition.length)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainView.nicknameTextField.becomeFirstResponder()
    }
    
}

//MARK: - UITextField
extension SettingProfileViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard var name = textField.text else {
            return
        }
        
        name = name.trimmingCharacters(in: .whitespaces)
        
        guard !name.matches("[0-9]") else {
            mainView.configureStatus(NicknameCondition.number)
            return
        }
        
        guard !name.matches("[@#$%]") else {
            mainView.configureStatus(NicknameCondition.symbol)
            return
        }
        
        guard 2 <= name.count && name.count < 10 else {
            mainView.configureStatus(NicknameCondition.length)
            return
        }
        
        mainView.configureStatus(NicknameCondition.satisfied)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
