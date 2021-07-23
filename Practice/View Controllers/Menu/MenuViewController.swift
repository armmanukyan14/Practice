//
//  MenuViewController.swift
//  Practice
//
//  Created by Cypress on 7/16/21.
//

import UIKit

enum MenuType: Int {
    case users
    case contacts
    case pictures
}

class MenuViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true)
        print("Dismissed: \(menuType)")
    }
    }


    
