//
//  URL+Extension.swift
//  Practice
//
//  Created by Cypress on 7/29/21.
//

import Foundation

extension URL {
    static var usersURL: Self! = URL(string: "https://jsonplaceholder.typicode.com/users")
    static func albumsURL(for userID: String) -> Self! {
        URL(string: "https://jsonplaceholder.typicode.com/albums")
    }
    static var photoURL: Self! = URL(string: "https://jsonplaceholder.typicode.com/photos")
}
