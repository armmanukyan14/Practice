//
//  UIColor+Extension.swift
//  Practice
//
//  Created by Cypress on 7/14/21.
//

import Foundation
import UIKit

extension UIColor {
    static var placeholderColor: Self {
        .init(red: 190 / 255, green: 190 / 255, blue: 190 / 255, alpha: 1)
    }

    static var textFieldBorderColor: UIColor {
        .init(red: 200 / 255, green: 200 / 255, blue: 200 / 255, alpha: 1)
    }

    static var textColor: UIColor {
        .init(red: 215 / 255, green: 215 / 255, blue: 215 / 255, alpha: 1)
    }

    static var onboardingYellow: UIColor { .init(red: 242 / 255, green: 191 / 255, blue: 30 / 255, alpha: 1)
    }

    static var errorLabelColor: UIColor {
        .init(red: 211 / 255, green: 36 / 255, blue: 36 / 255, alpha: 1)
    }
}
