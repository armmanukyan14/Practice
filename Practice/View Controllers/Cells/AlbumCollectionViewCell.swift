//
//  AlbumCollectionViewCell.swift
//  Practice
//
//  Created by Cypress on 8/6/21.
//

import Foundation
import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!

    var imageURL: URL! { didSet {
        imageView.image = UIImage(systemName: "circle.fill")
    }}
}
