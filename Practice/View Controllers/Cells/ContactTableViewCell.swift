//
//  ContactTableViewCell.swift
//  Practice
//
//  Created by Cypress on 8/4/21.
//

import Foundation
import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var contactImageView: UIImageView!

    var contact: Contact! { didSet {
        nameLabel.text = contact.fullName
        emailLabel.text = contact.email
    }}
}

extension Contact {
    var fullName: String {
        name + " " + lastName
    }
}
