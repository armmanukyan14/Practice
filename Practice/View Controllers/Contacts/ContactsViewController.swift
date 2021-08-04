//
//  ContactsViewController.swift
//  Practice
//
//  Created by Cypress on 7/23/21.
//

import UIKit
import Contacts
import RxSwift

final class ContactsViewController: NavigationBarViewController {
    
    // MARK: - Properties
    
    private let viewModel = ContactsViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Outlets

    @IBOutlet var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doBindings()
        viewModel.refresh.accept(())
    }
    
    // MARK: - Methods

    private func doBindings() {
        viewModel.contacts
            .bind(to: tableView.rx.items) { tv, row, contact in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tv.dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseIdentifier, for: indexPath) as? ContactTableViewCell
                else { fatalError() }
                cell.contact = contact
                return cell
            }
            .disposed(by: disposeBag)
    }
}

 


