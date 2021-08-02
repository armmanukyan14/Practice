//
//  UsersViewModel.swift
//  Practice
//
//  Created by Cypress on 8/2/21.
//

import Foundation
import RxSwift
import RxRelay

final class UsersViewModel {
    
    let disposeBag = DisposeBag()
    
    let refresh = PublishRelay<Void>()
    
    let users = PublishRelay<[User]>()
    
    init() {
        doBindings()
    }
    
    private func doBindings() {
        refresh
            .flatMapLatest {
                UsersService.shared.getUsers()
            }
            .bind(to: users)
            .disposed(by: disposeBag)
    }
}
