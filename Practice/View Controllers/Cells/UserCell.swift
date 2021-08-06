//
//  UserCell.swift
//  Practice
//
//  Created by Cypress on 7/28/21.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!

    var user: User! {
        didSet {
            configure()
        }
    }

    private func configure() {
        userNameLabel.text = user.username
        emailLabel.text = user.email
    }
}
