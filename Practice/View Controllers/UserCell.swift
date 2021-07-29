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
    
    func configure(with user: User) {
        userNameLabel.text = user.username
        emailLabel.text = user.email
    }
}
