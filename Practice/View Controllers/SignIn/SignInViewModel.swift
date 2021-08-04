//
//  SignInViewModel.swift
//  Practice
//
//  Created by Cypress on 7/21/21.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel {
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Inputs
    
    let email = PublishRelay<String>()
    let password = PublishRelay<String>()

    // MARK: - Outputs

    let emailError = BehaviorRelay<String?>(value: nil)
    let passwordError = BehaviorRelay<String?>(value: nil)
    let isSignInEnabled = BehaviorRelay(value: false)
    
    // MARK: - Init
    
    init() {
        doBindings()
    }
    
    // MARK: - Reactive
    
    private func doBindings() {
        email
            .filter { !$0.isEmpty }
            .map { [weak self] in self?.validate(email: $0) }
            .bind(to: emailError)
            .disposed(by: disposeBag)
        password
            .map { [weak self] in self?.validate(password: $0) }
            .bind(to: passwordError)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(emailError, passwordError) {
            $0 == nil && $1 == nil
        }
        .bind(to: isSignInEnabled)
        .disposed(by: disposeBag)
    
    }
    
    // MARK: - Methods
    
    func validate(email: String) -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValid = emailPredicate.evaluate(with: email)
        return isValid ? nil : "Invalid e-mail!"
      }
    
      func validate(password: String) -> String? {
        let isValid = !password.isEmpty
        return isValid ? nil : "Password cannot be empty!"
      }
}
