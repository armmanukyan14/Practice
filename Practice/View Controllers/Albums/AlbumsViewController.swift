//
//  AlbumsViewModel.swift
//  Practice
//
//  Created by Cypress on 8/5/21.
//

import Foundation
import RxSwift

class AlbumsViewController: NavigationBarViewController {

    private let disposeBag = DisposeBag()
    private let viewModel = AlbumsViewModel()

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        doBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.refresh.accept(())
    }

    private func doBindings() {
        bindOutputs()
    }

    private func bindOutputs() {
        viewModel.albums
            .bind(to: tableView.rx.items) { tv, row, album in
                let indexPath = IndexPath(row: row, section: 0)

                guard let cell = tv.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumCell
                else { fatalError() }

                cell.album = album
                return cell
            }
            .disposed(by: disposeBag)
    }
}
