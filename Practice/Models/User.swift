//
//  User.swift
//  Practice
//
//  Created by Cypress on 7/28/21.
//

import Foundation

struct User: Decodable {
    
    let id: Int
    let username: String
    let email: String
}

extension User {
    static var example: [Self] = {
       [
        .init(id: 1, username: "arman", email: "arman@gmail.com"),
        .init(id: 1, username: "arman", email: "arman@gmail.com"),
        .init(id: 1, username: "arman", email: "arman@gmail.com"),
        .init(id: 1, username: "arman", email: "arman@gmail.com")
       ]
    }()
}
