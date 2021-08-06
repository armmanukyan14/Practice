//
//  Album.swift
//  Practice
//
//  Created by Cypress on 8/5/21.
//

import Foundation

struct Album: Decodable {
    let userID: Int
    let albumID: Int
    let albumTitle: String

    var photos: [URL] {
        [URL.photoURL]
    }
}
