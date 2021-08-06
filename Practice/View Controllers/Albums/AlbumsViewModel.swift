//
//  AlbumsViewController.swift
//  Practice
//
//  Created by Cypress on 8/5/21.
//

import Foundation
import RxRelay
import RxSwift

final class AlbumsViewModel {
    private let disposeBag = DisposeBag()
    
    let refresh = PublishRelay<Void>()
    let userID = BehaviorRelay<String?>(value: nil)

    let albums = PublishRelay<[Album]>()

    init() {
        doBindings()
    }

    private func doBindings() {
        refresh
            .withLatestFrom(userID).compactMap { $0 }
            .flatMapLatest { userID in
                AlbumsService.shared.getAlbums(for: userID)
            }
            .bind(to: albums)
            .disposed(by: disposeBag)
    }
}
