//
//  Photo.swift
//  Practice
//
//  Created by Cypress on 8/6/21.
//

import Foundation

struct Photo: Decodable {
    let albumID: Int
    let photoID: Int
    let photoURL: String
}
