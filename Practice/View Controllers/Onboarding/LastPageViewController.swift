//
//  LastPageViewController.swift
//  Practice
//
//  Created by Cypress on 7/12/21.
//

import Foundation
import UIKit

class LastPageViewController: UIViewController {
    
    // MARK: - Actions
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        DefaultsHelper().setOnboarding(isSeen: true)
        let signInVC = UIStoryboard.main.instantiateViewController(withIdentifier: "SignInViewController")
        navigationController?.setViewControllers([signInVC], animated: true)
    }
}
