//
//  AlbumCell.swift
//  Practice
//
//  Created by Cypress on 8/5/21.
//

import Foundation
import UIKit
import Kingfisher

class AlbumCell: UITableViewCell {
    @IBOutlet private var albumTitleLabel: UILabel!
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    var album: Album! {
        didSet {
            configure()
        }
    }

    private func configure() {
        albumTitleLabel.text = album.albumTitle
        collectionView.reloadData()
    }
}

extension AlbumCell: UICollectionViewDelegate {}

