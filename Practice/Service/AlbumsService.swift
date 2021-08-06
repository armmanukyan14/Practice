//
//  AlbumsService.swift
//  Practice
//
//  Created by Cypress on 8/5/21.
//

import Foundation
import RxAlamofire
import RxSwift

class AlbumsService {
    static let shared = AlbumsService()
    private init() {}

    func getAlbums(for userID: String) -> Observable<[Album]> {
        RxAlamofire.request(.get, URL.albumsURL(for: userID))
            .validate(statusCode: 200 ..< 300)
            .data()
            .compactMap { data in
                try? JSONDecoder.default.decode([Album].self, from: data)
            }
    }
}

extension JSONDecoder {
    static let `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
