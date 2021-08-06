//
//  ContactsViewController.swift
//  Practice
//
//  Created by Cypress on 7/23/21.
//

import Contacts
import RxSwift
import UIKit

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

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    // MARK: - Methods

    private func doBindings() {
        viewModel.contacts
            .bind(to: tableView.rx.items) { tv, row, contact in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tv
                    .dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseIdentifier, for: indexPath)
                    as? ContactTableViewCell
                else { fatalError() }
                cell.contact = contact
                return cell
            }
            .disposed(by: disposeBag)
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt
                    indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
        }
        delete.image = UIImage(systemName: "trash")
        let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
        }
        edit.image = UIImage(systemName: "pencil")
        edit.backgroundColor = .purple
        let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])

        return swipeActions
    }
}
